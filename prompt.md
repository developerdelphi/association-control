# Título do Projeto: Sistema de Gestão para Associação Sem Fins Lucrativos (SaaS)

### Objetivo Principal:

Desenvolver uma aplicação web SaaS (Software as a Service) para gerenciar associações de pessoas sem fins lucrativos. O sistema deve permitir o gerenciamento individual de cada associação, focando no cadastro de seus membros, na geração de carteirinhas e no controle de pagamentos.

### Público-Alvo: Administradores de associações sem fins lucrativos e os gestores designados por eles.

### Funcionalidades Chave da Aplicação:

#### Gestão de Cadastros de Associados:

- Registro completo de membros da associação.
- Geração de carteirinha de associado em formato PDF, pronta para visualização e impressão.Gestão de Pagamentos:

#### Gestão de Pagamentos:

- Controle e registro dos pagamentos realizados pelos associados (mensalidades, taxas, etc.).

#### Painel Administrativo Central (Super Admin):

- Gerenciamento das instâncias de associações cadastradas na plataforma SaaS.
- Gerenciamento de usuários administradores/gestores de cada associação (solicitantes de acesso à gestão de uma associação).

#### Tipos de Usuário e Níveis de Acesso:

Super Administrador (Plataforma SaaS):
Acesso ao painel administrativo central.
CRUD (Criar, Ler, Atualizar, Deletar - físico) para associacoes (as diferentes entidades de associação que usam o SaaS).
CRUD (Criar, Ler, Atualizar, Deletar - físico) para usuarios do sistema (gestores das associações).
Usuário Gestor da Associação (Cliente SaaS):
Acesso ao painel de gerenciamento da sua respectiva associação.
CRUD (Criar, Ler, Atualizar, Deletar - lógico) para associados, pagamentos, tipos_pagamento, qualificacoes, contatos, enderecos da sua associação.
Não pode deletar registros fisicamente do banco de dados, apenas alterar o status para "deletado".
Modelo de Dados Detalhado (Entidades e Atributos):

associacao (Associação Cliente do SaaS):

id (PK, UUID ou Integer Autoincremento)
name (VARCHAR, Obrigatório, Nome da associação)
description (TEXT, Descrição da associação)
status (VARCHAR, Enum: 'ativo', 'inativo', 'pendente', 'deletado'; Padrão: 'ativo')
created_at (TIMESTAMP, Data de criação)
updated_at (TIMESTAMP, Data de atualização)
usuario_sistema (Usuário Gestor da Associação):

id (PK, UUID ou Integer Autoincremento)
associacao_id (FK para associacao.id, identifica a qual associação este gestor pertence/gerencia)
name (VARCHAR, Obrigatório)
email (VARCHAR, Obrigatório, Único, para login)
password (VARCHAR, Obrigatório, armazenar hash)
role (VARCHAR, Enum: 'admin_associacao', 'super_admin'; Padrão: 'admin_associacao')
status (VARCHAR, Enum: 'ativo', 'inativo', 'pendente_aprovacao', 'deletado'; Padrão: 'pendente_aprovacao')
created_at (TIMESTAMP)
updated_at (TIMESTAMP)
associado (Membro da Associação):

id (PK, UUID ou Integer Autoincremento)
associacao_id (FK para associacao.id, Obrigatório - indica a qual associação o membro pertence)
register_number (VARCHAR, Número de matrícula do associado, sequencial e único dentro da associacao_id)
name (VARCHAR, Obrigatório)
description (TEXT)
status (VARCHAR, Enum: 'ativo', 'inativo', 'suspenso', 'deletado'; Padrão: 'ativo')
type (VARCHAR, Enum: 'Fundador', 'Sócio', 'Honorário', 'Benemérito'; Obrigatório)
entry_date (DATE, Data de admissão, Obrigatório)
exit_date (DATE, Data de desligamento)
quote (DECIMAL(10,2), Valor da cota/mensalidade; Padrão: 0.00)
photo (BLOB ou VARCHAR para URL da imagem, Caminho para arquivo da foto)
created_at (TIMESTAMP)
updated_at (TIMESTAMP)
qualificacao (Qualificação do Associado): Relacionamento 1 para 1 com associado.

