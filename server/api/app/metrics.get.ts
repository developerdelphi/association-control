

export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  
  if (!user.associacaoId) {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const count = await prisma.associado.count({
    where: {
      associacaoId: user.associacaoId,
      status: { not: 'deletado' }
    }
  })

  return { totalAssociates: count }
})
