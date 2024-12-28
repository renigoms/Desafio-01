### Desafio Back-End: **API REST para Gerenciamento de Tarefas**
#### Descrição:
Crie uma API RESTful que suporte as operações de gerenciamento de uma lista de tarefas. Essa API será utilizada pelo aplicativo Flutter do desafio anterior. O back-end deve armazenar as tarefas, permitir a manipulação dos dados e fornecer métricas sobre o progresso das tarefas.

---

#### Requisitos:

1. **Estrutura e Funcionalidades:**
   - **Operações CRUD:**
     - Criar uma nova tarefa (endpoint `POST /tasks`).
     - Listar todas as tarefas (endpoint `GET /tasks`).
     - Editar uma tarefa (endpoint `PUT /tasks/:id`).
     - Excluir uma tarefa (endpoint `DELETE /tasks/:id`).
     - Marcar/desmarcar uma tarefa como concluída (endpoint `PATCH /tasks/:id`).
   - **Filtros:**
     - Permitir a filtragem de tarefas por status (concluídas, pendentes ou todas) via query params (`GET /tasks?status=completed|pending|all`).

2. **Estrutura de Dados:**
   Cada tarefa deve conter os seguintes campos:
   - `id` (UUID gerado automaticamente).
   - `title` (string, obrigatório).
   - `description` (string, opcional).
   - `isCompleted` (booleano, padrão: `false`).
   - `createdAt` (timestamp, gerado automaticamente).
   - `updatedAt` (timestamp, atualizado automaticamente).

3. **Métricas e Relatórios:**
   - Um endpoint (`GET /tasks/stats`) que retorne as seguintes informações:
     - Total de tarefas.
     - Total de tarefas concluídas.
     - Total de tarefas pendentes.
     - Porcentagem de conclusão.

4. **Persistência de Dados:**
   - Use um banco de dados relacional como PostgreSQL ou MySQL.
   - Utilize uma ferramenta de migração (como Flyway, Liquibase, ou o sistema embutido do seu ORM).

5. **Validação e Tratamento de Erros:**
   - Valide os campos obrigatórios ao criar ou editar uma tarefa.
   - Retorne mensagens claras e status HTTP adequados para erros (ex.: 400, 404, 500).

6. **Segurança:**
   - Implemente autenticação utilizando tokens JWT.
   - Proteja os endpoints para que somente usuários autenticados possam acessá-los.

---

#### Extras (opcional):
- **Filtros Avançados:**
  - Permita a ordenação por `createdAt` ou `title`.
  - Adicione paginação aos resultados.
- **Histórico de Tarefas:**
  - Mantenha um histórico de alterações em cada tarefa.
- **Métricas Avançadas:**
  - Retorne a distribuição de tarefas por períodos (ex.: quantas foram criadas nos últimos 7 dias).
- **Desempenho:**
  - Adicione caching nos endpoints mais acessados usando Redis.
- **Deploy:**
  - Hospede a API em uma plataforma como Heroku, Azure, ou Railway.

---

#### Tecnologias Sugeridas:
- Linguagem: **Node.js (Express)**, **Python (Django/Flask)**, **Java (Spring Boot)** ou qualquer de sua preferência.
- Banco de Dados: **PostgreSQL** ou **MySQL**.
- ORM: **Sequelize**, **TypeORM**, **SQLAlchemy**, ou similar.

#### Entrega:
- Disponibilize o código no GitHub, com um arquivo README.md que:
  - Descreva como configurar o ambiente.
  - Liste os endpoints e exemplos de requisições.
  - Explique as decisões técnicas do projeto.

Pronto! 🚀 Se precisar de exemplos para implementar algum ponto, é só pedir!
