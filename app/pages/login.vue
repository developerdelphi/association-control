<script setup lang="ts">
const email = ref('')
const password = ref('')
const loading = ref(false)
const toast = useToast()
const router = useRouter()

async function handleLogin() {
  loading.value = true
  try {
    const { user } = await $fetch('/api/auth/login', {
      method: 'POST',
      body: { email: email.value, password: password.value }
    })
    
    toast.add({ title: 'Sucesso', description: 'Login realizado com sucesso!' })
    
    if (user.role === 'super_admin') {
      router.push('/admin/dashboard')
    } else {
      router.push('/app/dashboard')
    }
  } catch (error: any) {
    toast.add({ 
      title: 'Erro', 
      description: error.data?.statusMessage || 'Falha ao realizar login',
      color: 'error'
    })
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="min-h-screen flex items-center justify-center bg-neutral-50 dark:bg-neutral-900">
    <UCard class="w-full max-w-md">
      <template #header>
        <div class="text-center">
          <h1 class="text-xl font-bold">Sistema de Associações</h1>
          <p class="text-sm text-neutral-500">Faça login para continuar</p>
        </div>
      </template>

      <form @submit.prevent="handleLogin" class="space-y-4">
        <div class="flex flex-col gap-2">
           <label class="text-sm font-medium">Email</label>
           <UInput v-model="email" type="email" placeholder="seu@email.com" icon="i-lucide-mail" class="w-full" />
        </div>

        <div class="flex flex-col gap-2">
           <label class="text-sm font-medium">Senha</label>
           <UInput v-model="password" type="password" placeholder="********" icon="i-lucide-lock" class="w-full" />
        </div>

        <UButton type="submit" block :loading="loading" color="primary" class="w-full justify-center">
          Entrar
        </UButton>
      </form>
    </UCard>
  </div>
</template>
