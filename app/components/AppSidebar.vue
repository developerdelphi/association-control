<script setup lang="ts">
import { motion } from 'motion-v'

const props = defineProps<{
  title: string
  links: { label: string; to: string; icon?: string }[]
}>()

const { logout } = useUserSession()
const router = useRouter()

const handleLogout = async () => {
    await logout()
    router.push('/login')
}
</script>

<template>
  <motion.aside 
    id="app-sidebar"
    :initial="{ x: -20, opacity: 0 }"
    :animate="{ x: 0, opacity: 1 }"
    :transition="{ duration: 0.4, ease: 'easeOut' }"
    class="w-64 border-r border-gray-200 dark:border-gray-800 bg-white dark:bg-gray-900 flex flex-col h-screen sticky top-0"
  >
    <div class="p-6 border-b border-gray-200 dark:border-gray-800">
      <h1 class="text-xl font-bold text-gray-900 dark:text-white flex items-center gap-2">
        <UIcon name="i-lucide-layout-dashboard" class="w-6 h-6 text-primary-500" />
        {{ title }}
      </h1>
    </div>

    <nav class="flex-1 overflow-y-auto p-4 space-y-1">
      <motion.div
        v-for="(link, index) in links"
        :key="link.to"
        :initial="{ x: -10, opacity: 0 }"
        :animate="{ x: 0, opacity: 1 }"
        :transition="{ delay: index * 0.1 }"
        :while-hover="{ x: 4, scale: 1.02 }"
        :while-tap="{ scale: 0.98 }"
      >
        <UButton
          :to="link.to"
          :icon="link.icon"
          :label="link.label"
          variant="ghost"
          color="neutral"
          class="w-full justify-start transition-none"
          active-class="bg-gray-100 dark:bg-gray-800 text-primary-500 dark:text-primary-400"
        />
      </motion.div>
    </nav>

    <div class="p-4 border-t border-gray-200 dark:border-gray-800">
      <UButton
        icon="i-lucide-log-out"
        label="Sair"
        variant="ghost"
        color="error"
        class="w-full justify-start"
        @click="handleLogout"
      />
    </div>
  </motion.aside>
</template>
