-- Seed for Expansão Verde
-- Auto-generated script

-- Limpeza preventiva por CPF (formatado e não formatado) para evitar conflitos globais
-- Remove qualquer rastro desses CPFs ignorando pontuação
DELETE FROM "contato" WHERE "associado_id" IN (SELECT "associado_id" FROM "qualificacao" WHERE REPLACE(REPLACE("cpf", '.', ''), '-', '') IN ('09394477705','57527830972','80806988800','56101716791','11924305810','12790730806','11522863150','08814588805','85373036153','10154230197','07441351766','00078855713','05054330879','15700514885','86968840510','81249799104','87926539368','28613643191','11203517157','09526719808','95991786704','35949767691','03782647882','09870016120','29408938453','34301330097','30873053168','14884216415','00361869967','46634592420','41731034172','07850481623','15522425873','76310299972','31766927068','70517703815','36761303168','03031055187','07202353164','58772308834','52521966720','69428484172','23950781072','64309630634','21271846888','00753091496','99648172820','33975884720','23516956828','04787781200'));
DELETE FROM "endereco" WHERE "associado_id" IN (SELECT "associado_id" FROM "qualificacao" WHERE REPLACE(REPLACE("cpf", '.', ''), '-', '') IN ('09394477705','57527830972','80806988800','56101716791','11924305810','12790730806','11522863150','08814588805','85373036153','10154230197','07441351766','00078855713','05054330879','15700514885','86968840510','81249799104','87926539368','28613643191','11203517157','09526719808','95991786704','35949767691','03782647882','09870016120','29408938453','34301330097','30873053168','14884216415','00361869967','46634592420','41731034172','07850481623','15522425873','76310299972','31766927068','70517703815','36761303168','03031055187','07202353164','58772308834','52521966720','69428484172','23950781072','64309630634','21271846888','00753091496','99648172820','33975884720','23516956828','04787781200'));
DELETE FROM "pagamento" WHERE "associado_id" IN (SELECT "associado_id" FROM "qualificacao" WHERE REPLACE(REPLACE("cpf", '.', ''), '-', '') IN ('09394477705','57527830972','80806988800','56101716791','11924305810','12790730806','11522863150','08814588805','85373036153','10154230197','07441351766','00078855713','05054330879','15700514885','86968840510','81249799104','87926539368','28613643191','11203517157','09526719808','95991786704','35949767691','03782647882','09870016120','29408938453','34301330097','30873053168','14884216415','00361869967','46634592420','41731034172','07850481623','15522425873','76310299972','31766927068','70517703815','36761303168','03031055187','07202353164','58772308834','52521966720','69428484172','23950781072','64309630634','21271846888','00753091496','99648172820','33975884720','23516956828','04787781200'));
DELETE FROM "dados_bancarios" WHERE "associado_id" IN (SELECT "associado_id" FROM "qualificacao" WHERE REPLACE(REPLACE("cpf", '.', ''), '-', '') IN ('09394477705','57527830972','80806988800','56101716791','11924305810','12790730806','11522863150','08814588805','85373036153','10154230197','07441351766','00078855713','05054330879','15700514885','86968840510','81249799104','87926539368','28613643191','11203517157','09526719808','95991786704','35949767691','03782647882','09870016120','29408938453','34301330097','30873053168','14884216415','00361869967','46634592420','41731034172','07850481623','15522425873','76310299972','31766927068','70517703815','36761303168','03031055187','07202353164','58772308834','52521966720','69428484172','23950781072','64309630634','21271846888','00753091496','99648172820','33975884720','23516956828','04787781200'));
DELETE FROM "qualificacao" WHERE REPLACE(REPLACE("cpf", '.', ''), '-', '') IN ('09394477705','57527830972','80806988800','56101716791','11924305810','12790730806','11522863150','08814588805','85373036153','10154230197','07441351766','00078855713','05054330879','15700514885','86968840510','81249799104','87926539368','28613643191','11203517157','09526719808','95991786704','35949767691','03782647882','09870016120','29408938453','34301330097','30873053168','14884216415','00361869967','46634592420','41731034172','07850481623','15522425873','76310299972','31766927068','70517703815','36761303168','03031055187','07202353164','58772308834','52521966720','69428484172','23950781072','64309630634','21271846888','00753091496','99648172820','33975884720','23516956828','04787781200');
DELETE FROM "associado" WHERE "id" IN (SELECT "associado_id" FROM "qualificacao" WHERE REPLACE(REPLACE("cpf", '.', ''), '-', '') IN ('09394477705','57527830972','80806988800','56101716791','11924305810','12790730806','11522863150','08814588805','85373036153','10154230197','07441351766','00078855713','05054330879','15700514885','86968840510','81249799104','87926539368','28613643191','11203517157','09526719808','95991786704','35949767691','03782647882','09870016120','29408938453','34301330097','30873053168','14884216415','00361869967','46634592420','41731034172','07850481623','15522425873','76310299972','31766927068','70517703815','36761303168','03031055187','07202353164','58772308834','52521966720','69428484172','23950781072','64309630634','21271846888','00753091496','99648172820','33975884720','23516956828','04787781200'));

