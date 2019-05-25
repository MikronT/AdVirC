@echo off
chcp 65001>nul

setlocal EnableDelayedExpansion
net session>nul 2>nul
if !errorLevel! GEQ 1 (
  echo.^(^^^!^) Please, run as Admin^^^!
  timeout /nobreak /t 1 >nul

  echo.^(^?^) Run anyway^? [Y/N]
  choice /c yn /d n /t 3 /n /m " > "
  if "!errorLevel!" NEQ "1" exit
)
endlocal

%~d0
cd "%~dp0"



set program_name=AdVirC
set program_version_code=2.0.0.2.1.0
set program_version_name=%program_name% v2.0 Beta 1 [MikronT]

set method=call subroutines\methods.cmd
set logo=%method% :logo main
set loadingUpdate=%method% :loadingUpdate

set module_sleep=subroutines\modules\sleep.exe

set setting_appearance_logo=Ш
set setting_appearance_theme=0b

set dataDir=data
set settings=%dataDir%\settings\settings.ini

set key_wait=0

for /f "tokens=1,2,* delims=- " %%i in ("%*") do (
  if "%%i" NEQ "" set key_%%i
  if "%%j" NEQ "" set key_%%j
)

if exist "%settings%" for /f "eol=# delims=" %%i in (%settings%) do set setting_%%i



if "%key_wait%" NEQ "0" %module_sleep% %key_wait%



if exist temp rd /s /q temp
md temp>nul 2>nul

if "%setting_appearance_logo%"       == "0" set setting_appearance_logo=Ш
if "%setting_appearance_logo:~1,1%"  NEQ "" set setting_appearance_logo=Ш
if "%setting_appearance_theme:~2,1%" NEQ "" set setting_appearance_theme=0b

if not exist %dataDir%\backups md %dataDir%\backups>nul 2>nul

%loadingUpdate% reset



reg export HKCU\Console\%%SystemRoot%%_system32_cmd.exe %dataDir%\backups\consoleSettings.reg /y >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v CodePage         /t REG_DWORD /d 65001      /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v ColorTable00     /t REG_DWORD /d 0          /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FaceName         /t REG_SZ    /d Consolas   /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FontFamily       /t REG_DWORD /d 0x0000036  /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FontSize         /t REG_DWORD /d 0x00100008 /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v FontWeight       /t REG_DWORD /d 0x0000190  /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v ScreenBufferSize /t REG_DWORD /d 0x2329006a /f >nul
reg add HKCU\Console\%%SystemRoot%%_system32_cmd.exe /v WindowSize       /t REG_DWORD /d 0x001e006e /f >nul



start subroutines\loading.cmd
start subroutines\main.cmd
exit