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
const sorting = ref([])

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
  { 
    accessorKey: 'name', 
    header: ({ column }: any) => {
      const isSorted = column.getIsSorted()
      return h(UButton, {
        color: 'neutral',
        variant: 'ghost',
        label: 'Nome',
        icon: isSorted ? (isSorted === 'asc' ? 'i-lucide-arrow-up-narrow-wide' : 'i-lucide-arrow-down-wide-narrow') : 'i-lucide-arrow-up-down',
        class: '-mx-2.5',
        onClick: () => column.toggleSorting(column.getIsSorted() === 'asc')
      })
    }
  },
  { accessorKey: 'description', header: 'Descrição' },
  { 
    accessorKey: 'status', 
    header: ({ column }: any) => {
      const isSorted = column.getIsSorted()
      return h(UButton, {
        color: 'neutral',
        variant: 'ghost',
        label: 'Status',
        icon: isSorted ? (isSorted === 'asc' ? 'i-lucide-arrow-up-narrow-wide' : 'i-lucide-arrow-down-wide-narrow') : 'i-lucide-arrow-up-down',
        class: '-mx-2.5',
        onClick: () => column.toggleSorting(column.getIsSorted() === 'asc')
      })
    }
  },
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

const page = ref(1)
const pageCount = ref(10)
const search = ref('')

// Debounce search
const searchDebounced = ref('')
let timeout: NodeJS.Timeout
watch(search, (newVal) => {
  clearTimeout(timeout)
  timeout = setTimeout(() => {
    searchDebounced.value = newVal
    page.value = 1 // Reset to first page on search
  }, 500)
})

const { data: associacoes, refresh, status } = await useFetch('/api/admin/associacoes', {
  query: {
    page,
    pageSize: pageCount,
    search: searchDebounced
  },
  default: () => ({ data: [], total: 0, page: 1, pageSize: 10, totalPages: 0 })
})
const toast = useToast()

</script>

<template>
  <div>
    <PageHeader 
      title="Gestão de Associações" 
      description="Gerencie as associações cadastradas na plataforma."
    >
      <template #actions>
        <UButton icon="i-lucide-plus" label="Nova Associação" @click="openCreate" />
      </template>
    </PageHeader>

    <div class="flex flex-col gap-4">
      <div class="flex justify-between items-center gap-4">
        <UInput v-model="search" icon="i-lucide-search" placeholder="Buscar..." class="w-full md:w-64" />
      </div>

      <UCard>
        <UTable 
          v-model:sorting="sorting"
          :data="associacoes?.data || []" 
          :columns="columns"
          :loading="status === 'pending'"
        />
        <div class="flex justify-between items-center px-4 py-3 border-t">
          <span class="text-sm text-gray-500">
            Total: {{ associacoes?.total || 0 }}
          </span>
          <UPagination v-model="page" :page-count="pageCount" :total="associacoes?.total || 0" />
        </div>
      </UCard>
    </div>

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
