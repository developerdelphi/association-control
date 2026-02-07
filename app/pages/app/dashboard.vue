<script setup lang="ts">
definePageMeta({
  layout: 'admin-association'
})

const { data: metrics } = await useFetch('/api/app/metrics')
</script>

<template>
  <div>
    <PageHeader 
      title="Visão Geral" 
      description="Resumo da associação"
    />
    
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <motion.div
        :initial="{ opacity: 0, y: 20 }"
        :animate="{ opacity: 1, y: 0 }"
        :transition="{ delay: 0.1 }"
      >
        <StatsCard
          title="Total de Associados"
          :value="metrics?.totalAssociates || 0"
          icon="i-lucide-users"
          color="primary"
        />
      </motion.div>

      <motion.div
        :initial="{ opacity: 0, y: 20 }"
        :animate="{ opacity: 1, y: 0 }"
        :transition="{ delay: 0.2 }"
      >
        <StatsCard
          title="Receita Mensal"
          value="R$ 0,00"
          icon="i-lucide-dollar-sign"
          color="green"
        />
      </motion.div>
      
      <motion.div
        :initial="{ opacity: 0, y: 20 }"
        :animate="{ opacity: 1, y: 0 }"
        :transition="{ delay: 0.3 }"
      >
        <StatsCard
          title="Pagamentos Pendentes"
          value="0"
          icon="i-lucide-alert-circle"
          color="orange"
        />
      </motion.div>
    </div>
  </div>
</template>
