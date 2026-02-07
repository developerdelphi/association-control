// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  future: {
    compatibilityVersion: 4
  },
  srcDir: 'app/',
  compatibilityDate: '2024-11-27',
  devtools: { enabled: true },
  modules: ['@nuxt/ui', 'motion-v/nuxt', '@vueuse/nuxt'],
  app: {
    pageTransition: { name: 'page', mode: 'out-in' },
    layoutTransition: { name: 'layout', mode: 'out-in' }
  },
  css: ['~/assets/css/main.css'],
  ui: {
    experimental: {
      componentDetection: true
    }
  }
})
