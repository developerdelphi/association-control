<script setup lang="ts">
import { h, resolveComponent } from 'vue'

const UButton = resolveComponent('UButton')

definePageMeta({
  layout: 'admin-platform'
})

// Modal State
const isOpen = ref(false)
const isEditing = ref(false)
const selectedId = ref<string | null>(null)

const state = reactive({
  name: '',
  description: '',
  status: 'ativo'
})

const openCreate = () => {
  isEditing.value = false
  selectedId.value = null
  state.name = ''
  state.description = ''
  state.status = 'ativo'
  isOpen.value = true
}

const openEdit = (row: any) => {
  isEditing.value = true
  selectedId.value = row.id
  state.name = row.name
  state.description = row.description
  state.status = row.status
  isOpen.value = true
}

const save = async () => {
  if (!state.name) {
    toast.add({ title: 'Erro', description: 'Nome é obrigatório', color: 'error' })
    return
  }

  try {
    if (isEditing.value && selectedId.value) {
      await $fetch(`/api/admin/associacoes/${selectedId.value}`, {
        method: 'PUT',
        body: state
      })
      toast.add({ title: 'Sucesso', description: 'Associação atualizada!' })
    } else {
      await $fetch('/api/admin/associacoes', {
        method: 'POST',
        body: state
      })
      toast.add({ title: 'Sucesso', description: 'Associação criada!' })
    }
    isOpen.value = false
    refresh()
  } catch (e: any) {
    toast.add({ title: 'Erro', description: e.data?.statusMessage || 'Erro ao salvar', color: 'error' })
  }
}

const confirmDelete = async (row: any) => {
  if (!confirm(`Tem certeza que deseja excluir ${row.name}? Esta ação é irreversível.`)) return

  try {
    await $fetch(`/api/admin/associacoes/${row.id}`, {
      method: 'DELETE'
    })
    toast.add({ title: 'Sucesso', description: 'Associação excluída!' })
    refresh()
  } catch (e: any) {
    toast.add({ title: 'Erro', description: 'Erro ao excluir', color: 'error' })
  }
}

const columns = [
  { accessorKey: 'name', header: 'Nome' },
  { accessorKey: 'description', header: 'Descrição' },
  { accessorKey: 'status', header: 'Status' },
  { 
    id: 'actions', 
    header: 'Ações',
    cell: ({ row }: any) => h('div', { class: 'flex gap-2' }, [
      h(UButton, {
        icon: 'i-lucide-edit',
        size: 'xs',
        color: 'gray',
        variant: 'ghost',
        onClick: () => openEdit(row.original)
      }),
      h(UButton, {
        icon: 'i-lucide-trash',
        size: 'xs',
        color: 'red',
        variant: 'ghost',
        onClick: () => confirmDelete(row.original)
      })
    ])
  }
]

const { data: associacoes, refresh, status } = await useFetch('/api/admin/associacoes', {
  default: () => []
})
const toast = useToast()

</script>

<template>
  <div>
    <div class="flex justify-between items-center mb-6">
      <h1 class="text-2xl font-bold">Gestão de Associações</h1>
      <UButton icon="i-lucide-plus" label="Nova Associação" @click="openCreate" />
    </div>

    <UCard>
      <UTable 
        :data="associacoes" 
        :columns="columns"
        :loading="status === 'pending'"
      />
    </UCard>

    <UModal v-model:open="isOpen" :title="isEditing ? 'Editar Associação' : 'Nova Associação'">
      <template #body>
        <form id="association-form" @submit.prevent="save" class="space-y-4">
          <UFormField label="Nome" required>
            <UInput v-model="state.name" class="w-full" />
          </UFormField>
          
          <UFormField label="Descrição">
            <UTextarea v-model="state.description" class="w-full" />
          </UFormField>

          <UFormField label="Status">
            <USelect v-model="state.status" :items="['ativo', 'inativo', 'pendente']" class="w-full" />
          </UFormField>
        </form>
      </template>

      <template #footer>
        <div class="flex justify-end gap-2 w-full">
          <UButton color="neutral" variant="ghost" @click="isOpen = false">Cancelar</UButton>
          <UButton type="submit" form="association-form" color="primary">Salvar</UButton>
        </div>
      </template>
    </UModal>
  </div>
</template>
