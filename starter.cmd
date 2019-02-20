@echo off

net session>nul 2>nul
if %errorLevel% GEQ 1 goto :startAsAdmin

%~d0
cd "%~dp0"



set appName=AdVirC
set versionCode=2.0.0.0.0.0.10
set versionName=%appName% v2.0 Pre-Alpha (Windows 10) [MikronT]

set logo=call design\mainLogo.cmd
set loadingUpdate=call design\loadingUpdate.cmd
set module_sleep=subroutines\modules\sleep.exe

set key_wait=0

for /f "tokens=1,2,* delims=- " %%i in ("%*") do (
  set %%i
  set %%j
)



if "%key_wait%" NEQ "0" %module_sleep% %key_wait%



if exist temp rd /s /q temp

md files\backups\registry>nul 2>nul
md temp>nul 2>nul

%loadingUpdate% reset



reg export HKCU\Console\%%SystemRoot%%_system32_cmd.exe files\backups\consoleSettingsBackup.reg /y>nul 2>nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v CodePage         /t REG_DWORD /d 65001      /f>nul 2>nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v ColorTable00     /t REG_DWORD /d 0          /f>nul 2>nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FaceName         /t REG_SZ    /d Consolas   /f>nul 2>nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FontFamily       /t REG_DWORD /d 0x0000036  /f>nul 2>nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FontSize         /t REG_DWORD /d 0x00100008 /f>nul 2>nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FontWeight       /t REG_DWORD /d 0x0000190  /f>nul 2>nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v ScreenBufferSize /t REG_DWORD /d 2329006a   /f>nul 2>nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v WindowSize       /t REG_DWORD /d 1e006a     /f>nul 2>nul



start design\loading.cmd
start subroutines\main.cmd
exit





:startAsAdmin
echo.^(^!^) Please, run as Admin^!
timeout /nobreak /t 3 >nul
exit