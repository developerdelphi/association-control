


export default defineEventHandler(async (event) => {
  const body = await readBody(event)
  const { email, password } = body
  
  if (!email || !password) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Email e senha são obrigatórios'
    })
  }

  const user = await prisma.usuarioSistema.findUnique({
    where: { email }
  })


  // Check if user exists and password marks match
  if (!user || !comparePassword(password, user.password)) {
    throw createError({
      statusCode: 401,
      statusMessage: 'Credenciais inválidas'
    })
  }

  if (user.status !== 'ativo') {
    throw createError({
      statusCode: 403,
      statusMessage: 'Usuário inativo ou pendente de aprovação'
    })
  }

  // Create session
  createUserSession(event, user)

  return {
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      associacaoId: user.associacaoId
    }
  }
})
