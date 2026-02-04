import { PrismaClient } from '@prisma/client';
import fs from 'fs';
import path from 'path';

const prisma = new PrismaClient();
const SQL_FILE = path.resolve('prisma/seed_associados_exv.sql');

async function main() {
  console.log('📖 Lendo arquivo SQL...');
  const sql = fs.readFileSync(SQL_FILE, 'utf-8');
  
  // O SQLite via Prisma $executeRaw só aceita UM comando por vez geralmente.
  // Vamos separar por ponto e vírgula.
  const commands = sql
    .split(';')
    .map(cmd => cmd.trim())
    .filter(cmd => cmd.length > 0 && !cmd.startsWith('--'));

  console.log(`⚡ Executando ${commands.length} comandos SQL...`);

  await prisma.$transaction(async (tx) => {
    for (const cmd of commands) {
      try {
        await tx.$executeRawUnsafe(cmd);
      } catch (err) {
        console.error(`❌ Erro no comando: ${cmd}`);
        throw err;
      }
    }
  });

  console.log('✅ SQL aplicado com sucesso ao banco de dados.');
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
