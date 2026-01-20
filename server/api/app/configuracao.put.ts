
export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  if (!user.associacaoId) {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const body = await readBody(event)
  const {
    name, description, cnpj, foundationDate, logo,
    zipCode, street, number, complement, neighborhood, city, state
  } = body

  const conversaoData = foundationDate ? new Date(foundationDate) : undefined

  const associacao = await prisma.associacao.update({
    where: { id: user.associacaoId },
    data: {
      name,
      description,
      cnpj,
      foundationDate: conversaoData,
      logo, // Base64 string
      zipCode,
      street,
      number,
      complement,
      neighborhood,
      city,
      state
    }
  })

  return associacao
})
