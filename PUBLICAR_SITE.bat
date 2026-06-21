@echo off
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0publicar-site.ps1" -Pause
exit /b %ERRORLEVEL%
