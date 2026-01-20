<script setup lang="ts">
import { h, resolveComponent } from 'vue'

const UButton = resolveComponent('UButton')

definePageMeta({
  layout: 'admin-association'
})

const r = useRouter()

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
  { accessorKey: 'name', header: 'Nome' },
  { accessorKey: 'registerNumber', header: 'Matrícula' },
  { accessorKey: 'type', header: 'Tipo' },
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

const { data: associados, refresh, status } = await useFetch('/api/app/associados', {
  default: () => []
})
</script>

<template>
  <div>
    <div class="flex justify-between items-center mb-6">
      <h1 class="text-2xl font-bold">Associados</h1>
      <UButton icon="i-lucide-plus" label="Novo Associado" @click="openCreate" />
    </div>

    <UCard>
      <UTable 
        :data="associados" 
        :columns="columns"
        :loading="status === 'pending'" 
      />
    </UCard>
  </div>
</template>
