export default defineEventHandler((event) => {
  const user = getUserFromSession(event)
  if (user) {
    event.context.user = user
  }
})
