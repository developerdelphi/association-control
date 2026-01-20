<template>
  <div class="flex min-h-screen bg-gray-50">
    <aside class="w-64 bg-white border-r p-4">
      <h2 class="text-xl font-bold mb-6 text-primary">Associação</h2>
      <nav class="space-y-2">
        <NuxtLink to="/app/dashboard" class="block py-2 hover:bg-gray-100 rounded px-2">Dashboard</NuxtLink>
        <NuxtLink to="/app/associados" class="block py-2 hover:bg-gray-100 rounded px-2">Associados</NuxtLink>
        <NuxtLink to="/app/financeiro" class="block py-2 hover:bg-gray-100 rounded px-2">Financeiro</NuxtLink>
        <button @click="logout" class="block py-2 text-red-500 hover:bg-red-50 rounded px-2 w-full text-left mt-4">Sair</button>
      </nav>
    </aside>
    <main class="flex-1 p-8">
      <slot />
    </main>
  </div>
</template>

<script setup lang="ts">
const { logout } = useUserSession()
</script>
