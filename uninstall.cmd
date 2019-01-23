%~d0
cd %~dp0
set uninstallDirectory=%cd%



:uninstallQuestion
set command=command
call design\mainLogo.cmd
echo.^(^i^) Uninstall Directory: %cd%
echo.^(^?^) Do you want to uninstall AdVirC^?
echo.    ^(0^) Uninstall
echo.    ^(1^) Cancel
echo.
set /p command=^(^>^) Enter command ^> 
if "%command%" == "1" exit /b
if "%command%" NEQ "0" goto :uninstallQuestion



if exist files\backups\registry\HKUConsoleCMD_Backup.reg reg import files\backups\registry\HKUConsoleCMD_Backup.reg

for /f "tokens=1,2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do set desktopLocation=%%k
if exist "%desktopLocation%\AdVirC.lnk" del /q "%desktopLocation%\AdVirC.lnk"



%loadingUpdate% stop
for /f "delims=" %%i in ('dir /a:-d /b /s') do if "%%i" NEQ "%cd%\uninstall.cmd" (
  echo.^(i^) Deleting "%%i".
  del /f /q "%%i"
)
start cmd /c "timeout /nobreak /t 3 && rd /s /q "%uninstallDirectory%""
exit