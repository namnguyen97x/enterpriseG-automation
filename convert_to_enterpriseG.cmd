@echo off
:: Convert offline install.wim to Enterprise G edition and apply debloat/policy
:: Usage: convert_to_enterpriseG.cmd path_to_install.wim
setlocal
if "%~1"=="" (
    echo Usage: %~nx0 path_to_install.wim
    exit /b 1
)
set "WIMFILE=%~1"
set "MOUNT=C:\mount_EnterpriseG"
if exist "%MOUNT%" rd /s /q "%MOUNT%"
md "%MOUNT%"
:: Mount first index
Dism /Mount-Wim /WimFile:"%WIMFILE%" /index:1 /MountDir:"%MOUNT%"
:: Set edition to EnterpriseG
Dism /Image:"%MOUNT%" /Set-Edition:EnterpriseG /ProductKey:YYVX9-NTFWV-6MDM3-9PT4T-4M68B /AcceptEula
:: Load offline hives
reg load HKLM\OfflineSystem "%MOUNT%\Windows\System32\config\SYSTEM"
reg load HKLM\OfflineSoftware "%MOUNT%\Windows\System32\config\SOFTWARE"
:: Import registry tweaks and defender/edge
reg import "%~dp0regedit.reg"
reg import "%~dp0defender.reg"
reg import "%~dp0edge.reg"
:: Import hardware bypass (LabConfig)
reg import "%~dp0labconfig.reg"
:: Unload hives
reg unload HKLM\OfflineSystem
reg unload HKLM\OfflineSoftware
:: Prepare Setup Scripts and Debloat script
if not exist "%MOUNT%\Windows\Setup\Scripts" md "%MOUNT%\Windows\Setup\Scripts"
copy /Y "%~dp0RemoveEdge.cmd" "%MOUNT%\Windows\Setup\Scripts\RemoveEdge.cmd" >nul
copy /Y "%~dp0SetupComplete.cmd" "%MOUNT%\Windows\Setup\Scripts\SetupComplete.cmd" >nul
copy /Y "%~dp0debloat.ps1" "%MOUNT%\Windows\Setup\Scripts\debloat.ps1" >nul
copy /Y "%~dp0regedit.reg" "%MOUNT%\Windows\Setup\Scripts\regedit.reg" >nul
copy /Y "%~dp0defender.reg" "%MOUNT%\Windows\Setup\Scripts\defender.reg" >nul
copy /Y "%~dp0edge.reg" "%MOUNT%\Windows\Setup\Scripts\edge.reg" >nul
copy /Y "%~dp0labconfig.reg" "%MOUNT%\Windows\Setup\Scripts\labconfig.reg" >nul
:: Unmount wim and commit
Dism /Unmount-Wim /MountDir:"%MOUNT%" /Commit
endlocal
