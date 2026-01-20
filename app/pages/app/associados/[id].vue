<script setup lang="ts">
import { definePageMeta } from '#imports'

definePageMeta({
  layout: 'admin-association'
})

const route = useRoute()
const router = useRouter()
const toast = useToast()

const id = route.params.id

// Fetch data
const { data: associado, pending } = await useFetch(`/api/app/associados/${id}`)

const state = reactive({
  name: '',
  description: '',
  type: 'Sócio',
  entryDate: '',
  quote: 0,
  status: 'ativo',
  
  qualificacao: {
      cpf: '',
      rg: '',
      birthdate: '',
      profession: '',
      nationality: 'Brasileira',
      civilStatus: 'Solteiro(a)'
  },
  
  contatos: [] as any[],
  enderecos: [] as any[]
})

// Populate state when data is loaded
watchEffect(() => {
    if (associado.value) {
        const data = associado.value
        state.name = data.name
        state.type = data.type
        state.entryDate = data.entryDate ? new Date(data.entryDate).toISOString().split('T')[0] : ''
        state.quote = data.quote
        state.status = data.status || 'ativo'
        
        if (data.qualificacao) {
            state.qualificacao.cpf = data.qualificacao.cpf || ''
            state.qualificacao.rg = data.qualificacao.rg || ''
            state.qualificacao.birthdate = data.qualificacao.birthdate ? new Date(data.qualificacao.birthdate).toISOString().split('T')[0] : ''
            state.qualificacao.profession = data.qualificacao.profession || ''
            state.qualificacao.nationality = data.qualificacao.nationality || 'Brasileira'
            state.qualificacao.civilStatus = data.qualificacao.civilStatus || 'Solteiro(a)'
        }
        
        if (data.contatos) {
            state.contatos = data.contatos.map((c: any) => ({ ...c }))
        } else {
            state.contatos = []
        }

        if (data.enderecos) {
            state.enderecos = data.enderecos.map((e: any) => ({ ...e }))
        } else {
            state.enderecos = []
        }
    }
})

// Helpers for contacts
const addContact = () => {
    state.contatos.push({ type: 'telefone_celular', value: '', isPrimary: state.contatos.length === 0 })
}
const removeContact = (index: number) => {
    state.contatos.splice(index, 1)
}

// Helpers for address
const addAddress = () => {
    state.enderecos.push({ 
        logradouro: '', numero: '', bairro: '', cep: '', cidade: '', uf: '', isPrimary: state.enderecos.length === 0 
    })
}
const removeAddress = (index: number) => {
    state.enderecos.splice(index, 1)
}

const save = async () => {
  if (!state.name) {
      toast.add({ title: 'Erro', description: 'Nome é obrigatório', color: 'error' })
      return
  }

  try {
      await $fetch(`/api/app/associados/${id}`, {
          method: 'PUT',
          body: state
      })
      toast.add({ title: 'Sucesso', description: 'Associado atualizado!' })
      router.push('/app/associados')
  } catch (e: any) {
      toast.add({ title: 'Erro', description: e.data?.statusMessage || 'Erro ao salvar', color: 'error' })
  }
}
</script>

