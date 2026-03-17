# Documentação do Projeto: Carros

## 1. Visão Geral
O **Carros** é um sistema de gestão de oficinas mecânicas que permite o controle de veículos, clientes e ordens de serviço. O aplicativo foi desenvolvido para facilitar o acompanhamento de manutenções, histórico de veículos e controle financeiro básico.

## 2. Tecnologias Utilizadas
- **Linguagem:** Dart
- **Framework:** [Flutter](https://flutter.dev/)
- **Backend/Database:** [Supabase](https://supabase.com/)
- **Estilização:** FlutterFlow Theme (Inter Tight / Inter)
- **Autenticação:** Supabase Auth

---

## 3. Arquitetura do Projeto

### Pastas Principais
- `lib/pages/`: Contém as telas (Widgets) e seus respectivos modelos de estado.
- `lib/backend/supabase/`: Integração com o banco de dados (tabelas e modelos de linha).
- `lib/auth/`: Lógica de autenticação e gerenciamento de usuários.
- `lib/flutter_flow/`: Utilitários de tema e componentes base gerados.

---

## 4. Banco de Dados (Supabase)

### Tabela `veiculo`
Armazena as informações dos veículos cadastrados.
- **Campos:** `id`, `marca`, `modelo`, `placa`, `contato`, `cor`, `ano`, `criado_em`.

### Tabela `os` (Ordens de Serviço)
Armazena os registros de manutenção.
- **Campos:** `id`, `numero`, `veiculo_id` (FK), `km_veiculo`, `status`, `descricao`, `valor_mao_obra`, `valor_peca`, `valor_total`, `data_entrada`, `data_previsao`, `data_conclusao`, `mecanico_responsavel`.
- **Destaque:** O campo `numero` é gerado automaticamente via trigger no banco de dados.

---

## 5. Funcionalidades Principais

### Dashboard
- Resumo visual do status da oficina.
- Contadores de Total de Veículos, OS em Andamento, OS Concluídas e Total de OS.
- Exibição da versão do sistema (**v1.0.0**) no canto superior direito.

### Gestão de Veículos
- **Listagem:** Visualização de todos os veículos com busca por placa ou modelo.
- **Cadastro/Edição:** Registro de novos veículos com informações detalhadas.
- **Histórico:** Visualização de todas as Ordens de Serviço vinculadas a um veículo específico no formato de linha do tempo.

### Ordens de Serviço (OS)
- **Listagem:** Filtros por status e busca avançada (Número, Modelo ou Placa).
- **Cadastro de OS:**
    - Seleção de veículo via busca inteligente.
    - Cálculo automático do valor total (Mão de Obra + Peças).
    - Controle de datas (Entrada, Previsão e Conclusão automática).
    - Status: Pendente, Em Andamento, Concluído, Cancelado.

### Perfil do Usuário
- Exibição do e-mail do usuário autenticado.
- Alteração de foto de perfil (armazenamento local via SharedPreferences).
- Função de Logout.

---

## 6. Padronização Visual
- **Paleta de Cores:** Fundo escuro (Dark Mode) com detalhes em cinza (#F1F4F8) e cores primárias para destaque.
- **Tipografia:** Uso das fontes *Inter Tight* para títulos e *Inter* para textos.
- **Favicon:** Logo personalizado (Águia) aplicado no navegador e no ícone do aplicativo (PWA).

---

## 7. Instruções para Desenvolvedores

### Rodar o Projeto
```powershell
flutter run -d chrome
```

### Gerar Build de Produção
```powershell
flutter build web --release
```

### Sincronização de Banco
Scripts SQL como `supabase_fix_numero.sql` e `supabase_add_column.sql` devem ser executados no Editor SQL do Supabase para manter o esquema atualizado.
