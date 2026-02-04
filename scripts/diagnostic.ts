import { PrismaClient } from '@prisma/client';
import fs from 'fs';
import path from 'path';

const prisma = new PrismaClient();
const JSON_FILE = path.resolve('data_preview_utf8.json');

async function main() {
  const data = JSON.parse(fs.readFileSync(JSON_FILE, 'utf-8').replace(/^\ufeff/, ''));
  
  // Encontrar a chave do CPF dinamicamente
  const firstItem = data[0] || {};
  const cpfKey = Object.keys(firstItem).find(k => k.includes('CPF'));
  console.log(`🔑 Usando chave de CPF: ${cpfKey}`);

  const cpfs = data.map((i: any) => {
    const val = cpfKey ? i[cpfKey] : null;
    const c = val?.toString().replace(/\D/g, '');
    if (!c) return null;
    // Garantir 11 dígitos com padding
    const padded = c.padStart(11, '0');
    return padded.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
  }).filter(Boolean);

  console.log(`🔍 Verificando ${cpfs.length} CPFs formatados no banco de dados...`);

  const conflicts = await prisma.qualificacao.findMany({
    where: { cpf: { in: cpfs } },
    include: {
      associado: {
        include: {
          associacao: true
        }
      }
    }
  });

  console.log(`⚠️ Encontrados ${conflicts.length} conflitos.`);

  const assocGroups: Record<string, number> = {};
  conflicts.forEach(c => {
    const name = c.associado?.associacao?.name || 'Sem Associação';
    assocGroups[name] = (assocGroups[name] || 0) + 1;
  });

  console.log('Distribuição de conflitos por associação:');
  console.log(JSON.stringify(assocGroups, null, 2));

  if (conflicts.length > 0) {
    console.log('\nAmostra de conflito:');
    const first = conflicts[0];
    console.log(`CPF: ${first.cpf} | Nome: ${first.associado?.name} | Assoc: ${first.associado?.associacao?.name}`);
  }
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
