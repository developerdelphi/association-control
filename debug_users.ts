import { PrismaClient } from '@prisma/client'
import bcrypt from 'bcryptjs'

const prisma = new PrismaClient()

async function main() {
  const users = await prisma.usuarioSistema.findMany()
  console.log('--- Users in DB ---')
  for (const u of users) {
    console.log(`User: ${u.email} | Status: ${u.status} | Role: ${u.role}`)
    console.log(`Password Hash: ${u.password}`)
    const isMatch = bcrypt.compareSync('admin123', u.password)
    console.log(`Matches 'admin123'? ${isMatch}`)
  }
  console.log('-------------------')
}

main()
