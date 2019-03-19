@echo off
chcp 65001>nul

net session>nul 2>nul
if %errorLevel% GEQ 1 (
  echo.^(^!^) Please, run as Admin^!
  timeout /nobreak /t 3 >nul
  exit
)

%~d0
cd "%~dp0"



set program_name=AdVirC
set program_version_code=2.0.0.0.0.0
set program_version_name=%program_name% v2.0 Pre-Alpha [MikronT]

set method=call subroutines\methods.cmd
set logo=%method% :logo main1
set loadingUpdate=%method% :loadingUpdate

set module_sleep=subroutines\modules\sleep.exe
set key_wait=0

for /f "tokens=1,2,* delims=- " %%i in ("%*") do (
  >nul set %%i
  >nul set %%j
)



if "%key_wait%" NEQ "0" %module_sleep% %key_wait%



if exist temp rd /s /q temp
md temp>nul 2>nul

if not exist files\backups md files\backups>nul 2>nul

%loadingUpdate% reset



reg export HKCU\Console\%%SystemRoot%%_system32_cmd.exe files\backups\consoleSettingsBackup.reg /y >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v CodePage         /t REG_DWORD /d 65001      /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v ColorTable00     /t REG_DWORD /d 0          /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FaceName         /t REG_SZ    /d Consolas   /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FontFamily       /t REG_DWORD /d 0x0000036  /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FontSize         /t REG_DWORD /d 0x00100008 /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FontWeight       /t REG_DWORD /d 0x0000190  /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v ScreenBufferSize /t REG_DWORD /d 0x2329006a /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v WindowSize       /t REG_DWORD /d 0x001e006e /f >nul



start design\loading.cmd
start subroutines\main.cmd
exit