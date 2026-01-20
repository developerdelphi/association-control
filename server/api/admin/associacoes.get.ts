

export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  
  if (user.role !== 'super_admin') {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const query = getQuery(event)
  const page = parseInt(query.page as string) || 1
  const pageSize = parseInt(query.pageSize as string) || 10
  const search = (query.search as string) || ''

  const where: any = {
    status: { not: 'deletado' }
  }

  if (search) {
      where.OR = [
          { name: { contains: search } },
          { description: { contains: search } }
      ]
  }

  const [associacoes, total] = await Promise.all([
      prisma.associacao.findMany({
        where,
        orderBy: { createdAt: 'desc' },
        skip: (page - 1) * pageSize,
        take: pageSize
      }),
      prisma.associacao.count({ where })
  ])

  return {
      data: associacoes,
      total,
      page,
      pageSize,
      totalPages: Math.ceil(total / pageSize)
  }
})
