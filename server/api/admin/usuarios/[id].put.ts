

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

  const dataToUpdate: any = {
    name: body.name,
    email: body.email,
    role: body.role,
    associacaoId: body.associacaoId || null,
    status: body.status
  }

  if (body.password && body.password.length > 0) {
    dataToUpdate.password = hashPassword(body.password)
  }

  const updatedUser = await prisma.usuarioSistema.update({
    where: { id },
    data: dataToUpdate
  })

  const { password, ...rest } = updatedUser
  return rest
})
