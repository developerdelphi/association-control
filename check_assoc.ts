import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  const assocId = '3976c2bb-b889-425d-8949-4f09607d9cbc'
  const assoc = await prisma.associacao.findUnique({
    where: { id: assocId }
  })
  
  if (assoc) {
    console.log(`Found Association: ${assoc.name} (${assoc.id})`)
  } else {
    console.log(`Association with ID ${assocId} not found.`)
    // Let's see if there's one with the name
    const assocByName = await prisma.associacao.findFirst({
        where: { name: { contains: 'Expansão Verde' } }
    })
    if (assocByName) {
        console.log(`Found by name: ${assocByName.name} (${assocByName.id})`)
    }
  }
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect())
