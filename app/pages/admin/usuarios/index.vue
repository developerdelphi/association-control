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
  email: '',
  password: '',
  role: 'admin_associacao',
  associacaoId: undefined as string | undefined,
  status: 'pendente_aprovacao'
})

const openCreate = () => {
  isEditing.value = false
  selectedId.value = null
  state.name = ''
  state.email = ''
  state.password = ''
  state.role = 'admin_associacao'
  state.associacaoId = undefined
  state.status = 'pendente_aprovacao'
  isOpen.value = true
}

const openEdit = (row: any) => {
  isEditing.value = true
  selectedId.value = row.id
  state.name = row.name
  state.email = row.email
  state.password = ''
  state.role = row.role
  state.associacaoId = row.associacaoId || undefined
  state.status = row.status
  isOpen.value = true
}

const save = async () => {
  if (!state.name || !state.email) {
    toast.add({ title: 'Erro', description: 'Nome e Email são obrigatórios', color: 'error' })
    return
  }

  if (!isEditing.value && !state.password) {
    toast.add({ title: 'Erro', description: 'Senha é obrigatória para novos usuários', color: 'error' })
    return
  }

  try {
    const payload = { ...state }
    // Clean AssociacaoId if not selected
    if (!payload.associacaoId) payload.associacaoId = null

    if (isEditing.value && selectedId.value) {
      await $fetch(`/api/admin/usuarios/${selectedId.value}`, {
        method: 'PUT',
        body: payload
      })
      toast.add({ title: 'Sucesso', description: 'Usuário atualizado!' })
    } else {
      await $fetch('/api/admin/usuarios', {
        method: 'POST',
        body: payload
      })
      toast.add({ title: 'Sucesso', description: 'Usuário criado!' })
    }
    isOpen.value = false
    refresh()
  } catch (e: any) {
    toast.add({ title: 'Erro', description: e.data?.statusMessage || 'Erro ao salvar', color: 'error' })
  }
}

const confirmDelete = async (row: any) => {
  if (!confirm(`Tem certeza que deseja excluir ${row.name}?`)) return

  try {
    await $fetch(`/api/admin/usuarios/${row.id}`, {
      method: 'DELETE'
    })
    toast.add({ title: 'Sucesso', description: 'Usuário excluído (soft delete)!' })
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
  { 
    accessorKey: 'email', 
    header: ({ column }: any) => {
      const isSorted = column.getIsSorted()
      return h(UButton, {
        color: 'neutral',
        variant: 'ghost',
        label: 'Email',
        icon: isSorted ? (isSorted === 'asc' ? 'i-lucide-arrow-up-narrow-wide' : 'i-lucide-arrow-down-wide-narrow') : 'i-lucide-arrow-up-down',
        class: '-mx-2.5',
        onClick: () => column.toggleSorting(column.getIsSorted() === 'asc')
      })
    }
  },
  { 
    accessorKey: 'role', 
    header: ({ column }: any) => {
      const isSorted = column.getIsSorted()
      return h(UButton, {
        color: 'neutral',
        variant: 'ghost',
        label: 'Função',
        icon: isSorted ? (isSorted === 'asc' ? 'i-lucide-arrow-up-narrow-wide' : 'i-lucide-arrow-down-wide-narrow') : 'i-lucide-arrow-up-down',
        class: '-mx-2.5',
        onClick: () => column.toggleSorting(column.getIsSorted() === 'asc')
      })
    }
  },
  { 
    accessorKey: 'associacao.name', 
    header: 'Associação',
    cell: ({ row }: any) => {
      const name = row.original.associacao?.name
      return name ? h('span', name) : h('span', { class: 'text-gray-400 italic' }, 'N/A')
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

const { data: users, refresh, status } = await useFetch('/api/admin/usuarios', {
  default: () => []
})
const { data: associacoes } = await useFetch('/api/admin/associacoes', {
  default: () => []
})
const toast = useToast()

const associacoesOptions = computed(() => {
  return (associacoes.value || []).map((a: any) => ({
    label: a.name,
    value: a.id
  }))
})
</script>

<template>
  <div>
    <PageHeader 
      title="Gestão de Usuários" 
      description="Gerencie os administradores e usuários da plataforma."
    >
      <template #actions>
        <UButton icon="i-lucide-plus" label="Novo Usuário" @click="openCreate" />
      </template>
    </PageHeader>

    <UCard>
      <UTable 
        v-model:sorting="sorting"
        :data="users" 
        :columns="columns" 
        :loading="status === 'pending'"
      />
    </UCard>

    <UModal v-model:open="isOpen" :title="isEditing ? 'Editar Usuário' : 'Novo Usuário'">
      <template #body>
        <form id="user-form" @submit.prevent="save" class="space-y-4">
          <UFormField label="Nome" required>
            <UInput v-model="state.name" class="w-full" />
          </UFormField>
          
          <UFormField label="Email" required>
            <UInput v-model="state.email" type="email" class="w-full" />
          </UFormField>

          <UFormField label="Senha">
            <UInput v-model="state.password" type="password" :placeholder="isEditing ? 'Deixe em branco para manter' : '*****'" class="w-full" />
          </UFormField>

          <UFormField label="Função">
            <USelect v-model="state.role" :items="[{ label: 'Admin Associação', value: 'admin_associacao' }, { label: 'Super Admin', value: 'super_admin' }]" class="w-full" />
          </UFormField>

          <UFormField label="Associação Vinculada">
            <USelect 
              v-model="state.associacaoId" 
              :items="associacoesOptions" 
              placeholder="Selecione uma associação..." 
              class="w-full"
            />
          </UFormField>

          <UFormField label="Status">
            <USelect v-model="state.status" :items="['ativo', 'inativo', 'pendente_aprovacao']" class="w-full" />
          </UFormField>
        </form>
      </template>

      <template #footer>
        <div class="flex justify-end gap-2 w-full">
          <UButton color="neutral" variant="ghost" @click="isOpen = false">Cancelar</UButton>
          <UButton type="submit" form="user-form" color="primary">Salvar</UButton>
        </div>
      </template>
    </UModal>
  </div>
</template>
