
export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  
  if (!user.associacaoId) {
    throw createError({ statusCode: 403, statusMessage: 'Usuário não vinculado a uma associação' })
  }

  const query = getQuery(event)
  const page = parseInt(query.page as string) || 1
  const pageSize = parseInt(query.pageSize as string) || 10
  const search = (query.search as string) || ''
  
  const where: any = {
    associacaoId: user.associacaoId,
    status: { not: 'deletado' }
  }

  if (search) {
      where.OR = [
          { name: { contains: search } },
          { registerNumber: { contains: search } }
      ]
  }

  const [associados, total] = await Promise.all([
      prisma.associado.findMany({
        where,
        orderBy: { name: 'asc' },
        include: {
            contatos: true
        },
        skip: (page - 1) * pageSize,
        take: pageSize
      }),
      prisma.associado.count({ where })
  ])

  return {
    data: associados,
    total,
    page,
    pageSize,
    totalPages: Math.ceil(total / pageSize)
  }
})
