/*
  Warnings:

  - A unique constraint covering the columns `[cnpj]` on the table `associacao` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "associacao" ADD COLUMN "city" TEXT;
ALTER TABLE "associacao" ADD COLUMN "cnpj" TEXT;
ALTER TABLE "associacao" ADD COLUMN "complement" TEXT;
ALTER TABLE "associacao" ADD COLUMN "foundation_date" DATETIME;
ALTER TABLE "associacao" ADD COLUMN "logo" TEXT;
ALTER TABLE "associacao" ADD COLUMN "neighborhood" TEXT;
ALTER TABLE "associacao" ADD COLUMN "number" TEXT;
ALTER TABLE "associacao" ADD COLUMN "state" TEXT;
ALTER TABLE "associacao" ADD COLUMN "street" TEXT;
ALTER TABLE "associacao" ADD COLUMN "zip_code" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "associacao_cnpj_key" ON "associacao"("cnpj");
