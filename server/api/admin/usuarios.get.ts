

export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  if (user.role !== 'super_admin') {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const usuarios = await prisma.usuarioSistema.findMany({
    where: {
      status: { not: 'deletado' }
    },
    include: {
      associacao: {
        select: {
          id: true,
          name: true
        }
      }
    },
    orderBy: { createdAt: 'desc' }
  })

  // Remove hashes
  return usuarios.map(u => {
    const { password, ...rest } = u
    return rest
  })
})
