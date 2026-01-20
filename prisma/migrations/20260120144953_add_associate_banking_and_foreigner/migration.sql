-- CreateTable
CREATE TABLE "dados_bancarios" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "associado_id" TEXT NOT NULL,
    "bdm_digital_account" TEXT,
    "bank" TEXT,
    "agency" TEXT,
    "account_number" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "dados_bancarios_associado_id_fkey" FOREIGN KEY ("associado_id") REFERENCES "associado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_qualificacao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "associado_id" TEXT NOT NULL,
    "cpf" TEXT,
    "rg" TEXT,
    "birthdate" DATETIME,
    "civil_status" TEXT,
    "nationality" TEXT,
    "profession" TEXT,
    "sex" TEXT,
    "is_foreigner" BOOLEAN NOT NULL DEFAULT false,
    "country" TEXT NOT NULL DEFAULT 'Brasil',
    "rne" TEXT,
    "father_name" TEXT,
    "mother_name" TEXT,
    "spouse_name" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "qualificacao_associado_id_fkey" FOREIGN KEY ("associado_id") REFERENCES "associado" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_qualificacao" ("associado_id", "birthdate", "civil_status", "cpf", "created_at", "father_name", "id", "mother_name", "nationality", "profession", "rg", "sex", "spouse_name", "status", "updated_at") SELECT "associado_id", "birthdate", "civil_status", "cpf", "created_at", "father_name", "id", "mother_name", "nationality", "profession", "rg", "sex", "spouse_name", "status", "updated_at" FROM "qualificacao";
DROP TABLE "qualificacao";
ALTER TABLE "new_qualificacao" RENAME TO "qualificacao";
CREATE UNIQUE INDEX "qualificacao_associado_id_key" ON "qualificacao"("associado_id");
CREATE UNIQUE INDEX "qualificacao_cpf_key" ON "qualificacao"("cpf");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "dados_bancarios_associado_id_key" ON "dados_bancarios"("associado_id");
