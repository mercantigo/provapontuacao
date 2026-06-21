param(
  [switch]$Pause
)

$ErrorActionPreference = "Stop"

function Finish {
  param([int]$Code)
  if ($Pause) {
    Write-Host ""
    Read-Host "Pressione ENTER para fechar" | Out-Null
  }
  exit $Code
}

function Fail {
  param([string]$Message)
  Write-Host ""
  Write-Host "ERRO: $Message" -ForegroundColor Red
  Finish 1
}

function Run-Git {
  param([string[]]$Arguments)
  & git @Arguments
  if ($LASTEXITCODE -ne 0) {
    throw "git $($Arguments -join ' ') falhou com codigo $LASTEXITCODE."
  }
}

function Capture-Git {
  param([string[]]$Arguments)
  $out = & git @Arguments 2>&1
  if ($LASTEXITCODE -ne 0) {
    throw "git $($Arguments -join ' ') falhou: $out"
  }
  return @($out)
}

try {
  Set-Location -LiteralPath $PSScriptRoot

  Write-Host "========================================"
  Write-Host " Publicar Aventura das Palavras"
  Write-Host "========================================"
  Write-Host ""

  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Fail "Git nao encontrado neste computador."
  }
  if (-not (Test-Path -LiteralPath ".git")) {
    Fail "Esta pasta nao e um repositorio Git."
  }
  if (-not (Test-Path -LiteralPath "index.html")) {
    Fail "index.html nao encontrado."
  }
  if (-not (Test-Path -LiteralPath "exercicios.json")) {
    Fail "exercicios.json nao encontrado."
  }

  Write-Host "Validando arquivos..."
  try {
    Get-Content -Raw -LiteralPath "exercicios.json" | ConvertFrom-Json | Out-Null
  } catch {
    Fail "exercicios.json esta com erro de JSON. Corrija antes de publicar."
  }

  if (Test-Path -LiteralPath "vercel.json") {
    try {
      Get-Content -Raw -LiteralPath "vercel.json" | ConvertFrom-Json | Out-Null
    } catch {
      Fail "vercel.json esta com erro de JSON. Corrija antes de publicar."
    }
  }

  $html = Get-Content -Raw -LiteralPath "index.html"
  if ($html -notmatch "exercicios\.json") {
    Fail "index.html nao parece carregar exercicios.json."
  }

  $branch = (Capture-Git @("branch", "--show-current")) -join ""
  if ([string]::IsNullOrWhiteSpace($branch)) {
    Fail "Nao consegui descobrir a branch atual."
  }

  $origin = (Capture-Git @("remote", "get-url", "origin")) -join ""
  if ([string]::IsNullOrWhiteSpace($origin)) {
    Fail "Remote origin nao configurado."
  }

  Write-Host "Branch: $branch"
  Write-Host "Destino: $origin"
  Write-Host ""

  $changes = Capture-Git @("status", "--porcelain")
  if ($changes.Count -eq 0) {
    Write-Host "Nada mudou. Nao ha conteudo novo para publicar." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Site final:"
    Write-Host "https://www.renatazavodini.com.br/provapontuacao/"
    Finish 0
  }

  Write-Host "Mudancas encontradas:"
  $changes | ForEach-Object { Write-Host "  $_" }
  Write-Host ""

  Write-Host "Preparando commit..."
  Run-Git @("add", "-A")

  $changesAfterAdd = Capture-Git @("status", "--porcelain")
  if ($changesAfterAdd.Count -eq 0) {
    Write-Host "Nada para commitar depois do git add." -ForegroundColor Yellow
    Finish 0
  }

  $stamp = Get-Date -Format "yyyy-MM-dd HH:mm"
  $message = "Atualiza site $stamp"
  Run-Git @("commit", "-m", $message)

  Write-Host ""
  Write-Host "Enviando para o GitHub..."
  Run-Git @("push", "origin", $branch)

  Write-Host ""
  Write-Host "Publicado no GitHub com sucesso." -ForegroundColor Green
  Write-Host "O Vercel esta conectado ao GitHub e deve atualizar o site automaticamente."
  Write-Host ""
  Write-Host "Aguarde 1 ou 2 minutos e confira:"
  Write-Host "https://www.renatazavodini.com.br/provapontuacao/"
  Write-Host ""
  Write-Host "Dashboard Vercel:"
  Write-Host "https://vercel.com/mercantigos-projects/provapontuacao"

  Finish 0
} catch {
  Write-Host ""
  Write-Host "ERRO: $($_.Exception.Message)" -ForegroundColor Red
  Finish 1
}
