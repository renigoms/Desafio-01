### Desafio Flutter: **Lista de Tarefas com Filtragem e Gráficos**

#### Descrição:
Crie um aplicativo Flutter que funcione como uma lista de tarefas. O app deve permitir que o usuário adicione, edite, conclua e exclua tarefas. Além disso, o aplicativo deve exibir um gráfico que mostre a proporção de tarefas concluídas em relação às pendentes.

#### Requisitos:
1. **Interface (UI):**
   - Uma página principal com:
     - Um campo de texto e botão para adicionar novas tarefas.
     - Uma lista exibindo as tarefas criadas.
     - Botões para editar, excluir ou marcar/desmarcar tarefas como concluídas.
   - Uma segunda página para visualizar gráficos de progresso.
   - Um tema consistente (cores, fontes, etc.).

2. **Funcionalidades obrigatórias:**
   - Use o **Provider** ou **Riverpod** para gerenciamento de estado.
   - Armazene as tarefas localmente no dispositivo usando o **SharedPreferences** ou **Hive**.
   - Implemente a funcionalidade de filtragem (mostrar apenas tarefas concluídas, pendentes ou todas).
   - Crie uma navegação usando o `GoRouter` com pelo menos duas páginas.
   - Implemente um gráfico (usando um pacote como `fl_chart`) para exibir as tarefas concluídas vs. pendentes.

3. **Validação:**
   - Adicione validação ao campo de texto para evitar que o usuário adicione tarefas vazias.
   - Mostre um alerta ao excluir uma tarefa para confirmar a ação.

4. **Extras (opcional):**
   - Adicione animações ao adicionar ou remover tarefas (use o `AnimatedList` ou `AnimatedContainer`).
   - Inclua uma função para priorizar tarefas, movendo-as para o topo da lista.
   - Implemente suporte a múltiplos idiomas usando o pacote **intl**.

5. **Entrega:**
   - O aplicativo deve ser responsivo e funcionar bem em telas pequenas e grandes.
   - Opcionalmente, publique o código no GitHub com um arquivo README.md descrevendo o desafio.

Boa sorte! Se precisar de ajuda com algum ponto específico, é só perguntar. 🚀
