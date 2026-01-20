

export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  
  if (user.role !== 'super_admin') {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const query = getQuery(event)
  // Simple pagination logic could be added here
  
  const associacoes = await prisma.associacao.findMany({
    orderBy: { createdAt: 'desc' },
    where: {
      status: { not: 'deletado' } // By default hide deleted? Or show with status filter?
    }
  })

  return associacoes
})
