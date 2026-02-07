<script setup lang="ts">
defineProps<{
  title: string
  description?: string
}>()
</script>

<template>
  <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-8">
    <motion.div
      :initial="{ opacity: 0, x: -10 }"
      :animate="{ opacity: 1, x: 0 }"
      :transition="{ duration: 0.5 }"
    >
      <h1 class="text-2xl font-bold text-gray-900 dark:text-white">{{ title }}</h1>
      <p v-if="description" class="mt-1 text-sm text-gray-500 dark:text-gray-400">
        {{ description }}
      </p>
    </motion.div>
    <motion.div 
      class="flex items-center gap-2"
      :initial="{ opacity: 0, x: 10 }"
      :animate="{ opacity: 1, x: 0 }"
      :transition="{ duration: 0.5, delay: 0.2 }"
    >
      <slot name="actions" />
    </motion.div>
  </div>
</template>
