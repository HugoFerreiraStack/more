# B3 — Cotações em Tempo Real

Um app para acompanhar ações da bolsa brasileira. 

---

## O que você vai encontrar

Dá para explorar uma lista de ativos, buscar por ticker ou nome da empresa, ordenar do jeito que preferir e ver os detalhes de cada ação. Também tem uma carteira de favoritos — basta dar estrela nos ativos que você acompanha e acessar tudo numa aba separada.

---

## Rodando o projeto

### O que você precisa

- [Flutter](https://flutter.dev/docs/get-started/install) instalado (SDK ^3.10.3)
- Um emulador ou dispositivo físico
- Internet (as cotações vêm de uma API)

### Passos

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/HugoFerreiraStack/more.git
   ```

2. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

3. **Execute**:
   ```bash
   flutter run
   ```

   Ou rode direto pelo seu editor, se preferir.

Em dispositivo físico, conecte via USB com a depuração ativada ou use um emulador

---

## Arquitetura: Clean Architecture

O código segue **Clean Architecture**. A ideia é separar bem as camadas e deixar cada uma com sua responsabilidade.

### As camadas

- **Domain** — O coração do negócio. Aqui ficam as entidades, contratos de repositório e casos de uso. Nada de Flutter, banco ou API.
- **Data** — Implementação real das coisas: chamadas HTTP, leitura/escrita local. É por aqui que conversamos com o mundo externo.
- **Presenter** — Tudo que o usuário vê e interage. Páginas, widgets, controladores. Usa o domain e o GetX pra estado e navegação.

### Por que fazer assim?

- Fica mais fácil testar — a lógica de negócio está isolada.
- Dá pra trocar API, storage, etc.
- O código fica mais previsível e fácil de manter.

---

## Estrutura do projeto

```
lib/
├── config/                 # Configurações globais
│   ├── accessibility/      # Acessibilidade (Semantics)
│   ├── responsive/         # Layout responsivo
│   ├── routes/             # Rotas
│   └── themes/             # Cores e estilos
│
├── core/                   # Núcleo da aplicação
│   ├── constants/          # URLs e constantes da API
│   ├── errors/             # Tratamento de erros
│   ├── network/            # Cliente HTTP (Dio)
│   └── result/             # Result e utilitários
│
└── features/
    ├── home/               # Listagem e detalhes de ações
    │   ├── domain/         # Models, repository, usecase
    │   ├── data/           # Implementação do repositório
    │   └── presenter/      # Páginas, widgets, controllers
    │
    ├── wallet/             # Carteira de favoritos
    │   └── presenter/
    │
    ├── splash/             # Tela inicial
    │   └── presenter/
    │
    └── shared/             # Controllers e bindings globais
```

---

## O que foi feito

### Navegação

- **Splash** — Animação de entrada antes de abrir o app.
- **TabBar** — Duas abas: Início (lista de ações) e Carteira (favoritos).
- **Detalhes** — Tela completa da ação com preço, variação, volume, setor e market cap.

### Home (lista de ações)

- Lista paginada de ativos.
- Busca por ticker ou nome.
- Ordenação por Nome, Preço ou Variação (ascendente, descendente ou sem ordenação).
- Scroll infinito pra carregar mais.
- Estados de carregamento, erro e botão de tentar de novo.
- Header que muda suavemente ao rolar.

### Carteira (favoritos)

- Adicionar e remover com o ícone de estrela.
- Busca dentro da carteira.
- Dados salvos localmente no aparelho (SharedPreferences).
- Telas para carteira vazia e busca sem resultados.

### Detalhes da ação

- Header com informações básicas.
- Card de preço e variação.
- Volume, setor, tipo e market cap.
- Botão pra adicionar/remover da carteira.

### UX e acessibilidade

- Labels de Semantics pra leitores de tela.
- Layout responsivo.
- Visual consistente em todo o app.
- Fonte Inter via Google Fonts.

---

## Tecnologias

- **Flutter** — Interface e lógica de apresentação
- **GetX** — Estado, navegação e injeção de dependências
- **Dio** — Requisições HTTP
- **Shared Preferences** — Persistência da carteira
- **Google Fonts** — Tipografia Inter

---

## API

As cotações vêm da [Brapi](https://brapi.dev/), uma API gratuita com dados da B3. O app usa o endpoint de listagem de quotes.

---

## Observações

- Na primeira execução, o `flutter pub get` e a compilação podem levar um tempinho.
- Se aparecer erro de API, vale checar a conexão e se a Brapi está no ar.
- A carteira fica salva só no dispositivo — desinstalar o app apaga tudo.


