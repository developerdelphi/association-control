<script setup lang="ts">
const links = [
  { label: 'Dashboard', to: '/admin/dashboard', icon: 'i-lucide-layout-dashboard' },
  { label: 'Associações', to: '/admin/associacoes', icon: 'i-lucide-building-2' },
  { label: 'Usuários Sistema', to: '/admin/usuarios', icon: 'i-lucide-users' }
]
</script>

<template>
  <div class="flex min-h-screen bg-gray-50 dark:bg-gray-950">
    <AppSidebar title="Super Admin" :links="links" />
    
    <main class="flex-1 p-8 overflow-y-auto">
      <slot />
    </main>
  </div>
</template>
