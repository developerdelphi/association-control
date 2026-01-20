<script setup lang="ts">
definePageMeta({
  layout: 'admin-association'
})

const { data: metrics } = await useFetch('/api/app/metrics')
</script>

<template>
  <div>
    <h1 class="text-2xl font-bold mb-6">Visão Geral</h1>
    
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <UCard>
        <div class="flex items-center gap-4">
          <div class="p-3 bg-primary-100 rounded-full dark:bg-primary-900">
            <UIcon name="i-lucide-users" class="w-8 h-8 text-primary-600 dark:text-primary-400" />
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium">Total de Associados</p>
            <p class="text-3xl font-bold">{{ metrics?.totalAssociates || 0 }}</p>
          </div>
        </div>
      </UCard>

      <UCard class="opacity-50">
        <div class="flex items-center gap-4">
          <div class="p-3 bg-green-100 rounded-full dark:bg-green-900">
             <UIcon name="i-lucide-dollar-sign" class="w-8 h-8 text-green-600 dark:text-green-400" />
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium">Receita Mensal</p>
            <p class="text-3xl font-bold">R$ 0,00</p>
          </div>
        </div>
        <template #footer>
            <div class="text-xs text-center">Em breve</div>
        </template>
      </UCard>
      
      <UCard class="opacity-50">
        <div class="flex items-center gap-4">
          <div class="p-3 bg-orange-100 rounded-full dark:bg-orange-900">
             <UIcon name="i-lucide-alert-circle" class="w-8 h-8 text-orange-600 dark:text-orange-400" />
          </div>
          <div>
            <p class="text-sm text-gray-500 font-medium">Pagamentos Pendentes</p>
            <p class="text-3xl font-bold">0</p>
          </div>
        </div>
        <template #footer>
            <div class="text-xs text-center">Em breve</div>
        </template>
      </UCard>
    </div>
  </div>
</template>
