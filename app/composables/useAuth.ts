export const useUserSession = () => {
  const user = useState<any>('user', () => null)

  const fetchUser = async () => {
    try {
      const data = await $fetch('/api/auth/me')
      user.value = data.user
    } catch {
      user.value = null
    }
  }

  const logout = async () => {
    await $fetch('/api/auth/logout', { method: 'POST' })
    user.value = null
    await navigateTo('/login')
  }

  return {
    user,
    fetchUser,
    logout,
    loggedIn: computed(() => !!user.value)
  }
}
