<template>
  <div class="flex min-h-screen bg-gray-100">
    <aside class="w-64 bg-gray-900 text-white p-4">
      <h2 class="text-xl font-bold mb-6">Super Admin</h2>
      <nav class="space-y-2">
        <NuxtLink to="/admin/dashboard" class="block py-2 hover:text-gray-300">Dashboard</NuxtLink>
        <NuxtLink to="/admin/associacoes" class="block py-2 hover:text-gray-300">Associações</NuxtLink>
        <NuxtLink to="/admin/usuarios" class="block py-2 hover:text-gray-300">Usuários Sistema</NuxtLink>
        <button @click="logout" class="block py-2 text-red-400 hover:text-red-300 w-full text-left">Sair</button>
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
