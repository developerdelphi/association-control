import { PrismaClient } from '@prisma/client'
import bcrypt from 'bcryptjs'

const prisma = new PrismaClient()

async function main() {
  console.log('🌱 Starting seed...')

  // 1. Create Super Admin
  const superAdminEmail = 'super@admin.com'
  const superAdmin = await prisma.usuarioSistema.upsert({
    where: { email: superAdminEmail },
    update: {},
    create: {
      name: 'Super Admin',
      email: superAdminEmail,
      password: await bcrypt.hash('123456', 10),
      role: 'super_admin',
      status: 'ativo'
    }
  })
  console.log(`Created Super Admin: ${superAdmin.email}`)

  // 2. Create Association
  const associacaoName = 'Associação Exemplo'
  const associacao = await prisma.associacao.upsert({
    where: { id: 'demo-assoc-01' }, // Using a fixed ID for simplicity in checking/updates if schema allowed unique name, but id is uuid. We'll search by name or just create.
    // Since ID is UUID, upsert by unique field is tricky if we don't have one. 
    // Let's check if it exists by scanning (not ideal but ok for seed) or just use a fixed UUID if possible.
    // Prisma requires unique where input. Let's rely on cleaning db or just creating if not exists based on query.
    update: {},
    create: {
      id: 'demo-assoc-01',
      name: associacaoName,
      description: 'Uma associação de demonstração rica em detalhes.',
      status: 'ativo'
    }
  })
  console.log(`Created Association: ${associacao.name}`)

  // 3. Create Association Admin
  const adminEmail = 'admin@demo.com'
  const adminUser = await prisma.usuarioSistema.upsert({
    where: { email: adminEmail },
    update: {},
    create: {
      name: 'Admin Demo',
      email: adminEmail,
      password: await bcrypt.hash('123456', 10),
      role: 'admin_associacao',
      status: 'ativo',
      associacaoId: associacao.id
    }
  })
  console.log(`Created Association Admin: ${adminUser.email}`)

  // 4. Create Types of Payment
  const paymentTypes = ['Mensalidade', 'Doação', 'Inscrição']
  for (const type of paymentTypes) {
    const exists = await prisma.tipoPagamento.findFirst({
        where: { name: type, associacaoId: associacao.id }
    })
    
    if (!exists) {
        await prisma.tipoPagamento.create({
            data: {
                associacaoId: associacao.id,
                name: type,
                status: 'ativo'
            }
        })
    }
  }

  // 5. Create Associates
  const associatesData = [
    {
      name: 'João Silva',
      registerNumber: '001',
      type: 'Fundador',
      quote: 100.00,
      status: 'ativo',
      email: 'joao@email.com',
      sex: 'Masculino',
      date: new Date('2020-01-15')
    },
    {
      name: 'Maria Oliveira',
      registerNumber: '002',
      type: 'Sócio',
      quote: 50.00,
      status: 'ativo',
      email: 'maria@email.com',
      sex: 'Feminino',
      date: new Date('2021-03-10')
    },
    {
      name: 'Carlos Souza',
      registerNumber: '003',
      type: 'Benemérito',
      quote: 0.00,
      status: 'inativo',
      email: 'carlos@email.com',
      sex: 'Masculino',
      date: new Date('2019-05-20')
    }
  ]

  for (const asc of associatesData) {
    const exists = await prisma.associado.findUnique({
      where: {
        associacaoId_registerNumber: {
          associacaoId: associacao.id,
          registerNumber: asc.registerNumber
        }
      }
    })

    if (!exists) {
      await prisma.associado.create({
        data: {
          associacaoId: associacao.id,
          name: asc.name,
          registerNumber: asc.registerNumber,
          type: asc.type,
          quote: asc.quote,
          status: asc.status,
          entryDate: asc.date,
          qualificacao: {
            create: {
                nationality: 'Brasileira',
                civilStatus: 'Casado(a)',
                profession: 'Empresário',
                sex: asc.sex || 'Masculino',
                cpf: `123.456.789-${asc.registerNumber}`
            }
          },
          contatos: {
            create: [
                { type: 'email', value: asc.email, isPrimary: true },
                { type: 'telefone_celular', value: '(11) 99999-9999', isPrimary: false }
            ]
          },
          enderecos: {
            create: {
                logradouro: 'Rua das Flores',
                numero: '123',
                bairro: 'Centro',
                cidade: 'São Paulo',
                uf: 'SP',
                pais: 'Brasil',
                cep: '01000-000',
                isPrimary: true
            }
          }
        }
      })
      console.log(`Created Associate: ${asc.name}`)
    }
  }

  console.log('✅ Seed finished.')
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })
