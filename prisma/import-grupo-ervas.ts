import { PrismaClient } from '@prisma/client';
import fs from 'fs';
import path from 'path';

const prisma = new PrismaClient();
const ASSOC_ID = '3976c2bb-b889-425d-8949-4f09607d9cbc';
const JSON_FILE = path.resolve('data_preview_utf8.json');

async function main() {
  console.log('🚀 Iniciando processo de importação...');

  // 1. Limpeza
  console.log('🧹 Removendo associados existentes da Expansão Verde...');
  
  // Devido às relações, precisamos deletar em ordem ou usar deleteMany se as relações permitirem cascade (o SQLite nem sempre suporta nativamente via Prisma sem configuração)
  // Mas como as relações no schema.prisma não têm onDelete: Cascade explícito, vamos deletar manualmente.
  
  const associatesToDelete = await prisma.associado.findMany({
    where: { associacaoId: ASSOC_ID },
    select: { id: true }
  });
  const associateIds = associatesToDelete.map(a => a.id);

  if (associateIds.length > 0) {
    await prisma.pagamento.deleteMany({ where: { associadoId: { in: associateIds } } });
    await prisma.contato.deleteMany({ where: { associadoId: { in: associateIds } } });
    await prisma.endereco.deleteMany({ where: { associadoId: { in: associateIds } } });
    await prisma.qualificacao.deleteMany({ where: { associadoId: { in: associateIds } } });
    await prisma.dadosBancarios.deleteMany({ where: { associadoId: { in: associateIds } } });
    await prisma.associado.deleteMany({ where: { associacaoId: ASSOC_ID } });
    console.log(`✅ ${associateIds.length} associados antigos removidos.`);
  } else {
    console.log('ℹ️ Nenhum associado existente para remover.');
  }

  // 2. Carregar Dados
  console.log('📖 Lendo dados da planilha...');
  let rawData = fs.readFileSync(JSON_FILE, 'utf-8');
  
  // Remover caracteres invisíveis e BOM (Byte Order Mark) que podem quebrar o JSON.parse
  rawData = rawData.replace(/^\ufeff/, '').trim();
  
  let items;
  try {
    items = JSON.parse(rawData);
  } catch (e) {
    console.error('❌ Erro de sintaxe no JSON. Tentando limpar caracteres de controle...');
    // Limpeza agressiva: mantém apenas o que está entre os colchetes do array
    const match = rawData.match(/\[.*\]/s);
    if (match) {
        items = JSON.parse(match[0]);
    } else {
        throw e;
    }
  }

  // 3. Importação
  console.log(`📥 Importando ${items.length} novos registros...`);
  
  let count = 0;
  for (let i = 0; i < items.length; i++) {
    const item = items[i];
    const nome = item['Nome Completo']?.trim();
    if (!nome) {
      console.log(`⚠️ Item ${i} ignorado: Nome completo vazio.`);
      continue;
    }

    console.log(`⏳ Processando [${i + 1}/${items.length}]: ${nome}...`);

    const email = item['Endereço de e-mail']?.trim();
    const cpf = item['Número do CPF']?.toString().replace(/\D/g, '');
    const rg = item['Número da Identidade (RG)']?.toString();
    const enderecoBruto = item['Endereço residencial completo (rua, número, bairro, cidade, país, CEP)'] || '';
    const profissao = item['Profissão']?.trim();
    const estadoCivil = item['Estado Civil']?.trim();
    const dataNascimentoRaw = item['Data de Nascimento (dia/mês/ano)'];
    
    let birthdate: Date | null = null;
    if (dataNascimentoRaw) {
        if (typeof dataNascimentoRaw === 'number') {
            birthdate = new Date((dataNascimentoRaw - 25569) * 86400 * 1000);
        } else {
            const parts = dataNascimentoRaw.split(/[./\:]/);
            if (parts.length === 3) {
                let day = parseInt(parts[0]);
                let month = parseInt(parts[1]) - 1;
                let year = parseInt(parts[2]);
                if (year < 100) year += 1900;
                birthdate = new Date(year, month, day);
            }
        }
    }

    const registerNumber = `EXP-${(count + 1).toString().padStart(4, '0')}`;

    try {
      await prisma.associado.create({
        data: {
          associacaoId: ASSOC_ID,
          name: nome,
          registerNumber: registerNumber,
          type: 'Sócio',
          status: 'ativo',
          entryDate: new Date(),
          qualificacao: {
            create: {
              cpf: cpf || null,
              rg: rg || null,
              birthdate: birthdate && !isNaN(birthdate.getTime()) ? birthdate : null,
              civilStatus: estadoCivil,
              profession: profissao,
              nationality: item['Naturalidade'] || 'Brasileira'
            }
          },
          contatos: email ? {
            create: [
              { type: 'email', value: email, isPrimary: true }
            ]
          } : undefined,
          enderecos: {
            create: [
              {
                logradouro: enderecoBruto.substring(0, 200),
                bairro: 'Importado',
                cidade: 'Importado',
                uf: '??',
                cep: '00000-000',
                isPrimary: true
              }
            ]
          }
        }
      });
      console.log(`✅ ${nome} importado com sucesso.`);
      count++;
    } catch (err) {
      console.error(`❌ Erro ao importar ${nome}:`, (err as Error).message);
    }
  }

  console.log(`\n✨ Processo finalizado! ${count} de ${items.length} associados foram salvos no banco.`);
}

main()
  .catch((e) => {
    console.error('💥 Erro fatal no script:', e);
  })
  .finally(async () => {
    await prisma.$disconnect();
    console.log('🔌 Conexão com o banco encerrada.');
  });