id (PK, UUID ou Integer Autoincremento)
associado_id (FK para associado.id, Obrigatório, Único)
cpf (VARCHAR, Único, Formato CPF)
rg (VARCHAR)
birthdate (DATE, Data de nascimento)
civil_status (VARCHAR, Enum: 'Solteiro(a)', 'Casado(a)', 'Divorciado(a)', 'Viúvo(a)', 'União Estável')
nationality (VARCHAR)
profession (VARCHAR)
sex (VARCHAR, Enum: 'Masculino', 'Feminino', 'Outro', 'Não informar')
father_name (VARCHAR, Nome do pai)
mother_name (VARCHAR, Nome da mãe)
spouse_name (VARCHAR, Nome do cônjuge)
status (VARCHAR, Enum: 'ativo', 'inativo', 'deletado'; Padrão: 'ativo') // Status do registro de qualificação
created_at (TIMESTAMP)
updated_at (TIMESTAMP)
contato (Contato do Associado): Relacionamento 1 para Muitos com associado.

id (PK, UUID ou Integer Autoincremento)
associado_id (FK para associado.id, Obrigatório)
type (VARCHAR, Enum: 'email', 'telefone_celular', 'telefone_residencial', 'telefone_comercial')
value (VARCHAR, Valor do contato, ex: email@example.com ou (XX) XXXXX-XXXX)
is_primary (BOOLEAN, Indica se é o contato principal do tipo especificado)
status (VARCHAR, Enum: 'ativo', 'inativo', 'deletado'; Padrão: 'ativo')
created_at (TIMESTAMP)
updated_at (TIMESTAMP)
endereco (Endereço do Associado): Relacionamento 1 para Muitos com associado.

id (PK, UUID ou Integer Autoincremento)
associado_id (FK para associado.id, Obrigatório)
logradouro (VARCHAR, Obrigatório)
numero (VARCHAR)
complemento (VARCHAR)
bairro (VARCHAR, Obrigatório)
cep (VARCHAR, Obrigatório, Formato CEP)
cidade (VARCHAR, Obrigatório)
uf (VARCHAR(2), Obrigatório, Enum com UFs do Brasil)
pais (VARCHAR, Padrão: 'Brasil')
description (TEXT, Ponto de referência ou descrição adicional)
type (VARCHAR, Enum: 'residencial', 'comercial', 'cobranca'; Padrão: 'residencial')
is_primary (BOOLEAN, Indica se é o endereço principal)
status (VARCHAR, Enum: 'ativo', 'inativo', 'deletado'; Padrão: 'ativo')
created_at (TIMESTAMP)
updated_at (TIMESTAMP)
pagamento (Pagamento do Associado):

id (PK, UUID ou Integer Autoincremento)
associado_id (FK para associado.id, Obrigatório)
tipo_pagamento_id (FK para tipo_pagamento.id, Obrigatório)
payment_date (DATE, Data do pagamento/competência, Obrigatório)
value_unit (DECIMAL(10,2), Valor unitário)
quantity (INTEGER, Quantidade; Padrão: 1)
total_value (DECIMAL(10,2), Calculado: value_unit \* quantity, Obrigatório)
description (TEXT, Descrição/observações do pagamento)
status (VARCHAR, Enum: 'pago', 'pendente', 'vencido', 'cancelado', 'deletado'; Padrão: 'pendente')
due_date (DATE, Data de vencimento, opcional)
paid_at (DATE, Data em que foi efetivamente pago, opcional)
created_at (TIMESTAMP)
updated_at (TIMESTAMP)
tipo_pagamento (Tipo de Pagamento):

