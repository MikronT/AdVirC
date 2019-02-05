%~d0
cd %~dp0
set uninstallDirectory=%cd%



:uninstallQuestion
set command=command
call design\mainLogo.cmd
for /f %%a in ('"prompt $h & echo on & for %%b in (1) do rem"') do set inputBS=%%a

echo.  ^(^i^) Uninstall Directory: %cd%
echo.
echo.  ^(^?^) Do you want to uninstall AdVirC^?
echo.      ^(0^) Cancel
echo.      ^(1^) Uninstall
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
del /q "%location_desktop%\AdVirC.lnk"



for /f "delims=" %%i in ('dir /a:-d /b /s') do if "%%i" NEQ "%cd%\uninstall.cmd" del /f /q "%%i"
start cmd /c "timeout /nobreak /t 2 >nul && rd /s /q "%uninstallDirectory%""
exit