@echo off
:: Ensure filters loaded
fltmc >nul || exit /b
:: Activate license (placeholder - optional)
if exist "%~dp0activate_kms38.cmd" call "%~dp0activate_kms38.cmd"
:: Remove Microsoft Edge after installation
if exist "%~dp0RemoveEdge.cmd" call "%~dp0RemoveEdge.cmd"
:: Run debloat PowerShell script
if exist "%~dp0debloat.ps1" powershell -ExecutionPolicy Bypass -File "%~dp0debloat.ps1"
:: Import registry tweaks for current user context (they were already applied offline, but this will ensure settings for the first user)
if exist "%~dp0regedit.reg" regedit /S "%~dp0regedit.reg"
if exist "%~dp0defender.reg" regedit /S "%~dp0defender.reg"
if exist "%~dp0edge.reg" regedit /S "%~dp0edge.reg"
:: Clean up the script directory if executed from Setup\Scripts
cd \
(goto) 2>nul & (if "%~dp0"=="%SystemRoot%\Setup\Scripts\" rd /s /q "%~dp0")
