

export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  if (user.role !== 'super_admin') {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const body = await readBody(event)

  if (!body.email || !body.password || !body.name) {
    throw createError({ statusCode: 400, statusMessage: 'Campos obrigatórios faltando' })
  }

  const existing = await prisma.usuarioSistema.findUnique({
    where: { email: body.email }
  })

  if (existing) {
    throw createError({ statusCode: 400, statusMessage: 'Email já cadastrado' })
  }

  const newUser = await prisma.usuarioSistema.create({
    data: {
      name: body.name,
      email: body.email,
      password: hashPassword(body.password),
      role: body.role || 'admin_associacao',
      associacaoId: body.associacaoId || null,
      status: body.status || 'pendente_aprovacao'
    }
  })

  const { password, ...rest } = newUser
  return rest
})
