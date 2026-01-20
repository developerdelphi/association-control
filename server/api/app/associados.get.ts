
export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  
  if (!user.associacaoId) {
    throw createError({ statusCode: 403, statusMessage: 'Usuário não vinculado a uma associação' })
  }

  const query = getQuery(event)
  // Pagination and filtering can be added here
  
  const associados = await prisma.associado.findMany({
    where: {
      associacaoId: user.associacaoId,
      status: { not: 'deletado' }
    },
    orderBy: { name: 'asc' },
    include: {
        contatos: true // Include contacts for list/export
    }
  })

  return associados
})
