-- CreateTable
CREATE TABLE "associacao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "usuario_sistema" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "associacao_id" TEXT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'admin_associacao',
    "status" TEXT NOT NULL DEFAULT 'pendente_aprovacao',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "usuario_sistema_associacao_id_fkey" FOREIGN KEY ("associacao_id") REFERENCES "associacao" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "associado" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "associacao_id" TEXT NOT NULL,
    "register_number" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "type" TEXT NOT NULL,
    "entry_date" DATETIME NOT NULL,
    "exit_date" DATETIME,
    "quote" DECIMAL NOT NULL DEFAULT 0.00,
    "photo" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "associado_associacao_id_fkey" FOREIGN KEY ("associacao_id") REFERENCES "associacao" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "qualificacao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "associado_id" TEXT NOT NULL,
    "cpf" TEXT,
    "rg" TEXT,
    "birthdate" DATETIME,
    "civil_status" TEXT,
    "nationality" TEXT,
    "profession" TEXT,
    "sex" TEXT,
    "father_name" TEXT,
    "mother_name" TEXT,
    "spouse_name" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "qualificacao_associado_id_fkey" FOREIGN KEY ("associado_id") REFERENCES "associado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "contato" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "associado_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "is_primary" BOOLEAN NOT NULL DEFAULT false,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "contato_associado_id_fkey" FOREIGN KEY ("associado_id") REFERENCES "associado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "endereco" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "associado_id" TEXT NOT NULL,
    "logradouro" TEXT NOT NULL,
    "numero" TEXT,
    "complemento" TEXT,
    "bairro" TEXT NOT NULL,
    "cep" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "uf" TEXT NOT NULL,
    "pais" TEXT NOT NULL DEFAULT 'Brasil',
    "description" TEXT,
    "type" TEXT NOT NULL DEFAULT 'residencial',
    "is_primary" BOOLEAN NOT NULL DEFAULT false,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "endereco_associado_id_fkey" FOREIGN KEY ("associado_id") REFERENCES "associado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "tipo_pagamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "associacao_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "format" TEXT,
    "description" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "tipo_pagamento_associacao_id_fkey" FOREIGN KEY ("associacao_id") REFERENCES "associacao" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "pagamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "associado_id" TEXT NOT NULL,
    "tipo_pagamento_id" TEXT NOT NULL,
    "payment_date" DATETIME NOT NULL,
    "value_unit" DECIMAL NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "total_value" DECIMAL NOT NULL,
    "description" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pendente',
    "due_date" DATETIME,
    "paid_at" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "pagamento_associado_id_fkey" FOREIGN KEY ("associado_id") REFERENCES "associado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "pagamento_tipo_pagamento_id_fkey" FOREIGN KEY ("tipo_pagamento_id") REFERENCES "tipo_pagamento" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "usuario_sistema_email_key" ON "usuario_sistema"("email");

-- CreateIndex
CREATE UNIQUE INDEX "associado_associacao_id_register_number_key" ON "associado"("associacao_id", "register_number");

-- CreateIndex
CREATE UNIQUE INDEX "qualificacao_associado_id_key" ON "qualificacao"("associado_id");

-- CreateIndex
CREATE UNIQUE INDEX "qualificacao_cpf_key" ON "qualificacao"("cpf");
