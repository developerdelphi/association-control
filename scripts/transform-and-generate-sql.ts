import fs from 'fs';
import path from 'path';
import { randomUUID } from 'crypto';

const ASSOC_ID = '3976c2bb-b889-425d-8949-4f09607d9cbc';
const JSON_FILE = path.resolve('data_preview_utf8.json');
const OUTPUT_SQL = path.resolve('prisma/seed_associados_exv.sql');
const CONTROVERSIAL_LOG = path.resolve('controversial_data.log');

// ... (functions remain same, replacing uuidv4() with randomUUID())

interface ExcelItem {
  'Nome Completo'?: string;
  'Número do CPF'?: string | number;
  'Número da Identidade (RG)'?: string | number;
  'Órgão expedidor da Identidade (RG)'?: string;
  'Endereço residencial completo (rua, número, bairro, cidade, país, CEP)'?: string;
  'Endereço de e-mail'?: string;
  'Profissão'?: string;
  'Estado Civil'?: string;
  'Data de Nascimento (dia/mês/ano)'?: string | number;
  'Naturalidade'?: string;
}

function formatCPF(cpf: string | number | undefined): string {
    if (!cpf) return '';
    const clean = cpf.toString().replace(/\D/g, '');
    if (clean.length !== 11) return clean; // Fallback if invalid
    return clean.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
}

function parseDate(dateRaw: string | number | undefined): string {
    if (!dateRaw) return 'NULL';
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
            return 'NULL';
        }
    }
    return isNaN(d.getTime()) ? 'NULL' : `'${d.toISOString()}'`;
}

function parseAddress(raw: string | undefined) {
    if (!raw) return { logradouro: '', numero: '', bairro: '', cidade: '', uf: '', cep: '' };
    
    let logradouro = '';
    let numero = '';
    let bairro = '';
    let cidade = '';
    let uf = '??';
    let cep = '';

    // Regex para CEP
    const cepMatch = raw.match(/(\d{5}-?\d{3})/);
    if (cepMatch) {
        cep = cepMatch[1];
        raw = raw.replace(cepMatch[1], '').trim();
    }

    // Tentar splitar por vírgula primeiro
    const parts = raw.split(/[,;\n]/).map(p => p.trim()).filter(Boolean);
    
    if (parts.length >= 1) {
        logradouro = parts[0];
        
        if (parts.length >= 2) {
            // Check if second part starts with a number (Numero)
            const numMatch = parts[1].match(/^(\d+\s*[A-Za-z0-9\s]*)/);
            if (numMatch) {
                numero = numMatch[1];
                if (parts.length >= 3) bairro = parts.slice(2, parts.length - 2).join(', ') || parts[2];
                
                // Tentar pegar Cidade e UF dos últimos elementos
                const last = parts[parts.length - 1];
                const ufMatch = last.match(/([A-Z]{2})$/);
                if (ufMatch) {
                    uf = ufMatch[1];
                    cidade = last.replace(ufMatch[1], '').trim();
                } else if (parts.length >= 4) {
                    cidade = parts[parts.length - 1];
                }
            } else {
                // Heuristic for "Rua Numero"
                const split = parts[0].match(/(.+?)\s+(\d+.*)/);
                if (split) {
                    logradouro = split[1];
                    numero = split[2];
                }
                bairro = parts[1];
                if (parts.length >= 3) cidade = parts[2];
            }
        }
    }

    // Limpeza final de caracteres residuais
    cidade = cidade.replace(/[-]/g, '').trim();
    bairro = bairro.replace(/[-]/g, '').trim();

    return {
        logradouro: logradouro.substring(0, 100),
        numero: numero.substring(0, 20),
        bairro: bairro.substring(0, 100),
        cidade: cidade.substring(0, 100),
        uf: uf.toUpperCase().substring(0, 2),
        cep: cep
    };
}