<template>
  <div class="max-w-4xl mx-auto">
    <PageHeader 
        title="Editar Associado" 
        description="Atualize os dados do associado."
    >
        <template #actions>
            <UButton label="Voltar" variant="ghost" to="/app/associados" />
        </template>
    </PageHeader>

    <div v-if="pending" class="flex justify-center py-8">
        <UIcon name="i-lucide-loader-2" class="animate-spin text-2xl" />
    </div>

    <form v-else @submit.prevent="save" class="space-y-6">
      
      <!-- Dados Básicos -->
      <UCard>
          <template #header><h3 class="font-bold">Dados Básicos</h3></template>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <UFormField label="Nome Completo" required>
                  <UInput v-model="state.name" class="w-full" />
              </UFormField>
              <UFormField label="Tipo de Associado" required>
                  <USelect v-model="state.type" :items="['Fundador', 'Sócio', 'Honorário', 'Benemérito']" class="w-full" />
              </UFormField>
              <UFormField label="Status" required>
                  <USelect v-model="state.status" :items="['ativo', 'inativo', 'pendente', 'suspenso']" class="w-full" />
              </UFormField>
              <UFormField label="Data de Admissão" required>
                  <UInput v-model="state.entryDate" type="date" class="w-full" />
              </UFormField>
              <UFormField label="Valor da Cota (Mensal)">
                  <UInput v-model="state.quote" type="number" step="0.01" class="w-full" />
              </UFormField>
          </div>
      </UCard>

      <!-- Qualificação -->
      <UCard>
          <template #header><h3 class="font-bold">Qualificação Civil</h3></template>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
              <UFormField label="CPF">
                  <UInput v-model="state.qualificacao.cpf" placeholder="000.000.000-00" class="w-full" />
              </UFormField>
              <UFormField label="RG">
                  <UInput v-model="state.qualificacao.rg" class="w-full" />
              </UFormField>
              <UFormField label="Data de Nascimento">
                  <UInput v-model="state.qualificacao.birthdate" type="date" class="w-full" />
              </UFormField>
              <UFormField label="Profissão">
                    <UInput v-model="state.qualificacao.profession" class="w-full" />
              </UFormField>
              <UFormField label="Nacionalidade">
                    <UInput v-model="state.qualificacao.nationality" class="w-full" />
              </UFormField>
              <UFormField label="Estado Civil">
                    <USelect v-model="state.qualificacao.civilStatus" :items="['Solteiro(a)', 'Casado(a)', 'Divorciado(a)', 'Viúvo(a)', 'União Estável']" class="w-full" />
              </UFormField>
          </div>
      </UCard>

      <!-- Contatos -->
      <UCard>
          <template #header>
              <div class="flex justify-between items-center">
                  <h3 class="font-bold">Contatos</h3>
                  <UButton size="xs" icon="i-lucide-plus" @click="addContact">Adicionar</UButton>
              </div>
          </template>
          
          <div v-for="(contact, index) in state.contatos" :key="index" class="flex gap-4 mb-2 items-end">
              <UFormField label="Tipo" class="w-1/3">
                  <USelect v-model="contact.type" :items="['telefone_celular', 'telefone_residencial', 'email', 'telefone_comercial']" class="w-full" />
              </UFormField>
              <UFormField label="Valor" class="flex-1">
                  <UInput v-model="contact.value" class="w-full" />
              </UFormField>
              <UButton color="red" variant="ghost" icon="i-lucide-trash" @click="removeContact(index)" />
          </div>
          <p v-if="state.contatos.length === 0" class="text-gray-400 text-sm italic">Nenhum contato adicionado.</p>
      </UCard>

      <!-- Endereços -->
      <UCard>
          <template #header>
              <div class="flex justify-between items-center">
                  <h3 class="font-bold">Endereços</h3>
                  <UButton size="xs" icon="i-lucide-plus" @click="addAddress">Adicionar</UButton>
              </div>
          </template>
          
          <div v-for="(addr, index) in state.enderecos" :key="index" class="p-4 border rounded mb-4 relative">
              <UButton color="red" variant="ghost" icon="i-lucide-trash" class="absolute top-2 right-2" @click="removeAddress(index)" />
              <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                  <UFormField label="CEP">
                      <UInput v-model="addr.cep" class="w-full" />
                  </UFormField>
                  <UFormField label="Logradouro" class="md:col-span-3">
                      <UInput v-model="addr.logradouro" class="w-full" />
                  </UFormField>
                  <UFormField label="Número">
                      <UInput v-model="addr.numero" class="w-full" />
                  </UFormField>
                  <UFormField label="Bairro">
                      <UInput v-model="addr.bairro" class="w-full" />
                  </UFormField>
                  <UFormField label="Cidade">
                      <UInput v-model="addr.cidade" class="w-full" />
                  </UFormField>
                  <UFormField label="UF">
                      <UInput v-model="addr.uf" class="w-full" />
                  </UFormField>
              </div>
          </div>
          <p v-if="state.enderecos.length === 0" class="text-gray-400 text-sm italic">Nenhum endereço adicionado.</p>
      </UCard>

      <div class="flex justify-end gap-4 pb-8">
          <UButton to="/app/associados" color="gray" variant="ghost">Cancelar</UButton>
          <UButton type="submit" size="lg">Salvar Alterações</UButton>
      </div>

    </form>
  </div>
</template>