id (PK, UUID ou Integer Autoincremento)
associacao_id (FK para associacao.id, Obrigatório - cada associação pode ter seus tipos)
name (VARCHAR, Obrigatório, ex: 'Mensalidade', 'Taxa de Inscrição', 'Doação')
format (VARCHAR, Informativo, ex: 'Boleto', 'PIX', 'Dinheiro')
description (TEXT)
status (VARCHAR, Enum: 'ativo', 'inativo', 'deletado'; Padrão: 'ativo')
created_at (TIMESTAMP)
updated_at (TIMESTAMP)
Especificações da Aplicação e Funcionalidades Detalhadas:

Autenticação e Autorização:
Sistema de login seguro para usuario_sistema.
Redirecionamento baseado no role:
super_admin: Painel Administrativo Central.
admin_associacao: Painel de Gerenciamento da Associação específica.
Painel Administrativo Central (para super_admin):
Interface para CRUD de associacao (entidades que contrataram o SaaS).
Interface para CRUD de usuario_sistema (aprovar/reprovar solicitações de acesso, definir qual associacao_id um admin_associacao gerencia).
Painel de Gerenciamento da Associação (para admin_associacao):
Dashboard: Visão geral com indicadores chave da associação (ex: total de associados ativos, pagamentos pendentes do mês, aniversariantes).
Gerenciamento de Associados (CRUD):
Listagem com filtros (por nome, status, tipo, etc.) e paginação.
Formulários para criar e editar associados, incluindo seus dados de qualificacao, contatos (múltiplos) e enderecos (múltiplos) de forma integrada (ex: abas ou seções no mesmo formulário).
Visualização detalhada de um associado.
Impressão de Carteirinha (PDF):
Apenas para associados com status = 'ativo'.
Layout deve incluir: Nome da Associação, Foto do Associado, Nome do Associado, Número de Matrícula (register_number), Tipo (type), Data de Admissão (entry_date), Data de Validade (se aplicável, pode ser calculada ou um campo novo), CPF, RG. Poderá incluir um contato principal e endereço principal.
Gerenciamento de Pagamentos (CRUD):
Listagem com filtros (por associado, tipo de pagamento, status, período) e paginação.
Formulários para registrar e editar pagamentos.
Cálculo automático de total_value.
Gerenciamento de Tipos de Pagamento (CRUD):
Permitir que cada associação defina seus próprios tipos de pagamento.
Gerenciamento de Qualificações, Contatos, Endereços:
Embora vinculados ao associado, permitir interfaces dedicadas se necessário, mas primariamente gerenciados através da tela do associado.
Lógica de "Exclusão":
Usuários admin_associacao apenas realizam exclusão lógica (alteram status para 'deletado').
Registros com status = 'deletado' não devem aparecer nas listagens e buscas padrão do dia a dia.
super_admin pode ter a opção de exclusão física (hard delete) no Painel Administrativo Central, ou uma funcionalidade de "lixeira".
Interface e UX:
Idioma: Português do Brasil para todas as interfaces de usuário.
Responsividade: Design adaptável para desktops e tablets.
Buscas e Filtros: Componentes de busca e filtragem avançada nas listagens principais.
Validações: Validação de dados nos formulários (campos obrigatórios, formatos corretos para CPF, CEP, email, datas, valores numéricos).
Notificações/Feedback: Mensagens claras para o usuário sobre o resultado das operações.
Tecnologias Requeridas:

Frontend: Nuxt.js Vue.js
Estilização: nuxt-ui
Banco de Dados: SQLite (para persistência de dados gratuita e simples) ou outra opção de banco de dados gratuito suportado.
Backend: suportar as operações CRUD, lógica de negócios e autenticação descritas.
Considerações Adicionais:

O campo register_number do associado deve ser gerenciado de forma a garantir unicidade sequencial dentro de cada associacao_id. Isso pode exigir uma lógica específica na criação de um novo associado.
Segurança: Implementar hashing para senhas e seguir boas práticas de segurança web.
