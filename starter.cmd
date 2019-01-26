@echo off

net session>nul 2>nul
if %errorLevel% GEQ 1 goto :startAsAdmin

%~d0
cd "%~dp0"



set appName=AdVirC
set version=2.0 Pre-Alpha
set versionName=%appName% (Version %version% Windows10) [MikronT]

set loadingUpdate=call design\loadingUpdate.cmd
set logo=call design\mainLogo.cmd
set module_sleep=subroutines\modules\sleep.exe


for /f "eol=# delims=" %%i in (languages\english.lang) do set lang_%%i
for /f "tokens=2*" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v lastLoggedOnUserSID') do set lastLoggedOnUserSID=%%j



if exist temp rd /s /q temp

md files\backups\registry>nul 2>nul
md temp>nul 2>nul

%loadingUpdate% reset



reg export HKU\%lastLoggedOnUserSID%\Console\%%SystemRoot%%_system32_cmd.exe files\backups\registry\HKUConsoleCMD_Backup.reg /y>nul 2>nul
reg add HKU\%lastLoggedOnUserSID%\Console\%%SystemRoot%%_system32_cmd.exe /v CodePage         /t REG_DWORD /d 65001      /f>nul 2>nul
reg add HKU\%lastLoggedOnUserSID%\Console\%%SystemRoot%%_system32_cmd.exe /v ColorTable00     /t REG_DWORD /d 0          /f>nul 2>nul
reg add HKU\%lastLoggedOnUserSID%\Console\%%SystemRoot%%_system32_cmd.exe /v FaceName         /t REG_SZ    /d Consolas   /f>nul 2>nul
reg add HKU\%lastLoggedOnUserSID%\Console\%%SystemRoot%%_system32_cmd.exe /v FontFamily       /t REG_DWORD /d 0x0000036  /f>nul 2>nul
reg add HKU\%lastLoggedOnUserSID%\Console\%%SystemRoot%%_system32_cmd.exe /v FontSize         /t REG_DWORD /d 0x00100008 /f>nul 2>nul
reg add HKU\%lastLoggedOnUserSID%\Console\%%SystemRoot%%_system32_cmd.exe /v FontWeight       /t REG_DWORD /d 0x0000190  /f>nul 2>nul
reg add HKU\%lastLoggedOnUserSID%\Console\%%SystemRoot%%_system32_cmd.exe /v ScreenBufferSize /t REG_DWORD /d 2329006a   /f>nul 2>nul
reg add HKU\%lastLoggedOnUserSID%\Console\%%SystemRoot%%_system32_cmd.exe /v WindowSize       /t REG_DWORD /d 1e006a     /f>nul 2>nul



start design\loading.cmd
start subroutines\main.cmd
exit





:startAsAdmin
echo.^(^!^) Please, run as Admin^!
timeout /nobreak /t 3 >nul
exit