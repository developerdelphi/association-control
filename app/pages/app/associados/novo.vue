<script setup lang="ts">
import { definePageMeta } from '#imports'
import { validateCPF } from '~/utils/validators'

definePageMeta({
  layout: 'admin-association'
})

const router = useRouter()
const toast = useToast()

const state = reactive({
  name: '',
  description: '',
  type: 'Sócio',
  entryDate: new Date().toISOString().split('T')[0],
  quote: 0,
  
  // Qualification
  qualificacao: {
      cpf: '',
      rg: '',
      birthdate: '',
      profession: '',
      sex: '',
      nationality: 'Brasileira',
      civilStatus: 'Solteiro(a)'
  },
  
  // Contacts (Array)
  contatos: [] as any[],
  
  // Address (Array)
  enderecos: [] as any[]
})

// Helpers for contacts
const addContact = () => {
    state.contatos.push({ type: 'telefone_celular', value: '', status: 'ativo', isPrimary: state.contatos.length === 0 })
}
const removeContact = (index: number) => {
    state.contatos.splice(index, 1)
}

// Helpers for address
const addAddress = () => {
    state.enderecos.push({ 
        logradouro: '', numero: '', complemento: '', bairro: '', cep: '', cidade: '', uf: '', pais: 'Brasil', status: 'ativo', isPrimary: state.enderecos.length === 0 
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
  
  // Date Validation
  const today = new Date().toISOString().split('T')[0]
  if (state.entryDate < '2023-01-01') {
      toast.add({ title: 'Erro', description: 'Data de admissão deve ser a partir de 2023', color: 'error' })
      return
  }
  if (state.entryDate > today) {
      toast.add({ title: 'Erro', description: 'Data de admissão não pode ser futura', color: 'error' })
      return
  }
  if (state.qualificacao.birthdate && state.qualificacao.birthdate > today) {
     toast.add({ title: 'Erro', description: 'Data de nascimento não pode ser futura', color: 'error' })
     return
  }

  // CPF Validation
  if (state.qualificacao.cpf && !validateCPF(state.qualificacao.cpf)) {
      toast.add({ title: 'Erro', description: 'CPF inválido', color: 'error' })
      return
  }

  try {
      await $fetch('/api/app/associados', {
          method: 'POST',
          body: state
      })
      toast.add({ title: 'Sucesso', description: 'Associado cadastrado!' })
      router.push('/app/associados')
  } catch (e: any) {
      toast.add({ title: 'Erro', description: e.data?.statusMessage || 'Erro ao salvar', color: 'error' })
  }
}
</script>

<template>
  <div class="max-w-4xl mx-auto">
    <PageHeader 
        title="Novo Associado" 
        description="Cadastre um novo associado no sistema."
    >
        <template #actions>
            <UButton label="Voltar" variant="ghost" to="/app/associados" />
        </template>
    </PageHeader>

    <form @submit.prevent="save" class="space-y-6">
      
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
              <UFormField label="Data de Admissão" required>
                  <UInput v-model="state.entryDate" type="date" min="2023-01-01" :max="new Date().toISOString().split('T')[0]" class="w-full" />
              </UFormField>
              <UFormField label="Quota">
                  <UInput v-model="state.quote" type="number" step="0.01" class="w-full" />
              </UFormField>
          </div>
      </UCard>

      <!-- Qualificação -->
      <UCard>
          <template #header><h3 class="font-bold">Qualificação Civil</h3></template>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
              <UFormField label="CPF">
                  <UInput v-model="state.qualificacao.cpf" v-maska="'###.###.###-##'" placeholder="000.000.000-00" class="w-full" />
              </UFormField>
              <UFormField label="RG">
                  <UInput v-model="state.qualificacao.rg" class="w-full" />
              </UFormField>
              <UFormField label="Data de Nascimento">
                  <UInput v-model="state.qualificacao.birthdate" type="date" :max="new Date().toISOString().split('T')[0]" class="w-full" />
              </UFormField>
              <UFormField label="Sexo">
                  <USelect v-model="state.qualificacao.sex" :items="['Masculino', 'Feminino']" class="w-full" />
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
                  <USelect 
                    v-model="contact.type" 
                    :items="[
                        { label: 'Celular', value: 'telefone_celular' },
                        { label: 'Telefone Residencial', value: 'telefone_residencial' },
                        { label: 'Telefone Comercial', value: 'telefone_comercial' },
                        { label: 'Email', value: 'email' }
                    ]"
                    class="w-full" 
                  />
              </UFormField>
              <UFormField label="Descrição" class="flex-1">
                  <UInput v-model="contact.value" v-maska="contact.type.includes('telefone') || contact.type === 'celular' ? '(##) #####-####' : ''" class="w-full" />
              </UFormField>
              <UFormField label="Status" class="w-1/4">
                  <USelect v-model="contact.status" :items="['ativo', 'inativo']" class="w-full" />
              </UFormField>
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
              <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                  <UFormField label="CEP">
                      <UInput v-model="addr.cep" v-maska="'#####-###'" class="w-full" />
                  </UFormField>
                  <UFormField label="Logradouro" class="md:col-span-3">
                      <UInput v-model="addr.logradouro" class="w-full" />
                  </UFormField>
                  <UFormField label="Número">
                      <UInput v-model="addr.numero" class="w-full" />
                  </UFormField>
                  <UFormField label="Complemento">
                      <UInput v-model="addr.complemento" class="w-full" />
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
                  <UFormField label="País">
                      <UInput v-model="addr.pais" class="w-full" />
                  </UFormField>
                  <UFormField label="Status">
                      <USelect v-model="addr.status" :items="['ativo', 'inativo']" class="w-full" />
                  </UFormField>
              </div>
          </div>
          <p v-if="state.enderecos.length === 0" class="text-gray-400 text-sm italic">Nenhum endereço adicionado.</p>
      </UCard>

      <div class="flex justify-end gap-4 pb-8">
          <UButton to="/app/associados" color="gray" variant="ghost">Cancelar</UButton>
          <UButton type="submit" size="lg">Salvar Associado</UButton>
      </div>

    </form>
  </div>
</template>
