
export default defineEventHandler(async (event) => {
  const user = requireAuth(event)
  const id = event.context.params?.id

  if (!user.associacaoId) {
    throw createError({ statusCode: 403, statusMessage: 'Forbidden' })
  }

  const body = await readBody(event)

  // Validate Update Logic (Optional: Check if associate allows update)

  const updateData: any = {
    name: body.name,
    type: body.type,
    status: body.status,
    quote: body.quote ? parseFloat(body.quote) : undefined,
    entryDate: body.entryDate ? new Date(body.entryDate) : undefined,
    exitDate: body.exitDate ? new Date(body.exitDate) : null, // Handle exitDate
    photo: body.photo,
    registerNumber: body.registerNumber
  }

  // Check for duplicate registerNumber if it's being changed
  if (body.registerNumber) {
      const existingAssociate = await prisma.associado.findFirst({
          where: {
              associacaoId: user.associacaoId,
              registerNumber: body.registerNumber,
              NOT: {
                  id: id
              }
          }
      })

      if (existingAssociate) {
          throw createError({ statusCode: 400, statusMessage: 'Já existe um associado com este número de matrícula.' })
      }
  }

  // Update Relations if provided
  // Prisma `upsert` or `update` for relations depends on strategy. 
  // For simplicity using `upsert` where possible or separate queries if nested update is complex.

  // Using nested update/upsert
  if (body.qualificacao) {
      updateData.qualificacao = {
          upsert: {
              create: {
                  cpf: body.qualificacao.cpf,
                  rg: body.qualificacao.rg,
                  birthdate: body.qualificacao.birthdate ? new Date(body.qualificacao.birthdate) : null,
                  profession: body.qualificacao.profession,
                  sex: body.qualificacao.sex,
                  nationality: body.qualificacao.nationality,
                  civilStatus: body.qualificacao.civilStatus,
                  isForeigner: body.qualificacao.isForeigner,
                  country: body.qualificacao.country,
                  rne: body.qualificacao.rne,
                  fatherName: body.qualificacao.fatherName,
                  motherName: body.qualificacao.motherName,
                  spouseName: body.qualificacao.spouseName,
              },
              update: {
                  cpf: body.qualificacao.cpf,
                  rg: body.qualificacao.rg,
                  birthdate: body.qualificacao.birthdate ? new Date(body.qualificacao.birthdate) : null,
                  profession: body.qualificacao.profession,
                  sex: body.qualificacao.sex,
                  nationality: body.qualificacao.nationality,
                  civilStatus: body.qualificacao.civilStatus,
                  isForeigner: body.qualificacao.isForeigner,
                  country: body.qualificacao.country,
                  rne: body.qualificacao.rne,
                  fatherName: body.qualificacao.fatherName,
                  motherName: body.qualificacao.motherName,
                  spouseName: body.qualificacao.spouseName,
              }
          }
      }
  }

    if (body.dadosBancarios) {
      updateData.dadosBancarios = {
          upsert: {
              create: {
                  bdmDigitalAccount: body.dadosBancarios.bdmDigitalAccount,
                  bank: body.dadosBancarios.bank,
                  agency: body.dadosBancarios.agency,
                  accountNumber: body.dadosBancarios.accountNumber
              },
              update: {
                  bdmDigitalAccount: body.dadosBancarios.bdmDigitalAccount,
                  bank: body.dadosBancarios.bank,
                  agency: body.dadosBancarios.agency,
                  accountNumber: body.dadosBancarios.accountNumber
              }
          }
      }
  }

  // Handle Contacts and Addresses usually requires deleting old/updating specific.
  // For MVP, we might implement specific add/remove logic or replace all (risky).
  // Assuming frontend sends ALL contacts, we can deleteMany + createMany (simple sync)
  // BUT `update` with `deleteMany` inside is safer.
  
  if (body.contatos) {
      updateData.contatos = {
          deleteMany: {},
          create: body.contatos.map((c: any) => ({
              type: c.type,
              value: c.value,
              isPrimary: c.isPrimary
          }))
      }
  }

  if (body.enderecos) {
      updateData.enderecos = {
          deleteMany: {},
          create: body.enderecos.map((e: any) => ({
              logradouro: e.logradouro,
              numero: e.numero,
              complemento: e.complemento,
              bairro: e.bairro,
              cep: e.cep,
              cidade: e.cidade,
              uf: e.uf,
              isPrimary: e.isPrimary
          }))
      }
  }

  const associado = await prisma.associado.update({
    where: { 
        id,
        associacaoId: user.associacaoId 
    },
    data: updateData
  })

  return associado
})
