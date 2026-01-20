<script setup lang="ts">
definePageMeta({
  layout: 'admin-platform' // We will create this layout later
})
</script>

<template>
  <div>
    <PageHeader 
      title="Painel Super Admin" 
      description="Bem-vindo ao gerenciamento da plataforma."
    />
    
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <StatsCard
        title="Associações"
        value="-"
        icon="i-lucide-building-2"
        color="primary"
      />
      <StatsCard
        title="Usuários Sistema"
        value="-"
        icon="i-lucide-users"
        color="secondary"
      />
    </div>
  </div>
</template>