DELETE FROM "contato" WHERE "associado_id" IN (SELECT "id" FROM "associado" WHERE "associacao_id" = '3976c2bb-b889-425d-8949-4f09607d9cbc');
DELETE FROM "endereco" WHERE "associado_id" IN (SELECT "id" FROM "associado" WHERE "associacao_id" = '3976c2bb-b889-425d-8949-4f09607d9cbc');
DELETE FROM "pagamento" WHERE "associado_id" IN (SELECT "id" FROM "associado" WHERE "associacao_id" = '3976c2bb-b889-425d-8949-4f09607d9cbc');
DELETE FROM "dados_bancarios" WHERE "associado_id" IN (SELECT "id" FROM "associado" WHERE "associacao_id" = '3976c2bb-b889-425d-8949-4f09607d9cbc');
DELETE FROM "qualificacao" WHERE "associado_id" IN (SELECT "id" FROM "associado" WHERE "associacao_id" = '3976c2bb-b889-425d-8949-4f09607d9cbc');
DELETE FROM "associado" WHERE "associacao_id" = '3976c2bb-b889-425d-8949-4f09607d9cbc';

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('8f8cbd44-707f-4bff-b7af-8e8a7515fc2f', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0001', 'Leandro Cancio de Pontes Machado', 'Sócio', 'ativo', '2026-02-04T20:18:37.047Z', '2026-02-04T20:18:37.047Z', '2026-02-04T20:18:37.047Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('5ad20d00-0aea-4d0d-96fc-447767c49246', '8f8cbd44-707f-4bff-b7af-8e8a7515fc2f', '', '', NULL, 'Casado', 'brasileira', '', '2026-02-04T20:18:37.047Z', '2026-02-04T20:18:37.047Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('3bb06b75-2a48-4f4a-9da2-1a58214137e8', '8f8cbd44-707f-4bff-b7af-8e8a7515fc2f', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.047Z', '2026-02-04T20:18:37.047Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('5140f991-3d65-49d8-91fc-21bd428d1e78', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0002', 'Lucia Brentano', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('1f38e42b-f4e3-4b14-899e-21fa84bb301e', '5140f991-3d65-49d8-91fc-21bd428d1e78', '', '', NULL, 'Divorciada', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('52d461d5-6fd8-42a0-b7b9-4b7a2c2f95d7', '5140f991-3d65-49d8-91fc-21bd428d1e78', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('bad9fd4d-4ee4-4f6d-86bf-4ee404d83b67', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0003', 'MIRIAM BERNARDES', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('9d5f44a6-5286-4afb-ab1f-94a76869962b', 'bad9fd4d-4ee4-4f6d-86bf-4ee404d83b67', '', '', NULL, 'Solteira', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('c9221a86-7bd3-46fb-94ad-21a1300d9718', 'bad9fd4d-4ee4-4f6d-86bf-4ee404d83b67', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('702b500a-c0b6-466e-9573-7ba9dd5f45c8', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0004', 'Dimeris Rangel de Almeida Salles', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('d29aa0c6-1fe8-4a10-bea4-186d29385d25', '702b500a-c0b6-466e-9573-7ba9dd5f45c8', '', '', NULL, 'Vi├║va', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('dbc38c54-5512-4040-a8db-38acb70ebe67', '702b500a-c0b6-466e-9573-7ba9dd5f45c8', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('545d3e65-3799-4acc-ad43-8a623d4ef39f', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0005', 'Patr├¡cia Yudesneider Alves', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('4b0d6e22-ec36-4155-8430-453fd48ff732', '545d3e65-3799-4acc-ad43-8a623d4ef39f', '', '', NULL, 'Casada', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('50139c49-61e8-49fe-a534-4a16db26a7e1', '545d3e65-3799-4acc-ad43-8a623d4ef39f', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('ef24c80f-5757-401a-8ecf-9b2494c8257c', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0006', 'Iolanda Ferreira de Barros', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('5416beff-5506-494c-976f-919159a2e643', 'ef24c80f-5757-401a-8ecf-9b2494c8257c', '', '', NULL, 'Solteira', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('94a5b0d6-1738-4108-b60e-46d54a479e23', 'ef24c80f-5757-401a-8ecf-9b2494c8257c', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('77b9397b-6125-45fc-9efb-1f3d98689838', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0007', 'EVA PEREZ TAMAYO', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('7ddc1a24-8b36-431f-8abc-8867f75cc471', '77b9397b-6125-45fc-9efb-1f3d98689838', '', '', NULL, 'Casal de fato', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('20b5ba3d-e42d-42eb-bee7-020a7f9d1ce5', '77b9397b-6125-45fc-9efb-1f3d98689838', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('dbba6773-6217-4789-843e-1c5563277582', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0008', 'Edson Tomossada Yonaha', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('58c67982-b89b-4ee9-b884-b142db555ce9', 'dbba6773-6217-4789-843e-1c5563277582', '', '', NULL, 'Divorciado', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('a24905aa-b709-47bf-9d73-5d51b270bfef', 'dbba6773-6217-4789-843e-1c5563277582', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('12c9973c-e26b-470b-8b45-e56beda8b49e', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0009', 'Dinalva Rambo Schafer', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('586aa8cc-6814-4fd9-87be-30d964784a81', '12c9973c-e26b-470b-8b45-e56beda8b49e', '', '', NULL, 'Solteira ', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('50f02f0a-382c-435a-a351-0234ebc11695', '12c9973c-e26b-470b-8b45-e56beda8b49e', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('2fa74b2a-efe2-4193-85b7-ca510fd969d5', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0010', 'Maria Ivone Ribeiro', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('40a81473-37ae-4c47-b204-68fd481a036c', '2fa74b2a-efe2-4193-85b7-ca510fd969d5', '', '', NULL, 'Divorciada', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('2877603e-f446-4a8c-9a61-26aecdb2fdec', '2fa74b2a-efe2-4193-85b7-ca510fd969d5', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('90e407b7-f162-4a31-b998-c0d29cda26ca', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0011', 'M├┤nica Kruschewsky Lemos', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('6cb1948a-b666-4dfe-b026-f8f47f827255', '90e407b7-f162-4a31-b998-c0d29cda26ca', '', '', NULL, 'Solteira', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('669a1a6e-f06e-41fc-97e4-a0fbf8d195e9', '90e407b7-f162-4a31-b998-c0d29cda26ca', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('f152c473-4785-4dc6-8020-7a802e783480', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0012', 'Juraciara Kruschewsky Lemos Lopes', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('24c9ee4a-dbb9-46b0-832d-3ac4dbca7ff5', 'f152c473-4785-4dc6-8020-7a802e783480', '', '', NULL, 'Casada', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('6ebab47b-c7bb-48f4-afc5-0a04f995bc0e', 'f152c473-4785-4dc6-8020-7a802e783480', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('0ea20bb2-c4e8-46bf-bd55-fe6986c3a19d', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0013', 'Aparecida Fernandes Ribeiro', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('8158f24a-fc8f-4bff-b6b7-3a330e17301d', '0ea20bb2-c4e8-46bf-bd55-fe6986c3a19d', '', '', NULL, 'Casada', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('28ffc92b-66a7-43c8-9194-aeff884f194e', '0ea20bb2-c4e8-46bf-bd55-fe6986c3a19d', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('dbc1f7ae-3231-4604-96a3-687d84e07bd3', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0014', 'Angelique de Oliveira Lima Camargo', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('8c597fa0-d3d3-4c4c-a01d-b037e051e41b', 'dbc1f7ae-3231-4604-96a3-687d84e07bd3', '', '', NULL, 'casada', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('1922d8d3-0768-43c4-951a-1a92a95106da', 'dbc1f7ae-3231-4604-96a3-687d84e07bd3', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('0f552d26-b4fc-4c3a-ad2a-2b9181ee965b', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0015', 'C├®lia Adriana Alves da Silva Nascimento', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('85ae76df-a018-4a3c-b8cb-09df3c2effba', '0f552d26-b4fc-4c3a-ad2a-2b9181ee965b', '', '', NULL, 'Divorciada ', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('f02e05f2-69eb-4444-8e54-cfbe0eeb1a70', '0f552d26-b4fc-4c3a-ad2a-2b9181ee965b', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('e9b7991e-e2bf-42ac-b821-1355e71a1b6b', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0016', 'Nirlene Dalva Silva', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('7456d30c-a5b8-4452-a877-7f3acc66efc4', 'e9b7991e-e2bf-42ac-b821-1355e71a1b6b', '', '', NULL, 'Divorciada ', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('ac9ff25c-22c1-40cc-800c-bef51a903e2d', 'e9b7991e-e2bf-42ac-b821-1355e71a1b6b', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('d04acfe5-8275-413c-bfd9-1b2e25929d2f', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0017', 'Priscilla Kely Coelho Amorim Noleto', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('4ae7bad5-47e1-4e0e-8719-5675734cd16f', 'd04acfe5-8275-413c-bfd9-1b2e25929d2f', '', '', NULL, 'Casada', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('facf50e6-9971-4d1e-8d91-5e3066045516', 'd04acfe5-8275-413c-bfd9-1b2e25929d2f', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('e4fcee64-c7a5-435d-87e7-ed1286a9cbb0', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0018', 'F├ítima Gomes de Macedo', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('6c97c6fc-4d14-4a33-a3d2-ff10fad40201', 'e4fcee64-c7a5-435d-87e7-ed1286a9cbb0', '', '', NULL, 'casada ', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('014e2b76-0db0-41e6-b3c0-b9ac736ad7ff', 'e4fcee64-c7a5-435d-87e7-ed1286a9cbb0', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('117e10b0-405f-4d6d-891c-122050f53886', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0019', 'Marina In├®s Marro', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('01751e11-320c-4fc0-bdcc-1100bef56c20', '117e10b0-405f-4d6d-891c-122050f53886', '', '', NULL, 'Soltera', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('c28903ca-63c5-4c3b-83f6-725e61852ef5', '117e10b0-405f-4d6d-891c-122050f53886', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('bfd4d33f-9558-4858-b18c-6bb1da99c433', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0020', 'MARISA DA COSTA GONZALEZ CASTRO', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('1aaf4d26-5dde-454e-8d19-a43cd4b10ae0', 'bfd4d33f-9558-4858-b18c-6bb1da99c433', '', '', NULL, 'Casada', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('36e09474-1266-46ba-ab38-854740125a43', 'bfd4d33f-9558-4858-b18c-6bb1da99c433', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('6d5254e7-157e-4ce3-b1c3-beb4daadfae2', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0021', 'Eduardo Pereira da Costa', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('e294566b-e6f3-448c-a509-110e31edec4c', '6d5254e7-157e-4ce3-b1c3-beb4daadfae2', '', '', NULL, 'Casado', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('b6e7b45b-4ba5-433b-9b69-a81ea447b626', '6d5254e7-157e-4ce3-b1c3-beb4daadfae2', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('e177f4f8-d399-43c2-8091-350ef2f882df', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0022', 'Maria L├¡dia de Almeida', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('048109a4-e92c-4b73-be11-3ca61768ac12', 'e177f4f8-d399-43c2-8091-350ef2f882df', '', '', NULL, 'Divorciada. ', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('d2df95ca-fa74-41f6-b0ef-68ee0e4d8ead', 'e177f4f8-d399-43c2-8091-350ef2f882df', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('cc13c4f5-2029-4ba6-acd1-ddfe60f7f137', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0023', 'Erika Stapf', 'Sócio', 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('2ca2c707-65ac-4623-8756-e76590c81eb8', 'cc13c4f5-2029-4ba6-acd1-ddfe60f7f137', '', '', NULL, 'Solteira ', 'brasileira', '', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('ee010af7-725e-455a-bcbc-60e3fcd04344', 'cc13c4f5-2029-4ba6-acd1-ddfe60f7f137', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.048Z', '2026-02-04T20:18:37.048Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('74b57001-2776-427a-932b-278b224326be', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0024', 'Janio Marques Cotrim', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('93af02a7-af0a-49c7-b08d-8f56a6b26791', '74b57001-2776-427a-932b-278b224326be', '', '', NULL, 'Divorcado', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('afa3c08d-db03-473b-bf51-c8e8f03353db', '74b57001-2776-427a-932b-278b224326be', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('3348c105-5f21-42f6-89a1-ea589ce29120', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0025', 'Marta Maria e Silva Monte', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('91ff1c72-0027-4625-a756-fd31a61d4c3a', '3348c105-5f21-42f6-89a1-ea589ce29120', '', '', NULL, 'Casada ', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('edaebb1c-31e0-4019-ac84-a4ef34e0a1e9', '3348c105-5f21-42f6-89a1-ea589ce29120', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('cbb183e9-8d9b-4e3c-aa4b-bdbeb3dbd3d3', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0026', 'Plautino de Oliveira Laroque', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('34180e70-4102-4454-87fd-b5861cc180d8', 'cbb183e9-8d9b-4e3c-aa4b-bdbeb3dbd3d3', '', '', NULL, 'Casado ', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('e6f8db48-fa65-480e-980a-7db839172081', 'cbb183e9-8d9b-4e3c-aa4b-bdbeb3dbd3d3', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('8fb484f3-62b0-4185-bb36-c1ebef7f7ddb', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0027', 'Rita Aparecida Schmitt', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('a6c34b8b-60c0-418e-a65f-fa48b4b90b91', '8fb484f3-62b0-4185-bb36-c1ebef7f7ddb', '', '', NULL, 'Casada', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('d59581ad-f32e-4e75-9828-0e718d39796b', '8fb484f3-62b0-4185-bb36-c1ebef7f7ddb', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('9ee9ad02-95f2-470c-a59d-5f675dfef512', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0028', 'Maria de fatima Alencar Costa', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('651b16bf-96a7-450d-af58-c6b0c3f85d85', '9ee9ad02-95f2-470c-a59d-5f675dfef512', '', '', NULL, 'VIUVA', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('9aec8fbc-dfd2-41ec-bbc0-8d0aef4f5edf', '9ee9ad02-95f2-470c-a59d-5f675dfef512', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('6df1e9c6-d003-4a4f-b174-183633fca528', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0029', 'Kathlen Kalvelage Philippi', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('a08f6c42-5cfa-4636-9dbc-fc464b50b638', '6df1e9c6-d003-4a4f-b174-183633fca528', '', '', NULL, 'Solteira ', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('4209561e-e1ea-46b8-928e-123d4454275d', '6df1e9c6-d003-4a4f-b174-183633fca528', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('933644f2-df11-4e49-a5f4-6bce660dc4db', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0030', 'Maria Nelma Ferreira lima', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('4c5cadce-b3aa-4b04-9c58-4122b5fb5db2', '933644f2-df11-4e49-a5f4-6bce660dc4db', '', '', NULL, 'Vi├║va ', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('1f25572c-93a9-4873-ae47-8a635fa58f98', '933644f2-df11-4e49-a5f4-6bce660dc4db', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('82f418ae-4f04-4735-b63a-d3243dab1612', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0031', 'JOAN├â CARVALHO MITOURA MOREIRA', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('69a6a570-8ed5-48f7-81df-9bce95d6ff44', '82f418ae-4f04-4735-b63a-d3243dab1612', '', '', NULL, 'casada', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('faa91a81-7637-477c-b760-2df45b2d244a', '82f418ae-4f04-4735-b63a-d3243dab1612', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('7cea725d-bae1-45cb-86e5-2542f1c2106b', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0032', 'Luana Rafaela Maciel Wilda', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('87cd92a7-b35a-4e08-a648-f287df09aa9a', '7cea725d-bae1-45cb-86e5-2542f1c2106b', '', '', NULL, 'Solteira', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('1295c943-5e91-4edf-9e0c-7975d2a35a89', '7cea725d-bae1-45cb-86e5-2542f1c2106b', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('7091eab2-af13-4ce5-b79d-8c78f19a9dbf', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0033', 'Eun├®lia Aparecida da Cruz Guiza', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('f1abbac3-3f28-425a-adbc-1293193b3e75', '7091eab2-af13-4ce5-b79d-8c78f19a9dbf', '', '', NULL, 'Casada ', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('c7a8c884-12f6-47c8-a60d-be88585073af', '7091eab2-af13-4ce5-b79d-8c78f19a9dbf', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('198e21a8-bf97-4a11-bae8-a9b04afe58a6', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0034', 'Marcio Jazar Zanikoski', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('bf73413b-fa03-4368-9955-c099f78176e8', '198e21a8-bf97-4a11-bae8-a9b04afe58a6', '', '', NULL, 'Separado judicialmente ', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('bb480e20-dd1b-4c7a-9edf-cfaca22d6f38', '198e21a8-bf97-4a11-bae8-a9b04afe58a6', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('88edfde8-a042-46e9-b285-3f0e3012ff47', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0035', 'Marisane Dadall', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('c1c299ec-821a-438a-ad16-660bf65ab7c9', '88edfde8-a042-46e9-b285-3f0e3012ff47', '', '', NULL, 'Uni├úo est├ível ', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('e661f01e-2f7c-4545-aece-b3302be3ce26', '88edfde8-a042-46e9-b285-3f0e3012ff47', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('17aae2b0-cd2f-4df8-af4f-3fc01937dc1c', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0036', 'Luiz Gonzaga Caneiro', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('5fa6a29d-f8d2-4bee-9af1-39449ef077bf', '17aae2b0-cd2f-4df8-af4f-3fc01937dc1c', '', '', NULL, 'Solteiro', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('e7add1a9-3382-45b6-a46c-a592f86233b5', '17aae2b0-cd2f-4df8-af4f-3fc01937dc1c', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('8687de2d-763c-464b-865f-0ee65625ff54', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0037', 'Eulaine de Oliveira Pereira Pombeiro', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('f480ba09-d340-4236-9376-c33751dc92f4', '8687de2d-763c-464b-865f-0ee65625ff54', '', '', NULL, 'Divorciada ', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('8cbfded3-836a-41f9-a91b-f39bb8bac2ec', '8687de2d-763c-464b-865f-0ee65625ff54', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('06b87bef-7646-4615-8bf4-38c001beeace', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0038', 'Cecilia Ferreira', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('0ca6f1a3-a6d8-410c-8688-ff3e90074120', '06b87bef-7646-4615-8bf4-38c001beeace', '', '', NULL, 'DIVORCIADA', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('05e19848-f68e-40e9-a734-f26853667955', '06b87bef-7646-4615-8bf4-38c001beeace', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('67005489-489e-407a-bfd3-3c09bab2d2c5', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0039', 'Concei├º├úo de Souza Carvalho', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('22698b10-2dfb-41f6-b999-c7bded975248', '67005489-489e-407a-bfd3-3c09bab2d2c5', '', '', NULL, 'Casada', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('a72164b2-d700-46f2-aa75-ed31190d1eef', '67005489-489e-407a-bfd3-3c09bab2d2c5', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('bfc87413-eed1-41f8-95e8-898d5133da0a', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0040', 'Wilma Chander', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('f921107b-80c6-4cdb-982f-9992caea8c10', 'bfc87413-eed1-41f8-95e8-898d5133da0a', '', '', NULL, 'Divorciada', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('6b6026b6-c633-4d55-b521-6bf19c8972c3', 'bfc87413-eed1-41f8-95e8-898d5133da0a', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('1c369926-7359-4ea0-80a6-5d1dcb74d65c', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0041', 'Janete Rosalina Rodrigues da Silva', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('e0bb27a0-7bad-4ac6-90f8-ef5ba9730914', '1c369926-7359-4ea0-80a6-5d1dcb74d65c', '', '', NULL, 'Divorciada ', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('637ebf9b-3374-494f-ba70-ed7508c28ac3', '1c369926-7359-4ea0-80a6-5d1dcb74d65c', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('3afba54d-6f11-4904-9f68-9eb8dc54c802', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0042', 'Jennifer Maria Brasil Teixeira', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('e232b27c-1de8-4cc4-a9e9-38b69976ec4b', '3afba54d-6f11-4904-9f68-9eb8dc54c802', '', '', NULL, 'Casada ', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('0392f13a-53ab-4b91-9670-3812345bbc0d', '3afba54d-6f11-4904-9f68-9eb8dc54c802', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('4d3bbe02-f6ba-4572-ac2d-2d2f6e6d2142', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0043', 'Renato Paulo Deckmann', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('b6baecb4-fc77-433e-9a96-ef73befd7a3f', '4d3bbe02-f6ba-4572-ac2d-2d2f6e6d2142', '', '', NULL, 'Divorciado', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('4c39bcac-7b04-4521-9905-81c0225588ba', '4d3bbe02-f6ba-4572-ac2d-2d2f6e6d2142', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('9a0bb81f-885f-4195-ab80-d5330c510c77', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0044', 'JACKELINE ELAINE DE OLIVEIRA', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('09301456-79ba-4b6b-9649-f7e0e3815b11', '9a0bb81f-885f-4195-ab80-d5330c510c77', '', '', NULL, 'DIVORCIADA', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('293b329e-f701-426b-a070-0760bdd4a366', '9a0bb81f-885f-4195-ab80-d5330c510c77', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('16d2a0f3-d2c0-4bab-88c6-417143444e5f', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0045', 'Gl├│ria Renata Ormandes de Sousa', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('03d3b5df-7bb4-4300-9c16-2b3fcb2f0bc2', '16d2a0f3-d2c0-4bab-88c6-417143444e5f', '', '', NULL, 'Solteira', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('bb49f6a8-3700-47ba-b90d-938083b85bf9', '16d2a0f3-d2c0-4bab-88c6-417143444e5f', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('a06ba567-745a-42ac-8727-61c9edd1d8f4', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0046', 'Maria Teresa Chimento', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('bfb64ade-1fb7-4148-b571-1b651f31923b', 'a06ba567-745a-42ac-8727-61c9edd1d8f4', '', '', NULL, 'Solteira', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('b875de99-56a0-4d94-b849-45ce8f13e8cd', 'a06ba567-745a-42ac-8727-61c9edd1d8f4', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('776a44e7-d6cf-45fc-bc05-630c3f661840', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0047', 'Elizabeth de Toledo', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('b478a937-3953-47f6-865e-9465b28053ea', '776a44e7-d6cf-45fc-bc05-630c3f661840', '', '', NULL, 'Divorciada', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('49696453-36f9-4a61-813a-8827a5b34574', '776a44e7-d6cf-45fc-bc05-630c3f661840', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('9a2d5ba8-82fa-4c8b-b848-1d2fedeae0ec', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0048', 'Maria Goreth Sala', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('850196c7-7da1-4e30-86b9-403130b37a11', '9a2d5ba8-82fa-4c8b-b848-1d2fedeae0ec', '', '', NULL, 'solteira', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('fcd9135e-a85b-4046-8cee-f39960b86eb0', '9a2d5ba8-82fa-4c8b-b848-1d2fedeae0ec', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('32fdbeb4-0fb0-4b20-93a9-358707736514', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0049', 'Oscar van Holten', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('e7b88d88-262e-4ad0-be2e-e937808e6895', '32fdbeb4-0fb0-4b20-93a9-358707736514', '', '', NULL, 'Divorciado', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('c5684e2e-dbbe-4f22-be88-d7f91ddf5618', '32fdbeb4-0fb0-4b20-93a9-358707736514', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

INSERT INTO "associado" ("id", "associacao_id", "register_number", "name", "type", "status", "entry_date", "created_at", "updated_at") 
VALUES ('fe5c469d-1b0d-43da-ac11-18904fcc4af2', '3976c2bb-b889-425d-8949-4f09607d9cbc', 'EXV-0050', 'Maria Amelia da Cruz dos Santos', 'Sócio', 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "qualificacao" ("id", "associado_id", "cpf", "rg", "birthdate", "civil_status", "nationality", "profession", "created_at", "updated_at") 
VALUES ('e9d0617f-35da-463c-bfdf-fb7e18098e22', 'fe5c469d-1b0d-43da-ac11-18904fcc4af2', '', '', NULL, 'Viuva', 'brasileira', '', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');
INSERT INTO "endereco" ("id", "associado_id", "logradouro", "numero", "bairro", "cep", "cidade", "uf", "pais", "type", "is_primary", "status", "created_at", "updated_at") 
VALUES ('f3a7595c-201d-4d65-bfb9-373d9a7167eb', 'fe5c469d-1b0d-43da-ac11-18904fcc4af2', '', '', '', '', '', '', 'Brasil', 'residencial', 1, 'ativo', '2026-02-04T20:18:37.049Z', '2026-02-04T20:18:37.049Z');

