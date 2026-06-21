# 🦉 Aventura das Palavras — Jogo de Português

Um joguinho gamificado para seu filho estudar para a prova de português,
com o mascote **Pingo, a Coruja**. Funciona **offline**, no navegador.

## ▶️ Como abrir
Dê **dois cliques** no arquivo **`index.html`**.
Ele abre no navegador (Chrome, Edge, Firefox). Funciona no computador, tablet ou celular.

> Dica: no tablet a experiência fica ótima, porque é tudo com toque na tela.

## 🎮 O que tem no jogo
4 mundos + 1 chefão, cada um para um conteúdo que cai na prova.
**Cada mundo tem 3 níveis de dificuldade: 🟢 Fácil, 🟡 Médio e 🔴 Difícil.**

| Mundo | Conteúdo da prova |
|---|---|
| 🌳 **Mundo do Til** | Palavras nasais com til (ã, õ). No Difícil entram plurais: leões, pães, mãos |
| 🏰 **Castelo M ou N** | **M antes de P e B**, **N antes das outras**. No Difícil: M no fim (também, jardim, álbum) |
| 🏖️ **Praia ÃO ou AM** | **ÃO** (pão, leão) x **AM** (brincaram). No Difícil: futuro x passado (viajarão x viajaram) |
| 🚉 **Estação do Ponto** | **Ponto final** no lugar certo. No Difícil há frases com vírgula (que NÃO leva ponto) |
| 🎧 **Ditado do Pingo** | A coruja **fala** a palavra (voz do navegador) e a criança **escreve**. Treina escrever nasais de ouvido |
| 🐉 **Chefão Final** | Tudo misturado e bem difícil! Você tem **3 vidas** — cada erro o dragão tira uma ❤️ |

São mais de **150 questões** no total.

### 🎧 Sobre o Ditado (voz)
- Use os botões **🔊 Ouvir**, **🐢 Devagar** e **💬 Na frase** para escutar.
- Há botões de **acento** (ã, õ, ç, á...) para facilitar escrever no teclado.
- Precisa de um navegador com voz em português (Chrome/Edge no Windows já têm). Se o aparelho não tiver voz, a palavra aparece escrita para copiar.

## 🌟 Gamificação
- Pontos 💎 e estrelas ⭐ por acerto
- Cada nível dá até **3 estrelas** (quanto mais acertos, mais estrelas)
- **Todos os mundos já começam abertos no nível 🟢 Fácil.** Os níveis 🟡 Médio e 🔴 Difícil abrem ao ganhar estrela no nível anterior daquele mundo
- 💡 **Dicas escondidas**: botão de dica com até **3 ajudas por questão** (cada uma revela um pouco mais)
- ⚡ **Sem confirmar**: ao escolher já mostra o resultado e a resposta certa, e avança sozinho
- O **Chefão fica bloqueado** até você ter pelo menos 1 estrela em cada um dos 5 mundos
- **4 medalhas**: 🥇 todos os Fáceis · 🏆 todos os Médios · 🎖️ todos os Difíceis · 👑 vencer o Chefão
- Sons de acerto/erro, confete e animações (dá pra desligar o som no 🔊 do canto)
- O progresso fica **salvo** no navegador automaticamente

## 🎬 Vídeo da aula
Dentro do jogo, na tela inicial, há o botão **"Ver a aula em vídeo"** que abre o
vídeo recomendado no YouTube.

## 💡 Dica para os pais
Deixe a criança jogar livremente. Cada erro mostra a resposta certa com uma
explicação curta, então o próprio jogo já vai ensinando. Para reforçar, peça que
ela leia em voz alta a palavra/ frase certa depois de cada acerto.

---

## ✏️ Como adicionar ou trocar questões (exercicios.json)

Todas as questões ficam no arquivo **`exercicios.json`**. É só abrir num editor
de texto (Bloco de Notas, VS Code...), mexer e salvar.

> 💡 O jogo **puxa** o `exercicios.json` quando roda **num servidor** ou pelo
> **`servidor.bat`**. Se você abrir o `index.html` por duplo-clique (sem servidor),
> o navegador bloqueia a leitura do `.json` e o jogo usa uma **cópia de reserva**
> embutida — ou seja, suas edições só aparecem via servidor.

### Para testar suas edições no seu PC
Dê dois cliques em **`servidor.bat`**. Ele abre o jogo em `http://localhost:8080`
já lendo o seu `exercicios.json`. (Precisa do Node instalado, que você já tem.)
Para parar, feche a janela preta.

