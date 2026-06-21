@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Iniciando o Jogo das Palavras...
echo.
start "" "http://localhost:8080"
node servidor.js
pause
