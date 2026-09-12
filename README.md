# Swift iOS Labs

Experimentos em SwiftUI feitos durante o **Hackatruck MakerSpace**, programa de capacitação em
desenvolvimento iOS do **Instituto Eldorado** — UFMT, 2026.

Cada pasta é um app pequeno e completo que isola *uma* capacidade da plataforma: consumo de API,
IA generativa com saída estruturada, visão computacional, layout de catálogo. Não são produtos; são
exercícios. Estão juntos porque o valor está no conjunto — mostram o caminho de "Hello, World" até
Vision e Core ML em poucas semanas.

> O projeto final do programa é o [**Blink**](https://github.com/LucasLimaT/Blink) — aplicativo
> educacional de eletrônica com diagnóstico de componentes por câmera, feito em equipe. Ali entrei
> na integração do modelo Core ML com o app Swift.

---

## Os experimentos

### `01-hello-world/` — Primeiro app

O ponto de partida do curso: estrutura de um projeto SwiftUI, `@main`, `App`, `Scene` e a primeira
`View`.

`SwiftUI`

### `02-pokedex/` — Consumo de API REST com async/await

Grid de Pokémon carregado da [PokeAPI](https://pokeapi.co). O foco foi a camada de rede:
`URLSession` com `async/await`, validação explícita do status HTTP, `Codable` com `CodingKeys` e um
`id` derivado da URL do recurso em vez de confiar num campo do payload.

`SwiftUI` · `URLSession` · `async/await` · `Codable` · `LazyVGrid` · `NavigationStack`

### `03-catalogo-tv/` — Layout de catálogo

Catálogo de filmes e séries no estilo streaming: modelos `Identifiable`/`Hashable`, navegação e
composição de células. Exercício de layout e modelagem de dados.

`SwiftUI` · `NavigationStack`

### `04-visao-computacional/` — OCR e síntese de voz

Seleciona uma foto da galeria, extrai o texto com o framework **Vision** e lê o resultado em voz alta
com `AVSpeechSynthesizer`. Um pipeline curto de acessibilidade: imagem → texto → áudio.

`SwiftUI` · `Vision` · `PhotosUI` · `AVFoundation`

### `05-ia-generativa/` — LLM com saída estruturada

App que recebe o nome de um alien do Ben 10 e devolve nome, poderes e imagem. O interessante não é o
tema: é forçar o modelo a responder **JSON estrito** via `responseMIMEType: "application/json"` e
`systemInstruction`, para que a resposta caia direto num `Codable` sem parsing frágil de markdown.

`SwiftUI` · `Firebase AI` · `Gemini` · `Codable` · saída estruturada de LLM

---

## Rodando

`03-catalogo-tv`, `04-visao-computacional` e `05-ia-generativa` têm cada um o seu `.xcodeproj` —
abra no Xcode 16+ e rode no simulador.

O `02-pokedex` guarda só os fontes: o arquivo de projeto não foi versionado na época. Crie um app
SwiftUI novo no Xcode e arraste os `.swift` e o `Assets.xcassets` para dentro.

O `05-ia-generativa/` precisa de um projeto Firebase com o Firebase AI habilitado: crie o seu no
[console do Firebase](https://console.firebase.google.com), baixe o `GoogleService-Info.plist` e
coloque na pasta do projeto. O arquivo não acompanha este repositório porque contém a configuração
de um projeto Firebase específico.

O `04-visao-computacional/` funciona no simulador, mas o resultado do OCR fica melhor em aparelho.
