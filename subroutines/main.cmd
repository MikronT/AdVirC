%logo%
echo.%lang-initialization%
%loadingUpdate% 3



set debugLog=nul
set importBasesBoolean=0
set importError=0
set loadingReset=call design\loadingReset.cmd
set log=nul
set moduleMoveFile=subroutines\modules\movefile.exe
set moduleShortcut=subroutines\modules\shortcut.exe
set moduleUnZip=subroutines\modules\unzip.exe
set moduleWget=subroutines\modules\wget.exe
set reboot=temp\rebootScript.cmd
set setting-autoUpdate=false
set setting-debug=false
set setting-firstRun=true
set setting-lang=lang
set setting-logging=true
set setting-updateChannel=stable
set settings=settings.ini



for /f "tokens=1,2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do set desktopLocation=%%k
for /f "tokens=1,2,* delims=." %%i in ("%date%") do set currentDate=%%k.%%j.%%i
if exist settings.ini for /f "eol=# delims=" %%i in (settings.ini) do set setting-%%i



md files\reports\shortcuts>nul 2>nul
%loadingUpdate% 5



for /f "delims=" %%i in (files\fileList.db) do if not exist "%%i" call echo.%%i>>files\reports\corruptedFilesList.db
for /f "delims=" %%i in (files\fileList.db) do if not exist "%%i" goto :corrupted
%loadingUpdate% 2



if "%setting-logging%" == "true" (
  md files\logs>nul 2>nul
  set log="files\logs\AdVirC_log_%currentDate%.log"
  if "%setting-debug%" == "true" set debugLog="files\logs\AdVirC_debugLog_%currentDate%.log"
)
%loadingUpdate% 4



if exist %log% call :logLineAppend %log% 3
echo.Log ^| %versionName% ^| %logDate%>>%log%
echo.>>%log%
call :logLineAppend %log% 1



if exist %debugLog% call :logLineAppend %debugLog% 3
echo.Debug Log ^| %versionName% ^| %logDate%>>%debugLog%
echo.>>%debugLog%
echo.Operating System: %OS%>>%debugLog%
echo.Current Directory: %cd%>>%debugLog%
echo.Current File Directory: %~dp0>>%debugLog%
echo.User Profile Directory: %userProfile%>>%debugLog%
echo.Desktop Location: %desktopLocation%>>%debugLog%
echo.Processor Architecture: %PROCESSOR_ARCHITECTURE%>>%debugLog%
echo.>>%debugLog%
call :logLineAppend %debugLog% 1
echo.Running tasks:>>%debugLog%
echo.>>%debugLog%
tasklist>>%debugLog%
echo.>>%debugLog%
call :logLineAppend %debugLog% 1



echo.@echo off>%reboot%
echo.chcp 65001>>%reboot%



%logo%
%loadingUpdate% 12



:language
if "%setting-lang%" NEQ "english" if "%setting-lang%" NEQ "russian" if "%setting-lang%" NEQ "ukrainian" call :languageMenu
call :languageImport
%loadingUpdate% 1





%logo%
echo.^(i^) %versionName%
echo.%lang-selectedLanguage%
echo.%lang-initializationRun%
%loadingUpdate% 1



if not exist files\reports\systemInfo.rpt systeminfo>files\reports\systemInfo.rpt
%loadingUpdate% 2



if "%setting-firstRun%" == "true" (
  if exist "%AppData%\Mozilla\Firefox\Profiles" (
    echo.%%mozillaFirefoxUserProfile%%>temp\tempMozillaFirefoxUserProfile
    for /d %%x in (%AppData%\Mozilla\Firefox\Profiles\*) do for /f "tokens=1,2,3,4,5,6,7,8,9* delims=\" %%i in ("%%x") do call set mozillaFirefoxUserProfile=%%q
    for /f "delims=" %%i in (temp\tempMozillaFirefoxUserProfile) do call echo.%%i>files\reports\mozillaFirefoxUserProfile.rpt
    call echo.%lang-mozillaFirefoxUserProfile%
  )
  %loadingUpdate% 2

  echo.%lang-creatingRegistryBackup%
  REM reg export HKLM files\backups\registry\HKLM.reg>>%debug_log%
  %loadingUpdate% 3
  reg export HKCU files\backups\registry\HKCU.reg>>%debug_log%
  %loadingUpdate% 3
  REM reg export HKCR files\backups\registry\HKCR.reg>>%debug_log%
  %loadingUpdate% 3
  REM reg export HKU  files\backups\registry\HKU.reg >>%debug_log%
  %loadingUpdate% 3
  REM reg export HKCC files\backups\registry\HKCC.reg>>%debug_log%
  %loadingUpdate% 3
  echo.%lang-registryBackupCreated%
) else (
  for /f "delims=" %%i in (files\reports\mozillaFirefoxUserProfile.rpt) do set mozillaFirefoxUserProfile=%%i
  %loadingUpdate% 17
)



echo.%%lastLoggedOnUserSID%%>temp\tempLastLoggedOnUserSID
for /f "tokens=2*" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnUserSID') do set lastLoggedOnUserSID=%%j
for /f "delims=" %%i in (temp\tempLastLoggedOnUserSID) do call echo.%%i>files\reports\lastLoggedOnUserSID.rpt
call echo.%lang-lastLoggedOnUserSID%



call echo.%lang-processorArchitecture%
%loadingUpdate% 2



echo.>>%log%
echo.>>%log%
echo.>>%log%
%moduleSleep% 2
%loadingUpdate% 1
%moduleSleep% 1
goto :mainMenu










