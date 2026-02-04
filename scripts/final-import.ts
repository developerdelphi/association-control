import { PrismaClient } from '@prisma/client';
import fs from 'fs';
import path from 'path';

const prisma = new PrismaClient();
const ASSOC_ID = '3976c2bb-b889-425d-8949-4f09607d9cbc';
const JSON_FILE = path.resolve('data_preview_utf8.json');

function formatCPF(cpf: any): string {
    if (!cpf) return '';
    const clean = cpf.toString().replace(/\D/g, '').padStart(11, '0');
    return clean.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
}

function parseDate(dateRaw: any): Date | null {
    if (!dateRaw) return null;
    let d: Date;
    if (typeof dateRaw === 'number') {
        d = new Date((dateRaw - 25569) * 86400 * 1000);
    } else {
        const parts = dateRaw.split(/[./\:]/);
        if (parts.length === 3) {
            let day = parseInt(parts[0]);
            let month = parseInt(parts[1]) - 1;
            let year = parseInt(parts[2]);
            if (year < 100) year += (year < 40 ? 2000 : 1900);
            d = new Date(year, month, day);
        } else {
            return null;
        }
    }
    return isNaN(d.getTime()) ? null : d;
}

function parseAddress(raw: string | undefined) {
    if (!raw) return { logradouro: '', numero: '', bairro: '', cidade: '', uf: '', cep: '' };
    let cleanRaw = raw;
    const cepMatch = cleanRaw.match(/(\d{5}-?\d{3})/);
    let cep = '';
    if (cepMatch) {
        cep = cepMatch[1];
        cleanRaw = cleanRaw.replace(cepMatch[1], '').trim();
    }
    const parts = cleanRaw.split(/[,;\n]/).map(p => p.trim()).filter(Boolean);
    let logradouro = parts[0] || '';
    let numero = '';
    let bairro = '';
    let cidade = '';
    let uf = '??';

    if (parts.length >= 2) {
        const numMatch = parts[1].match(/^(\d+\s*[A-Za-z0-9\s]*)/);
        if (numMatch) {
            numero = numMatch[1];
            if (parts.length >= 3) bairro = parts.slice(2, parts.length - 1).join(', ') || parts[2];
            const last = parts[parts.length - 1];
            const ufMatch = last.match(/([A-Z]{2})$/);
            if (ufMatch) {
                uf = ufMatch[1];
                cidade = last.replace(ufMatch[1], '').trim();
            } else {
                cidade = last;
            }
        } else {
            const split = parts[0].match(/(.+?)\s+(\d+.*)/);
            if (split) {
                logradouro = split[1];
                numero = split[2];
            }
            bairro = parts[1];
            if (parts.length >= 3) cidade = parts[2];
        }
    }
    return { logradouro, numero, bairro, cidade, uf, cep };
}

async function main() {
  console.log('🚀 Iniciando importação final sanitizada...');
  const data = JSON.parse(fs.readFileSync(JSON_FILE, 'utf-8').replace(/^\ufeff/, ''));
  const cpfKey = Object.keys(data[0] || {}).find(k => k.includes('CPF')) || '';

  console.log('🧹 Limpando todos os dados da Expansão Verde...');
  const existing = await prisma.associado.findMany({
      where: { associacaoId: ASSOC_ID },
      select: { id: true }
  });
  const ids = existing.map(e => e.id);

  if (ids.length > 0) {
      await prisma.$transaction([
          prisma.contato.deleteMany({ where: { associadoId: { in: ids } } }),
          prisma.endereco.deleteMany({ where: { associadoId: { in: ids } } }),
          prisma.pagamento.deleteMany({ where: { associadoId: { in: ids } } }),
          prisma.dadosBancarios.deleteMany({ where: { associadoId: { in: ids } } }),
          prisma.qualificacao.deleteMany({ where: { associadoId: { in: ids } } }),
          prisma.associado.deleteMany({ where: { id: { in: ids } } }),
      ]);
  }
  console.log(`✅ ${ids.length} associados antigos removidos.`);

  let count = 0;
  for (let i = 0; i < data.length; i++) {
    const item = data[i];
    const nome = item['Nome Completo']?.trim();
    if (!nome) continue;

    const cpfFormatted = formatCPF(item[cpfKey]);
    const cleanCpf = cpfFormatted.replace(/\D/g, '');

    // CHECK FOR GLOBAL CONFLICT (even if in other association)
    if (cleanCpf) {
        const conflict = await prisma.qualificacao.findFirst({
            where: { 
                OR: [
                    { cpf: cpfFormatted },
                    { cpf: cleanCpf }
                ]
            },
            include: { associado: true }
        });
        if (conflict) {
            console.log(`⚠️ Pulando ${nome}: CPF ${cpfFormatted} já existe em ${conflict.associado.name}`);
            continue;
        }
    }

    const regNum = `EXV-${(i + 1).toString().padStart(4, '0')}`;
    const addr = parseAddress(item['Endereço residencial completo (rua, número, bairro, cidade, país, CEP)']);
    const rgFull = `${item['Número da Identidade (RG)'] || ''} ${item['Órgão expedidor da Identidade (RG)'] || ''}`.trim();

    try {
        await prisma.associado.create({
            data: {
                associacaoId: ASSOC_ID,
                name: nome,
                registerNumber: regNum,
                type: 'Sócio',
                status: 'ativo',
                entryDate: new Date(),
                qualificacao: {
                    create: {
                        cpf: cpfFormatted,
                        rg: rgFull,
                        birthdate: parseDate(item['Data de Nascimento (dia/mês/ano)']),
                        civilStatus: item['Estado Civil'],
                        profession: item['Profissão'],
                        nationality: 'brasileira'
                    }
                },
                contatos: item['Endereço de e-mail'] ? {
                    create: [{ type: 'email', value: item['Endereço de e-mail'], isPrimary: true }]
                } : undefined,
                enderecos: {
                    create: [{
                        logradouro: addr.logradouro || 'N/A',
                        numero: addr.numero,
                        bairro: addr.bairro || 'N/A',
                        cidade: addr.cidade || 'N/A',
                        uf: addr.uf || '??',
                        cep: addr.cep,
                        pais: 'Brasil',
                        isPrimary: true
                    }]
                }
            }
        });
        count++;
        if (count % 10 === 0) console.log(`⏳ Processados ${count}...`);
    } catch (err: any) {
        console.error(`❌ Erro ao inserir ${nome}:`, err.message);
    }
  }

  console.log(`\n✨ Finalizado! ${count} associados inseridos.`);
}

main().catch(console.error).finally(() => prisma.$disconnect());
