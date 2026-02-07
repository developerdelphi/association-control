<script setup lang="ts">
defineProps<{
  title: string
  value: string | number
  icon: string
  color?: string
  trend?: string
  trendUp?: boolean
}>()
</script>

<template>
  <motion.div
    :while-hover="{ scale: 1.02, y: -4 }"
    :transition="{ type: 'spring', stiffness: 300 }"
  >
    <UCard :ui="{ body: { padding: 'px-4 py-5 sm:p-6' } }">
      <div class="flex items-center gap-4">
        <div 
          class="p-3 rounded-lg ring-1 ring-inset"
          :class="[
            color ? `bg-${color}-50 text-${color}-600 ring-${color}-500/10 dark:bg-${color}-400/10 dark:text-${color}-400 dark:ring-${color}-400/20` 
                  : 'bg-gray-50 text-gray-600 ring-gray-500/10 dark:bg-gray-400/10 dark:text-gray-400 dark:ring-gray-400/20'
          ]"
        >
          <UIcon :name="icon" class="w-6 h-6" />
        </div>
        <div>
          <p class="text-sm font-medium text-gray-500 dark:text-gray-400">{{ title }}</p>
          <p class="mt-1 text-2xl font-bold text-gray-900 dark:text-white">{{ value }}</p>
        </div>
      </div>
    </UCard>
  </motion.div>
</template>
