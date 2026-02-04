import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const ASSOC_ID = '3976c2bb-b889-425d-8949-4f09607d9cbc';

async function main() {
  console.log('--- Verificação de Banco de Dados ---');
  
  const associacao = await prisma.associacao.findUnique({
    where: { id: ASSOC_ID },
    include: {
      _count: {
        select: { associados: true }
      }
    }
  });

  if (associacao) {
    console.log(`Associação: ${associacao.name}`);
    console.log(`ID: ${associacao.id}`);
    console.log(`Total de Associados (contagem): ${associacao._count.associados}`);
    
    const associates = await prisma.associado.findMany({
      where: { associacaoId: ASSOC_ID },
      take: 5,
      include: {
        qualificacao: true,
        contatos: true
      }
    });
    
    console.log('\nÚltimos associados inseridos (amostra de 5):');
    associates.forEach(a => {
      console.log(`- ${a.name} (${a.registerNumber}) - CPF: ${a.qualificacao?.cpf || 'N/A'}`);
    });
  } else {
    console.log('❌ Associação não encontrada!');
  }
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
