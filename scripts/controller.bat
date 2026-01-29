@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "controller.ps1"
if %errorlevel% neq 0 (
    echo.
    echo [!] Shuvis: PowerShell Error detected. 
    pause
)
