
export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  const id = getRouterParam(event, 'id')
  const body = await readBody(event)

  if (!user.associacaoId) {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  // Ensure associate belongs to user's association
  const existing = await prisma.associado.findFirst({
    where: { id, associacaoId: user.associacaoId }
  })

  if (!existing) {
    throw createError({ statusCode: 404, statusMessage: 'Associado não encontrado' })
  }

  const result = await prisma.$transaction(async (tx) => {
    // Check for duplicate CPF in the same association (excluding self)
    if (body.qualificacao?.cpf) {
      const existingCpf = await tx.qualificacao.findFirst({
        where: {
          cpf: body.qualificacao.cpf,
          associado: {
            associacaoId: user.associacaoId
          },
          associadoId: {
            not: id // Exclude current associate
          }
        }
      })

      if (existingCpf) {
        throw createError({ statusCode: 400, statusMessage: 'CPF já cadastrado nesta associação.' })
      }
    }

    // 1. Update Basic Info
    const associado = await tx.associado.update({
      where: { id },
      data: {
        name: body.name,
        type: body.type,
        entryDate: body.entryDate ? new Date(body.entryDate) : undefined,
        status: body.status,
        quote: body.quote ? parseFloat(body.quote) : 0,
       
        // Update Qualification (Upsert)
        qualificacao: body.qualificacao ? {
            upsert: {
                create: {
                    cpf: body.qualificacao.cpf,
                    rg: body.qualificacao.rg,
                    birthdate: body.qualificacao.birthdate ? new Date(body.qualificacao.birthdate) : null,
                    profession: body.qualificacao.profession,
                    sex: body.qualificacao.sex,
                    nationality: body.qualificacao.nationality,
                    civilStatus: body.qualificacao.civilStatus
                },
                update: {
                    cpf: body.qualificacao.cpf,
                    rg: body.qualificacao.rg,
                    birthdate: body.qualificacao.birthdate ? new Date(body.qualificacao.birthdate) : null,
                    profession: body.qualificacao.profession,
                    sex: body.qualificacao.sex,
                    nationality: body.qualificacao.nationality,
                    civilStatus: body.qualificacao.civilStatus
                }
            }
        } : undefined
      }
    })

    // 2. Refresh Contacts (Delete All + Create New)
    await tx.contato.deleteMany({ where: { associadoId: id } })
    if (body.contatos && body.contatos.length > 0) {
        await tx.contato.createMany({
            data: body.contatos.map((c: any) => ({
                associadoId: id,
                type: c.type,
                value: c.value,
                isPrimary: c.isPrimary || false
            }))
        })
    }

    // 3. Refresh Addresses (Delete All + Create New)
    await tx.endereco.deleteMany({ where: { associadoId: id } })
    if (body.enderecos && body.enderecos.length > 0) {
        await tx.endereco.createMany({
            data: body.enderecos.map((e: any) => ({
                associadoId: id,
                logradouro: e.logradouro,
                numero: e.numero,
                bairro: e.bairro,
                cep: e.cep,
                cidade: e.cidade,
                uf: e.uf,
                isPrimary: e.isPrimary || false
            }))
        })
    }

    return associado
  })

  return result
})
