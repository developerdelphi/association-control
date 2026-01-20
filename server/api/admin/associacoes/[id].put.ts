

export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  if (user.role !== 'super_admin') {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const id = getRouterParam(event, 'id')
  const body = await readBody(event)

  if (!id) {
    throw createError({ statusCode: 400, statusMessage: 'ID é obrigatório' })
  }

  // Prevent updating restricted fields if necessary, or just update allowed fields
  const associacao = await prisma.associacao.update({
    where: { id },
    data: {
      name: body.name,
      description: body.description,
      status: body.status
    }
  })

  return associacao
})
