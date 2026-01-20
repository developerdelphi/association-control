<script setup lang="ts">
const links = [
  { label: 'Dashboard', to: '/app/dashboard', icon: 'i-lucide-layout-dashboard' },
  { label: 'Associados', to: '/app/associados', icon: 'i-lucide-users' }
]
</script>

<template>
  <div class="flex min-h-screen bg-gray-50 dark:bg-gray-950">
    <AppSidebar title="Associação" :links="links" />
    
    <main class="flex-1 p-8 overflow-y-auto">
      <slot />
    </main>
  </div>
</template>
