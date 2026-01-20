
export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  if (!user.associacaoId) {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const associacao = await prisma.associacao.findUnique({
    where: { id: user.associacaoId }
  })

  return associacao
})
