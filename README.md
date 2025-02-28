Link: https://youtu.be/nl_Iks7-Q0o


# **Tarefa Pad**

Um aplicativo Flutter simples para gerenciar tarefas, permitindo adicionar, editar e excluir tarefas. As tarefas são armazenadas localmente no dispositivo usando o pacote `shared_preferences`.

---

## **Funcionalidades**

1. **Adicionar Tarefas**
   - Digite um título e uma descrição para adicionar uma nova tarefa.
   - Tarefas são salvas automaticamente no armazenamento local.

2. **Editar Tarefas**
   - Atualize o título ou a descrição de uma tarefa existente.

3. **Excluir Tarefas**
   - Remova tarefas da lista permanentemente.

4. **Persistência de Dados**
   - As tarefas são armazenadas localmente no dispositivo usando `shared_preferences`.
   - Mesmo após fechar o aplicativo, os dados das tarefas permanecem salvos.

---

## **Estrutura do Código**

### **1. Tela Principal - `PaginaInicial`**
- Contém a lista de tarefas atuais.
- Exibe as tarefas em um `ListView`.
- Inclui um botão flutuante para adicionar novas tarefas.

### **2. Gerenciamento de Tarefas**
- **Adicionar Tarefa:** 
  - Usa um diálogo para inserir título e descrição.
  - Chama a função `adicionarTarefa`.
- **Editar Tarefa:**
  - Usa um diálogo para atualizar os dados da tarefa selecionada.
  - Chama a função `editarTarefa`.
- **Excluir Tarefa:**
  - Remove a tarefa selecionada da lista.
  - Chama a função `excluirTarefa`.

### **3. Persistência de Dados**
- **Salvar Tarefas:** 
  - Converte a lista de tarefas para JSON usando `jsonEncode` e armazena no `shared_preferences`.
- **Carregar Tarefas:**
  - Recupera os dados do `shared_preferences` ao inicializar o aplicativo.
  - Converte o JSON de volta para uma lista de tarefas.

---

## **Como Executar o Projeto**

1. **Pré-requisitos**
   - Flutter SDK instalado.
   - Editor de código como VS Code ou Android Studio.

2. **Instalação**
   - Clone este repositório.
   - Execute o comando:
     ```bash
     flutter pub get
     ```

3. **Execução**
   - Conecte um dispositivo ou emulador.
   - Execute o comando:
     ```bash
     flutter run
     ```

---

## **Exemplo de Funcionamento**

1. **Adicionar uma Nova Tarefa**
   - Clique no botão flutuante `+`.
   - Insira o título e a descrição.
   - Clique em "Salvar".

2. **Editar uma Tarefa**
   - Clique no ícone de lápis na tarefa desejada.
   - Atualize as informações e clique em "Salvar".

3. **Excluir uma Tarefa**
   - Clique no ícone de lixeira na tarefa desejada.

---

## **Tecnologias Utilizadas**

- **Flutter**: Framework para criação de aplicativos multiplataforma.
- **Dart**: Linguagem de programação utilizada no Flutter.
- **Shared Preferences**: Persistência de dados local.

---

## **Melhorias Futuras**

- Adicionar filtros para tarefas concluídas e pendentes.
- Sincronizar tarefas com uma API remota.
- Melhorar a interface do usuário com animações.

---
