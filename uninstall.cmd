@echo off
chcp 65001>nul

%~d0
cd %~dp0

set program_name=AdVirC
set uninstallDirectory=%cd%



:uninstallQuestion
set command=command
call design\mainLogo.cmd
for /f %%a in ('"prompt $h & echo on & for %%b in (1) do rem"') do set inputBS=%%a

echo.  ^(i^) Uninstall directory: %cd%
echo.
echo.  ^(^?^) Do you want to uninstall %program_name%^?
echo.      ^(1^) Uninstall
echo.
echo.      ^(0^) Cancel
echo.
echo.
echo.
set /p command=%inputBS%   ^(^>^) Enter command ^> 
if "%command%" == "0" exit /b
if "%command%" NEQ "1" goto :uninstallQuestion



%loadingUpdate% stop
timeout /nobreak /t 1 >nul

if exist files\backups\consoleSettingsBackup.reg reg import files\backups\consoleSettingsBackup.reg 2>nul

for /f "skip=2 tokens=2,* delims= " %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do set location_desktop=%%j
if exist "%location_desktop%\%program_name%.lnk" del /q "%location_desktop%\%program_name%.lnk"



for /f "delims=" %%i in ('dir /a:-d /b /s') do if "%%i" NEQ "%cd%\uninstall.cmd" del /f /q "%%i"
start cmd /c "timeout /nobreak /t 2 >nul && rd /s /q "%uninstallDirectory%""
exit