async function main() {
  console.log('🏁 Iniciando processamento...');
  const rawData = fs.readFileSync(JSON_FILE, 'utf-8').replace(/^\ufeff/, '').trim();
  const items: ExcelItem[] = JSON.parse(rawData);

  // Encontrar a chave do CPF dinamicamente
  const firstItem = items[0] || {};
  const cpfKey = Object.keys(firstItem).find(k => k.includes('CPF')) as keyof ExcelItem;
  console.log(`🔑 Usando chave de CPF: ${String(cpfKey)}`);

  let sql = `-- Seed for Expansão Verde\n`;
  sql += `-- Auto-generated script\n\n`;

  // Delete previous - MORE AGGRESSIVE
  // We first clear by CPF to ensure no global conflicts
  const cleanCpfs = items.map(item => {
      const val = item[cpfKey];
      return val?.toString().replace(/\D/g, '').padStart(11, '0');
  }).filter(Boolean);

  if (cleanCpfs.length > 0) {
      const cleanCpfList = cleanCpfs.map(c => `'${c}'`).join(',');
      sql += `-- Limpeza preventiva por CPF (formatado e não formatado) para evitar conflitos globais\n`;
      sql += `-- Remove qualquer rastro desses CPFs ignorando pontuação\n`;
      
      const subquery = `SELECT "associado_id" FROM "qualificacao" WHERE REPLACE(REPLACE("cpf", '.', ''), '-', '') IN (${cleanCpfList})`;
      
      sql += `DELETE FROM "contato" WHERE "associado_id" IN (${subquery});\n`;
      sql += `DELETE FROM "endereco" WHERE "associado_id" IN (${subquery});\n`;
      sql += `DELETE FROM "pagamento" WHERE "associado_id" IN (${subquery});\n`;
      sql += `DELETE FROM "dados_bancarios" WHERE "associado_id" IN (${subquery});\n`;
      sql += `DELETE FROM "qualificacao" WHERE REPLACE(REPLACE("cpf", '.', ''), '-', '') IN (${cleanCpfList});\n`;
      sql += `DELETE FROM "associado" WHERE "id" IN (SELECT "associado_id" FROM "qualificacao" WHERE REPLACE(REPLACE("cpf", '.', ''), '-', '') IN (${cleanCpfList}));\n\n`;
  }

  // Double check cleanup for the association itself
  sql += `DELETE FROM "contato" WHERE "associado_id" IN (SELECT "id" FROM "associado" WHERE "associacao_id" = '${ASSOC_ID}');\n`;
  sql += `DELETE FROM "endereco" WHERE "associado_id" IN (SELECT "id" FROM "associado" WHERE "associacao_id" = '${ASSOC_ID}');\n`;
  sql += `DELETE FROM "pagamento" WHERE "associado_id" IN (SELECT "id" FROM "associado" WHERE "associacao_id" = '${ASSOC_ID}');\n`;
  sql += `DELETE FROM "dados_bancarios" WHERE "associado_id" IN (SELECT "id" FROM "associado" WHERE "associacao_id" = '${ASSOC_ID}');\n`;
  sql += `DELETE FROM "qualificacao" WHERE "associado_id" IN (SELECT "id" FROM "associado" WHERE "associacao_id" = '${ASSOC_ID}');\n`;
  sql += `DELETE FROM "associado" WHERE "associacao_id" = '${ASSOC_ID}';\n\n`;

  const controversial: string[] = [];

  items.forEach((item, index) => {
    const nome = item['Nome Completo']?.trim();
    if (!nome) return;

    const id = randomUUID();
    const regNum = `EXV-${(index + 1).toString().padStart(4, '0')}`;
    const entryDate = `'${new Date().toISOString()}'`;
    
    // Associado
    sql += `INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") \n`;
    sql += `VALUES ('${id}', '${ASSOC_ID}', '${regNum}', '${nome.replace(/'/g, "''")}', 'Sócio', 'ativo', ${entryDate}, ${entryDate}, ${entryDate});\n`;

    // Qualificacao
    const cpf = formatCPF(item['Número do CPF']);
    const rgNum = item['Número da Identidade (RG)'] || '';
    const rgExp = item['Órgão expedidor da Identidade (RG)'] || '';
    const rgFull = `${rgNum} ${rgExp}`.trim();
    const birth = parseDate(item['Data de Nascimento (dia/mês/ano)']);
    
    sql += `INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") \n`;
    sql += `VALUES ('${randomUUID()}', '${id}', '${cpf}', '${rgFull.replace(/'/g, "''")}', ${birth}, '${(item['Estado Civil'] || '').replace(/'/g, "''")}', 'brasileira', '${(item['Profissão'] || '').replace(/'/g, "''")}', ${entryDate}, ${entryDate});\n`;

    // Contato
    const email = item['Endereço de e-mail']?.trim();
    if (email) {
        sql += `INSERT INTO "contato" ("id", "associado_id", "type", "value", "is_primary", "status", "created_at", "updated_at") \n`;
        sql += `VALUES ('${randomUUID()}', '${id}', 'email', '${email.replace(/'/g, "''")}', 1, 'ativo', ${entryDate}, ${entryDate});\n`;
    }

    // Endereco
    const addr = parseAddress(item['Endereço residencial completo (rua, número, bairro, cidade, país, CEP)']);
    sql += `INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") \n`;
    sql += `VALUES ('${randomUUID()}', '${id}', '${addr.logradouro.replace(/'/g, "''")}', '${addr.numero.replace(/'/g, "''")}', '${addr.bairro.replace(/'/g, "''")}', '${addr.cep}', '${addr.cidade.replace(/'/g, "''")}', '${addr.uf}', 'Brasil', 'residencial', 1, 'ativo', ${entryDate}, ${entryDate});\n`;

    // Logging controversial data
    if (addr.uf === '??' || !addr.numero || birth === 'NULL') {
        controversial.push(`- ${nome}: CPF=${cpf}, Birth=${birth}, Address=${item['Endereço residencial completo (rua, número, bairro, cidade, país, CEP)']}`);
    }

    sql += `\n`;
  });

  fs.writeFileSync(OUTPUT_SQL, sql);
  fs.writeFileSync(CONTROVERSIAL_LOG, controversial.join('\n'));

  console.log(`✅ Arquivo SQL gerado em: ${OUTPUT_SQL}`);
  console.log(`⚠️ ${controversial.length} registros com dados controversos identificados. Veja ${CONTROVERSIAL_LOG}`);
}

main().catch(console.error);
