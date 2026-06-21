# Publicacao no GitHub e Vercel

Este projeto e um site estatico: `index.html` carrega `exercicios.json` no
mesmo diretorio. O arquivo `vercel.json` deixa a publicacao pronta para abrir em:

`https://renatazavodini.com.br/provapontuacao/`

## Publicar depois de editar

Para publicar mudancas futuras, de dois cliques em:

`PUBLICAR_SITE.bat`

Ele valida o `exercicios.json`, cria um commit automatico, envia para o GitHub e
o Vercel publica a nova versao automaticamente.

## 1. Subir para o GitHub

Se ainda nao existir repositorio no GitHub:

1. Entre em https://github.com/new
2. Crie um repositorio, por exemplo `provapontuacao`
3. Nao precisa marcar README, .gitignore ou license, porque os arquivos ja estao aqui

Depois, nesta pasta, rode:

```powershell
git remote add origin https://github.com/SEU_USUARIO/provapontuacao.git
git branch -M main
git push -u origin main
```

Se o repositorio ja existir e o remote ja estiver configurado, use apenas:

```powershell
git push
```

## 2. Importar no Vercel

1. Entre em https://vercel.com/new
2. Escolha o repositorio do GitHub
3. Framework Preset: `Other`
4. Build Command: deixe vazio
5. Output Directory: deixe vazio ou `.`
6. Deploy

Depois do deploy, teste primeiro a URL temporaria da Vercel:

`https://SEU-PROJETO.vercel.app/provapontuacao/`

## 3. Usar renatazavodini.com.br/provapontuacao/

No Vercel, adicione o dominio `renatazavodini.com.br` em:

Project Settings -> Domains

Importante: DNS aponta dominio/subdominio inteiro, nao apenas uma pasta. Entao ha
duas possibilidades:

1. Se o dominio inteiro puder apontar para este projeto da Vercel, configure o DNS
   do dominio conforme o Vercel pedir. O caminho `/provapontuacao/` ja esta pronto.
2. Se `renatazavodini.com.br` ja tem outro site em outro servidor, esse servidor
   precisa criar uma regra de proxy/redirect para o projeto da Vercel, ou o site
   principal precisa tambem ficar na Vercel para compartilhar o mesmo dominio.

Use sempre a barra final:

`https://renatazavodini.com.br/provapontuacao/`