### Para publicar para os amigos
Suba **os dois arquivos juntos** (`index.html` + `exercicios.json`) no mesmo lugar
(Netlify, GitHub Pages etc.). No servidor o jogo lê o JSON sozinho.

### Estrutura do arquivo
```json
{
  "versao": 1,
  "questoesPorMundo": 5,
  "questoesChefao": 0,
  "mundos": [ ...lista de mundos... ],
  "chefao": [ ...lista de questões misturadas... ]
}
```

### 🎲 Quantas questões por rodada (sorteio)
- **`questoesPorMundo`**: quantas questões o jogador responde **em cada nível** de um mundo.
  - Se o banco do nível tiver **mais** questões que esse número, o jogo **sorteia** aleatoriamente, **sem repetir**, só daquele nível. A cada jogada vem um sorteio diferente (ótimo para treinar!).
  - Se o banco tiver **menos ou igual**, ele usa todas.
  - Use **`0`** para responder **todas** as questões do nível.
- **`questoesChefao`**: mesma ideia, só para o Chefão. `0` = todas (16).
- **Por mundo específico**: dá para sobrescrever colocando `"questoes": N` dentro de um mundo. Ex.: o Ditado com `"questoes": 8` e o resto seguindo o `questoesPorMundo`.

Exemplo dentro de um mundo:
```json
{
  "titulo": "🎧 Ditado do Pingo",
  "tipo": "voz",
  "classe": "m5",
  "desc": "Ouça e escreva a palavra.",
  "questoes": 8,
  "niveis": [ ... ]
}
```

Cada **mundo** tem 3 níveis (Fácil/Médio/Difícil) e um `tipo` que define o jogo:

| `tipo` | O que faz | Como é cada questão (item) |
|---|---|---|
| `grafia` | Escolher a escrita certa | `{ "emoji":"🍎", "resp":"maçã", "ops":["maca","maçã","masã"] }` — ou troque `emoji` por `"clue":"uma dica escrita"` |
| `mn` | Completar com M ou N | `{ "emoji":"🌾", "exibe":"ca_po", "resp":"M", "full":"campo" }` (o `_` é onde entra a letra) |
| `aoam` | ÃO ou AM (palavras inteiras) | `{ "emoji":"🛝", "frase":"Ontem elas ___ aqui.", "a":"brincaram", "b":"brincarão", "correta":"brincaram", "tip":"dica da 3ª ajuda" }` |
| `ponto` | Pôr o ponto final | cada item é uma **lista de frases**: `["Primeira frase","Segunda frase"]` |
| `voz` | Ouvir e escrever | `{ "palavra":"coração", "frase":"O coração bate forte." }` |
| `silaba` | Separar sílabas | `{ "silabas":["es","tra","da"] }` (já dividido — o jogo confere a divisão) |

Exemplo de um mundo completo:
```json
{
  "titulo": "🌳 Mundo do Til",
  "tipo": "grafia",
  "classe": "m1",
  "desc": "Escreva certo as palavras nasais (til ~).",
  "niveis": [
    { "nome":"Fácil",   "cor":"nf", "grau":"🟢", "itens":[ {"emoji":"🍞","resp":"pão","ops":["pao","pão","pãu"]} ] },
    { "nome":"Médio",   "cor":"nm", "grau":"🟡", "itens":[ ... ] },
    { "nome":"Difícil", "cor":"nd", "grau":"🔴", "itens":[ ... ] }
  ]
}
```

Dicas para não errar o JSON:
- O `titulo` deve **começar com um emoji + espaço** (vira o ícone do mundo).
- `classe`: cor do card — use `m1` a `m6` (verde, roxo, azul, laranja, rosa, azul-claro).
- No nível, `cor` pode ser `nf` (verde), `nm` (amarelo) ou `nd` (vermelho); `grau` é o emoji 🟢🟡🔴.
- No Castelo M/N, o nível Difícil usa `"tipo":"grafia"` (escolher a palavra inteira).
- Vírgulas: separe itens com vírgula, **mas não** ponha vírgula depois do último.
- Em caso de dúvida, copie um item que já existe e só troque as palavras.
- Se quebrar o JSON, o jogo cai na cópia de reserva — então nada some; é só corrigir.

---
Conteúdo alinhado aos descritores: nasalidade (til, m, n), relações M/N por
posição, terminação ÃO x AM, uso do ponto final e separação de sílabas.
