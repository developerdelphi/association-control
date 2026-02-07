# Associação Management System (v1)

Um sistema moderno e robusto para gestão de associações, construído com as tecnologias mais recentes do ecossistema Vue/Nuxt. O projeto foca em uma experiência de usuário (UX) premium com animações fluidas e uma interface limpa e intuitiva.

## 🚀 Tecnologias

- **Framework**: [Nuxt 4](https://nuxt.com/) (Compatibility Mode)
- **UI Kit**: [Nuxt UI v4](https://ui.nuxt.com/) (baseado em Tailwind CSS v4 e Reka UI)
- **Animações**: [Motion Vue](https://motion.dev/docs/vue) (motion-v) para transições orgânicas.
- **ORM**: [Prisma](https://www.prisma.io/) com banco de dados SQLite.
- **Estilização**: [Tailwind CSS v4](https://tailwindcss.com/) para design responsivo e moderno.
- **Autenticação**: JWT (JsonWebToken) e Bcrypt.js para segurança de senhas.
- **Linguagem**: TypeScript para maior segurança e produtividade.

## ✨ Funcionalidades Principais

- **Gestão de Associados**: Cadastro completo incluindo qualificação (CPF/RG), endereços múltiplos, contatos e dados bancários.
- **Controle Financeiro**: Gestão de pagamentos com diferentes tipos, status de pendência e histórico por associado.
- **Painel Administrativo**: Visão geral com estatísticas e cards dinâmicos.
- **Interface Premium**:
  - Animações de subida e fade-in na troca de páginas e paginação de tabelas.
  - Sidebar interativa e responsiva.
  - Sistema de máscaras de entrada inteligente (Maska).
- **Segurança**: Sistema de login com papéis de usuário (Admin/Editor) e fluxo de aprovação de novos usuários.

## 📦 Instalação e Execução

Para rodar este projeto localmente, siga os passos abaixo:

1. **Clonar o repositório**:
   ```bash
   git clone https://github.com/seu-usuario/Asssociation-v1.git
   cd Asssociation-v1
   ```

2. **Instalar dependências**:
   ```bash
   npm install
   ```

3. **Configurar variáveis de ambiente**:
   Crie um arquivo `.env` na raiz do projeto com as seguintes variáveis (exemplo):
   ```env
   DATABASE_URL="file:./dev.db"
   JWT_SECRET="sua_chave_secreta_aqui"
   ```

4. **Preparar o banco de dados**:
   ```bash
   npx prisma generate
   npx prisma migrate dev
   npx prisma db seed
   ```

5. **Iniciar o servidor de desenvolvimento**:
   ```bash
   npm run dev
   ```

## 🛠️ Estrutura do Projeto

- `app/`: Contém todo o frontend Nuxt (páginas, componentes, composables, assets).
- `server/`: Contém a lógica de backend (API routes, middlewares, utilitários).
- `prisma/`: Esquema do banco de dados e arquivos de migração.

## 📄 Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.

---
Desenvolvido com ❤️ por Leo.
