@echo off
set "SystemDrive=%SystemDrive%"
set "EdgePath=%SystemDrive%\Program Files (x86)\Microsoft\Edge\Application\1*\Installer"
set "EdgeWebViewPath=%SystemDrive%\Program Files (x86)\Microsoft\EdgeWebView\Application\1*\Installer"
cd /d "%EdgePath%" 2>nul
if exist setup.exe (
    setup.exe --uninstall --msedge --system-level --verbose-logging --force-uninstall 2>nul
)
cd /d "%EdgeWebViewPath%" 2>nul
if exist setup.exe (
    setup.exe --uninstall --msedgewebview --system-level --verbose-logging --force-uninstall 2>nul
)
cd /d "%SystemDrive%\Program Files (x86)" 2>nul
if exist Microsoft (
    rd /s /q Microsoft
)
