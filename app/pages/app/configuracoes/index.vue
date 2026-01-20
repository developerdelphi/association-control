<script setup lang="ts">
import { z } from 'zod'

definePageMeta({
  layout: 'admin-association'
})

const toast = useToast()

const state = reactive({
  name: '',
  description: '',
  cnpj: '',
  foundationDate: '',
  logo: '',
  zipCode: '',
  street: '',
  number: '',
  complement: '',
  neighborhood: '',
  city: '',
  state: ''
})

const loading = ref(false)

// Fetch initial data
const { data: associacao, refresh } = await useFetch('/api/app/configuracao')

watchEffect(() => {
  if (associacao.value) {
    state.name = associacao.value.name || ''
    state.description = associacao.value.description || ''
    state.cnpj = associacao.value.cnpj || ''
    state.foundationDate = associacao.value.foundationDate ? new Date(associacao.value.foundationDate).toISOString().split('T')[0] : ''
    state.logo = associacao.value.logo || ''
    state.zipCode = associacao.value.zipCode || ''
    state.street = associacao.value.street || ''
    state.number = associacao.value.number || ''
    state.complement = associacao.value.complement || ''
    state.neighborhood = associacao.value.neighborhood || ''
    state.city = associacao.value.city || ''
    state.state = associacao.value.state || ''
  }
})

const handleLogoUpload = (e: Event) => {
  const file = (e.target as HTMLInputElement).files?.[0]
  if (file) {
    const reader = new FileReader()
    reader.onload = (e) => {
        state.logo = e.target?.result as string
    }
    reader.readAsDataURL(file)
  }
}

const save = async () => {
  loading.value = true
  try {
    await $fetch('/api/app/configuracao', {
      method: 'PUT',
      body: state
    })
    toast.add({ title: 'Sucesso', description: 'Dados atualizados com sucesso!' })
    refresh()
  } catch (e: any) {
    toast.add({ title: 'Erro', description: e.data?.statusMessage || 'Erro ao salvar', color: 'error' })
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div>
    <PageHeader 
      title="Configurações da Associação" 
      description="Gerencie os dados cadastrais da sua associação."
    />

    <UCard class="mt-4">
      <form @submit.prevent="save" class="space-y-6">
        
        <!-- Logo Section -->
        <div class="flex items-center gap-6">
            <UAvatar :src="state.logo" :alt="state.name" size="3xl" />
            <div class="flex flex-col gap-2">
                <label class="text-sm font-medium text-gray-700 dark:text-gray-200">Logo da Associação</label>
                <input type="file" accept="image/*" @change="handleLogoUpload" class="text-sm" />
                <p class="text-xs text-gray-500">Recomendado: 200x200px (PNG/JPG)</p>
            </div>
        </div>

        <UDivider label="Dados Básicos" />

        <div class="grid grid-cols-1 md:grid-cols-12 gap-6">
          <div class="md:col-span-8">
             <UFormField label="Nome da Associação" required>
                <UInput v-model="state.name" class="w-full" />
             </UFormField>
          </div>

          <div class="md:col-span-4">
             <UFormField label="CNPJ">
                <UInput v-model="state.cnpj" v-maska="'##.###.###/####-##'" placeholder="00.000.000/0000-00" class="w-full" />
             </UFormField>
          </div>

          <div class="md:col-span-4">
              <UFormField label="Data de Fundação">
                <UInput v-model="state.foundationDate" type="date" class="w-full" />
              </UFormField>
          </div>

           <div class="md:col-span-12">
               <UFormField label="Descrição">
                <UTextarea v-model="state.description" class="w-full" :rows="3" />
              </UFormField>
           </div>
        </div>

        <UDivider label="Endereço" />

        <div class="grid grid-cols-1 md:grid-cols-12 gap-4">
             <div class="md:col-span-3">
                 <UFormField label="CEP">
                    <UInput v-model="state.zipCode" v-maska="'#####-###'" placeholder="00000-000" class="w-full" />
                </UFormField>
             </div>

             <div class="md:col-span-7">
                  <UFormField label="Logradouro">
                    <UInput v-model="state.street" class="w-full" />
                 </UFormField>
             </div>

            <div class="md:col-span-2">
                 <UFormField label="Número">
                    <UInput v-model="state.number" class="w-full" />
                 </UFormField>
            </div>

            <div class="md:col-span-4">
                 <UFormField label="Complemento">
                    <UInput v-model="state.complement" class="w-full" />
                </UFormField>
            </div>

            <div class="md:col-span-4">
                 <UFormField label="Bairro">
                    <UInput v-model="state.neighborhood" class="w-full" />
                </UFormField>
            </div>

            <div class="md:col-span-3">
                 <UFormField label="Cidade">
                    <UInput v-model="state.city" class="w-full" />
                </UFormField>
            </div>

             <div class="md:col-span-1">
                 <UFormField label="UF">
                    <UInput v-model="state.state" placeholder="UF" class="w-full" />
                </UFormField>
            </div>
        </div>

        <div class="flex justify-end pt-4">
            <UButton type="submit" :loading="loading" label="Salvar Alterações" size="lg" />
        </div>
      </form>
    </UCard>
  </div>
</template>
