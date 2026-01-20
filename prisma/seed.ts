import { PrismaClient } from '@prisma/client'
import bcrypt from 'bcryptjs'

const prisma = new PrismaClient()

async function main() {
  const superAdminEmail = 'admin@platform.com'
  const existingAdmin = await prisma.usuarioSistema.findUnique({
    where: { email: superAdminEmail }
  })

  if (!existingAdmin) {
    const hashedPassword = bcrypt.hashSync('admin123', 10)
    await prisma.usuarioSistema.create({
      data: {
        name: 'Super Admin',
        email: superAdminEmail,
        password: hashedPassword,
        role: 'super_admin',
        status: 'ativo'
      }
    })
    console.log('Super Admin user created: admin@platform.com / admin123')
  } else {
    console.log('Super Admin user already exists.')
  }
}

main()
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
