<template>
  <UApp>
    <div class="flex flex-col items-center justify-center min-h-screen gap-4">
      <h1 class="text-3xl font-bold text-primary">Nuxt UI v4 + Nuxt 4</h1>
      <p class="text-neutral-500">A unificação Pro agora é gratuita!</p>
      <div class="flex gap-2">
        <UButton
          label="Componente Nuxt UI"
          icon="i-lucide-rocket"
          color="primary"
        />
        <UButton
          label="Documentação"
          variant="outline"
          to="https://ui.nuxt.com"
          target="_blank"
        />
      </div>
    </div>
  </UApp>
</template>
