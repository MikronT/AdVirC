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
echo.      ^(1^) Uninstall
echo.      ^(0^) Cancel
echo.
echo.
echo.
set /p command=%inputBS%   ^(^>^) Enter command ^> 
if "%command%" == "0" exit /b
if "%command%" NEQ "1" goto :uninstallQuestion



if exist files\backups\registry\HKUConsoleCMD_Backup.reg reg import files\backups\registry\HKUConsoleCMD_Backup.reg

for /f "tokens=1,2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do set location_desktop=%%k
if exist "%location_desktop%\AdVirC.lnk" del /q "%location_desktop%\AdVirC.lnk"



%loadingUpdate% stop
for /f "delims=" %%i in ('dir /a:-d /b /s') do if "%%i" NEQ "%cd%\uninstall.cmd" (
  echo.  ^(i^) Deleting "%%i".
  del /f /q "%%i"
)
start cmd /c "timeout /nobreak /t 3 && rd /s /q "%uninstallDirectory%""
exit