export default defineNuxtPlugin(async () => {
  const { fetchUser } = useUserSession()
  await fetchUser()
})
