

export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  if (user.role !== 'super_admin') {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const body = await readBody(event)
  
  if (!body.name) {
    throw createError({ statusCode: 400, statusMessage: 'Nome é obrigatório' })
  }

  const associacao = await prisma.associacao.create({
    data: {
      name: body.name,
      description: body.description,
      status: body.status || 'ativo'
    }
  })

  return associacao
})
