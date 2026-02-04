<script setup lang="ts">
import { definePageMeta } from '#imports'
import { validateCPF } from '~/utils/validators'
import { fetchCEP } from '~/utils/cep'

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
  photo: '', // Base64 Photo
  
  exitDate: '', // Data de Desligamento

  // Qualification
  qualificacao: {
      cpf: '',
      rg: '',
      birthdate: '',
      profession: '',
      sex: '',
      nationality: 'Brasileira',
      civilStatus: 'Solteiro(a)',
      isForeigner: false,
      country: 'Brasil',
      rne: '',
      fatherName: '',
      motherName: '',
      spouseName: ''
  },
  
  // Banking Data
  dadosBancarios: {
      bdmDigitalAccount: '',
      bank: '',
      agency: '',
      accountNumber: ''
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

const handleCepLookup = async (index: number) => {
    const addr = state.enderecos[index]
    if (!addr.cep) return
    
    const cleanCep = addr.cep.replace(/\D/g, '')
    if (cleanCep.length === 8) {
        const data = await fetchCEP(cleanCep)
        if (data) {
            addr.logradouro = data.logradouro
            addr.bairro = data.bairro
            addr.cidade = data.localidade
            addr.uf = data.uf
        }
    }
}

const onFileChange = (e: any) => {
    const file = e.target.files[0]
    if (file) {
        const reader = new FileReader()
        reader.onload = (e) => {
            state.photo = e.target?.result as string
        }
        reader.readAsDataURL(file)
    }
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
  
  if (state.exitDate && state.exitDate > today) {
      toast.add({ title: 'Erro', description: 'Data de desligamento não pode ser futura', color: 'error' })
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

  // Contatos Validation
  for (const contact of state.contatos) {
      if (!contact.value || contact.value.trim() === '') {
          toast.add({ title: 'Erro', description: 'Todos os contatos adicionados devem ser preenchidos.', color: 'error' })
          return
      }
  }

  // Endereços Validation
  for (const addr of state.enderecos) {
      if (!addr.logradouro || !addr.cidade || !addr.cep) {
          toast.add({ title: 'Erro', description: 'Endereços devem ter logradouro, cidade e CEP preenchidos.', color: 'error' })
          return
      }
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
          <div class="flex gap-4 items-start mb-4">
               <UAvatar :src="state.photo" size="3xl" alt="Foto do Associado" />
               <div class="flex-1">
                   <label class="block text-sm font-medium text-gray-700 dark:text-gray-200 mb-1">Foto do Associado</label>
                   <input type="file" @change="onFileChange" accept="image/*" class="block w-full text-sm text-gray-500
      file:mr-4 file:py-2 file:px-4
      file:rounded-full file:border-0
      file:text-sm file:font-semibold
      file:bg-primary-50 file:text-primary-700
      hover:file:bg-primary-100
    "/>
               </div>
          </div>
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
              
              <UFormField label="Data de Desligamento">
                  <UInput v-model="state.exitDate" type="date" :max="new Date().toISOString().split('T')[0]" class="w-full" />
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
              
              <!-- Nacionalidade e Estrangeiro -->
              <div class="flex gap-4">
                 <UFormField label="Nacionalidade" class="flex-1">
                    <UInput v-model="state.qualificacao.nationality" class="w-full" />
                 </UFormField>
                 <UFormField label="Estrangeiro?" class="w-auto flex items-end pb-2">
                      <UCheckbox v-model="state.qualificacao.isForeigner" />
                  </UFormField>
              </div>
              
              <UFormField label="País de Origem" v-if="state.qualificacao.isForeigner">
                  <UInput v-model="state.qualificacao.country" class="w-full" />
              </UFormField>
              
               <UFormField label="RNE" v-if="state.qualificacao.isForeigner">
                  <UInput v-model="state.qualificacao.rne" class="w-full" />
              </UFormField>

              <UFormField label="Nome do Pai">
                    <UInput v-model="state.qualificacao.fatherName" class="w-full" />
              </UFormField>
              
               <UFormField label="Nome da Mãe">
                    <UInput v-model="state.qualificacao.motherName" class="w-full" />
              </UFormField>
              
              <UFormField label="Nome do Cônjuge">
                    <UInput v-model="state.qualificacao.spouseName" class="w-full" />
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
              <UButton 
                icon="i-lucide-trash" 
                color="error" 
                variant="ghost" 
                size="xs" 
                class="mb-1"
                @click="removeContact(index)"
              />
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
              <UButton 
                icon="i-lucide-trash" 
                color="error" 
                variant="ghost" 
                size="xs" 
                class="absolute top-2 right-2"
                @click="removeAddress(index)"
              />
              <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                   <UFormField label="CEP">
                       <UInput v-model="addr.cep" v-maska="'#####-###'" class="w-full" @input="handleCepLookup(index)" />
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

       <!-- Dados Bancários -->
      <UCard>
          <template #header><h3 class="font-bold">Dados Bancários</h3></template>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
              <UFormField label="Conta BDM Digital (Email)" class="md:col-span-3">
                  <UInput v-model="state.dadosBancarios.bdmDigitalAccount" type="email" placeholder="email@exemplo.com" class="w-full" />
              </UFormField>

               <UFormField label="Banco">
                  <UInput v-model="state.dadosBancarios.bank" class="w-full" />
              </UFormField>
              
               <UFormField label="Agência">
                  <UInput v-model="state.dadosBancarios.agency" class="w-full" />
              </UFormField>
              
               <UFormField label="Conta Corrente">
                  <UInput v-model="state.dadosBancarios.accountNumber" class="w-full" />
              </UFormField>
          </div>
      </UCard>

      <div class="flex justify-end gap-4 pb-8">
          <UButton to="/app/associados" color="gray" variant="ghost">Cancelar</UButton>
          <UButton type="submit" size="lg">Salvar Associado</UButton>
      </div>

    </form>
  </div>
</template>
