
export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  const id = getRouterParam(event, 'id')

  if (!user.associacaoId) {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const associado = await prisma.associado.findFirst({
    where: { 
        id, 
        associacaoId: user.associacaoId 
    },
    include: {
        qualificacao: true,
        contatos: true,
        enderecos: true
    }
  })

  if (!associado) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Associado não encontrado'
    })
  }

  return associado
})
