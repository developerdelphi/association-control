
export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  
  if (!user.associacaoId) {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const body = await readBody(event)

  // Basic validation
  if (!body.name || !body.type || !body.entryDate) {
    throw createError({ statusCode: 400, statusMessage: 'Dados básicos obrigatórios' })
  }

  // Check for duplicate CPF in the same association
  if (body.qualificacao?.cpf) {
    const existingCpf = await prisma.qualificacao.findFirst({
      where: {
        cpf: body.qualificacao.cpf,
        associado: {
          associacaoId: user.associacaoId
        }
      }
    })

    if (existingCpf) {
      throw createError({ statusCode: 400, statusMessage: 'CPF já cadastrado nesta associação.' })
    }
  }

  // Generate register number (Simple Sequential Logic)
  // Race conditions possible but acceptable for MVP
  const lastAssociate = await prisma.associado.findFirst({
    where: { associacaoId: user.associacaoId },
    orderBy: { createdAt: 'desc' }
  })

  let nextRegisterNumber = '1'
  if (lastAssociate && lastAssociate.registerNumber) {
      const lastNum = parseInt(lastAssociate.registerNumber, 10)
      if (!isNaN(lastNum)) {
          nextRegisterNumber = (lastNum + 1).toString()
      } else {
        // Fallback if registerNumber is not numeric
        nextRegisterNumber = Date.now().toString()
      }
  }

  const associado = await prisma.associado.create({
    data: {
      associacaoId: user.associacaoId,
      name: body.name,
      registerNumber: nextRegisterNumber,
      type: body.type,
      entryDate: new Date(body.entryDate),
      status: body.status || 'ativo',
      quote: body.quote ? parseFloat(body.quote) : 0,
      
      photo: body.photo,
      
      // Creating related records if provided
      qualificacao: body.qualificacao ? {
        create: {
            cpf: body.qualificacao.cpf,
            rg: body.qualificacao.rg,
            birthdate: body.qualificacao.birthdate ? new Date(body.qualificacao.birthdate) : null,
            profession: body.qualificacao.profession,
            sex: body.qualificacao.sex,
            nationality: body.qualificacao.nationality,
            civilStatus: body.qualificacao.civilStatus,
            // New Fields
            isForeigner: body.qualificacao.isForeigner || false,
            country: body.qualificacao.country || 'Brasil',
            rne: body.qualificacao.rne,
            fatherName: body.qualificacao.fatherName,
            motherName: body.qualificacao.motherName,
            spouseName: body.qualificacao.spouseName,
        }
      } : undefined,

      dadosBancarios: body.dadosBancarios ? {
          create: {
              bdmDigitalAccount: body.dadosBancarios.bdmDigitalAccount,
              bank: body.dadosBancarios.bank,
              agency: body.dadosBancarios.agency,
              accountNumber: body.dadosBancarios.accountNumber
          }
      } : undefined,

      contatos: body.contatos && body.contatos.length ? {
          create: body.contatos.map((c: any) => ({
              type: c.type,
              value: c.value,
              isPrimary: c.isPrimary || false
          }))
      } : undefined,

      enderecos: body.enderecos && body.enderecos.length ? {
          create: body.enderecos.map((e: any) => ({
              logradouro: e.logradouro,
              numero: e.numero,
              complemento: e.complemento,
              bairro: e.bairro,
              cep: e.cep,
              cidade: e.cidade,
              uf: e.uf,
              isPrimary: e.isPrimary || false
          }))
      } : undefined
    }
  })

  return associado
})
