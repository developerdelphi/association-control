<script setup lang="ts">
import { h, resolveComponent } from 'vue'

const UButton = resolveComponent('UButton')

definePageMeta({
  layout: 'admin-association'
})

const r = useRouter()
const sorting = ref([])

const openCreate = () => {
    r.push('/app/associados/novo')
}

const openEdit = (row: any) => {
    r.push(`/app/associados/${row.id}`)
}

const confirmDelete = async (row: any) => {
  if (!confirm(`Tem certeza que deseja excluir ${row.name}?`)) return
  
  try {
    await $fetch(`/api/app/associados/${row.id}`, {
      method: 'DELETE'
    })
    refresh()
    // Optional: Toast success
  } catch (e) {
    alert('Erro ao excluir associado')
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
  { 
    accessorKey: 'registerNumber', 
    header: ({ column }: any) => {
      const isSorted = column.getIsSorted()
      return h(UButton, {
        color: 'neutral',
        variant: 'ghost',
        label: 'Matrícula',
        icon: isSorted ? (isSorted === 'asc' ? 'i-lucide-arrow-up-narrow-wide' : 'i-lucide-arrow-down-wide-narrow') : 'i-lucide-arrow-up-down',
        class: '-mx-2.5',
        onClick: () => column.toggleSorting(column.getIsSorted() === 'asc')
      })
    }
  },
  { 
    accessorKey: 'type', 
    header: ({ column }: any) => {
      const isSorted = column.getIsSorted()
      return h(UButton, {
        color: 'neutral',
        variant: 'ghost',
        label: 'Tipo',
        icon: isSorted ? (isSorted === 'asc' ? 'i-lucide-arrow-up-narrow-wide' : 'i-lucide-arrow-down-wide-narrow') : 'i-lucide-arrow-up-down',
        class: '-mx-2.5',
        onClick: () => column.toggleSorting(column.getIsSorted() === 'asc')
      })
    }
  },
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
        icon: 'i-heroicons-document-text',
        size: 'xs',
        color: 'gray',
        variant: 'ghost',
        to: `/app/associados/${row.original.id}/ficha`
      }),
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
    page.value = 1
  }, 500)
})

const { data: associados, refresh, status } = await useFetch('/api/app/associados', {
  query: {
    page,
    pageSize: pageCount,
    search: searchDebounced
  },
  default: () => ({ data: [], total: 0, page: 1, pageSize: 10, totalPages: 0 })
})

watch([page, pageCount, searchDebounced], () => {
  refresh()
})

watch(pageCount, () => {
    page.value = 1
})
</script>

<template>
  <div>
    <PageHeader 
        title="Associados" 
        description="Lista de todos os associados vinculados."
    >
        <template #actions>
            <UButton icon="i-lucide-plus" label="Novo Associado" @click="openCreate" />
        </template>
    </PageHeader>

    <div class="flex flex-col gap-4">
      <div class="flex justify-between items-center gap-4">
        <UInput v-model="search" icon="i-lucide-search" placeholder="Buscar por Nome ou Matrícula..." class="w-full md:w-64" />
      </div>

      <UCard>
        <Transition name="table-fade" mode="out-in">
          <div :key="page">
            <UTable 
              v-model:sorting="sorting"
              :data="associados?.data || []" 
              :columns="columns"
              :loading="status === 'pending'" 
            />
          </div>
        </Transition>
        
        <div 
          class="flex justify-between items-center px-4 py-3 border-t"
        >
          <UPagination v-model:page="page" :page-count="pageCount" :total="associados?.total || 0" />
        </div>
      </UCard>
    </div>
  </div>
</template>
