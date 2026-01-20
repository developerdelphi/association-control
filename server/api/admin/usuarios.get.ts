

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
          { email: { contains: search } }
      ]
  }

  const [usuarios, total] = await Promise.all([
      prisma.usuarioSistema.findMany({
        where,
        include: {
          associacao: {
            select: {
              id: true,
              name: true
            }
          }
        },
        orderBy: { createdAt: 'desc' },
        skip: (page - 1) * pageSize,
        take: pageSize
      }),
      prisma.usuarioSistema.count({ where })
  ])

  const sanitizedUsers = usuarios.map(u => {
    const { password, ...rest } = u
    return rest
  })

  return {
    data: sanitizedUsers,
    total,
    page,
    pageSize,
    totalPages: Math.ceil(total / pageSize)
  }
})
