%~d0
cd %~dp0

call design\mainLogo.cmd



echo.Current Directory: %cd%
if exist files\backups\registry\HKUConsoleCMD_Backup.reg reg import files\backups\registry\HKUConsoleCMD_Backup.reg

for /f "tokens=1,2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do set desktopLocation=%%k
del /q "%desktopLocation%\AdVirC.lnk"



for /f "delims=" %%i in ('dir /a:-d /b /s') do if "%%i" NEQ "%cd%\uninstall.cmd" del /f /q "%%i"
start cmd /c "timeout /nobreak /t 5 && rd /s /q "%cd%""
exit