:languageMenu
set command=command
%logo%
echo.^(!^) Select language:
echo. ║
echo.^(0^) English                                                   ^(1^) Русский
echo. ║                                                             ║
echo.^(2^) Українська                                                 ║
echo. ║                                                             ║
echo. ╠═════════════════════════════════════════════════════════════╝
echo. ║
set /p command=^(^>^) Language number ^> 


%logo%
if "%command%" == "0" goto :languageMenuCommand
if "%command%" == "1" goto :languageMenuCommand
if "%command%" == "2" goto :languageMenuCommand
goto :languageMenu


:languageMenuCommand
if "%command%" == "0" set setting-lang=english
if "%command%" == "1" set setting-lang=russian
if "%command%" == "2" set setting-lang=ukrainian
exit /b







:languageImport
for /f "eol=# delims=" %%i in (languages\%setting-lang%.lang) do set lang-%%i
echo.Language: %setting-lang%>>%log%
exit /b







:mainMenu
%loadingReset%
set command=command
%logo%
echo.%lang-mainMenu1%
echo. ║                                                             ║
echo.%lang-mainMenu2%
echo. ║                                                             ║
echo.%lang-mainMenu3%
echo. ║
echo.%lang-mainMenu4%
echo. ║                                                             ║
echo. ╠═════════════════════════════════════════════════════════════╝
echo. ║

if "%setting-firstRun%" == "true" (
  echo.%lang-firstRunMenuNotification1%
  echo.%lang-firstRunMenuNotification2%
  echo.%lang-firstRunMenuNotification3%
  echo.%lang-firstRunMenuNotification4%
  echo. ║
  echo. ║
  echo. ║
  set setting-firstRun=false
)
set /p command=%lang-enterCommand% 


%logo%
if "%command%" == "0" call :exit
if "%command%" == "1" call :deleteMenu
if "%command%" == "2" call subroutines\databasesUpdate.cmd
if "%command%" == "3" call :importDatabasesMenu
if "%command%" == "4" call :settingsMenu
if "%command%" == "5" call uninstall.cmd

if exist temp\rebootNow goto :exit reboot
goto :mainMenu







:deleteMenu
set command=command
%logo%
echo.%lang-selectDeleteMode%
echo.%lang-deleteMenu01%
echo.%lang-deleteMenu02%
echo.%lang-deleteMenu03%
echo.%lang-deleteMenu04%
echo.%lang-deleteMenu05%
echo.%lang-deleteMenu06%
echo.%lang-deleteMenu07%
echo.%lang-deleteMenu08%
echo.%lang-deleteMenu09%
echo.%lang-deleteMenu10%
echo.%lang-deleteMenu11%
echo.%lang-deleteMenu12%
echo.%lang-deleteMenu13%
echo.%lang-deleteMenu14%
echo.%lang-deleteMenu15%
echo.%lang-deleteMenu16%
echo.%lang-deleteMenu17%
echo.%lang-deleteMenu18%
echo.%lang-deleteMenu19%
echo.%lang-deleteMenu20%
echo.%lang-deleteMenu21%
echo. ║
set /p command=%lang-enterCommand% 


%logo%
if "%command%" == "0" exit /b
if "%command%" == "1" goto :deleteMenuCommand
if "%command%" == "2" goto :deleteMenuCommand
if "%command%" == "3" goto :deleteMenuCommand
if "%command%" == "4" goto :deleteMenuCommand
if "%command%" == "5" goto :deleteMenuCommand
goto :deleteMenu


:deleteMenuCommand
set deleteLevel=%command%
call subroutines\deleteInterface.cmd
exit /b







:importDatabasesMenu
set command=command
%logo%
echo.%lang-importMenu1%
echo. ║
echo.%lang-importMenu2%
echo. ║                                                             ║
echo. ╠═════════════════════════════════════════════════════════════╝
echo. ║
if %importError% == 1 (
  color c
  set importError=0
  echo.%lang-importError%
  echo. ║
  echo. ║
  echo. ║
)
set /p command=%lang-enterCommand% 


%logo%
if "%command%" == "0" exit /b
if "%command%" == "1" goto :importDatabasesMenuCommand
goto :importDatabasesMenu


:importDatabasesMenuCommand
if not exist %SystemDrive%:\avcDatabases.zip (
  set importError=1
  goto :importDatabasesMenu
)
%loadingUpdate% 10
set importBasesBoolean=1
call subroutines\databasesUpdate.cmd
exit /b







:settingsMenu
set command=command
%logo%
set /p command=%lang-enterCommand% 
exit /b







:logLineAppend
for /l %%z in (%2,-1,1) do echo.======================================================================================================================>>%1
exit /b







:corrupted
%logo%
%loadingReset%
echo.Program Corrupted!>>%log%
echo.^(!^) AdVirC Diagnostics: 
echo.   Program Corrupted!
echo.^(!^) Files missing:
for /f "delims=" %%i in (files\reports\corruptedFilesList.db) do echo.    --^> %%i
echo.
echo.^(!^) Reinstall AdVirC!
pause>nul
exit







:exit
echo.# %appName% Settings #>settings.ini
echo.autoUpdate=%setting-autoUpdate%>>settings.ini
echo.debug=%setting-debug%>>settings.ini
echo.firstRun=%setting-firstRun%>>settings.ini
echo.lang=%setting-lang%>>settings.ini
echo.logging=%setting-logging%>>settings.ini
echo.updateChannel=%setting-updateChannel%>>settings.ini

reg import files\backups\registry\HKUConsoleCMD_Backup.reg

if "%1" == "reboot" shutdown /r /t 0

taskkill /f /im cmd.exe /t
exit