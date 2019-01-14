%logo%
echo.%lang-initialization%
%loadingUpdate% 3



set debugLog=nul
set deleteScript=temp\deleteScript.cmd
set log=nul
set module-moveFile=subroutines\modules\movefile.exe
set module-shortcut=subroutines\modules\shortcut.exe
set module-unZip=subroutines\modules\unzip.exe
set module-wget=subroutines\modules\wget.exe
set rebootScript=temp\rebootScript.cmd
set setting-autoUpdateDatabases=true
set setting-autoUpdateProgram=false
set setting-debug=false
set setting-firstRun=true
set setting-lang=lang
set setting-logging=true
set setting-remindDatabasesUpdates=true
set setting-remindProgramUpdates=true
set setting-updateChannel=release
set settings=files\settings.ini



for /f "delims=" %%i in (files\fileList.db) do if not exist "%%i" call echo.%%i>>files\reports\corruptedFilesList.db
for /f "delims=" %%i in (files\fileList.db) do if not exist "%%i" goto :corrupted
%loadingUpdate% 2



for /f "tokens=1,2,* delims=;" %%i in (files\userShellFolders.db) do (
  set %%iLocation=%%k
  for /f "skip=1 tokens=1,2,*" %%l in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v %%j') do set %%iLocation=%%n
)
for /f "tokens=1,2,* delims=." %%i in ("%date%") do set currentDate=%%k.%%j.%%i
if exist %settings% for /f "eol=# delims=" %%i in (%settings%) do set setting-%%i
%loadingUpdate% 5



md files\reports\shortcuts>nul 2>nul



if "%setting-logging%" == "true" (
  md files\logs>nul 2>nul
  set log="files\logs\%appName%_log_%currentDate%.log"
  if "%setting-debug%" == "true" set debugLog="files\logs\%appName%_debugLog_%currentDate%.log"
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
echo.Processor Architecture: %PROCESSOR_ARCHITECTURE%>>%debugLog%
echo.>>%debugLog%
call :logLineAppend %debugLog% 1
echo.Running tasks:>>%debugLog%
echo.>>%debugLog%
tasklist>>%debugLog%
echo.>>%debugLog%
call :logLineAppend %debugLog% 1

echo.User Shell Folders:>>%debugLog%
for /f "tokens=1,* delims=;" %%i in (files\userShellFolders.db) do echo.%%i Location: %%%iLocation%>>%debugLog%



echo.>%deleteScript%

echo.@echo off>%rebootScript%
echo.chcp 65001>>%rebootScript%



%logo%
%loadingUpdate% 12



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
  rem reg export HKCR files\backups\registry\HKCR.reg>>%debug_log%
  %loadingUpdate% 3
  rem reg export HKLM files\backups\registry\HKLM.reg>>%debug_log%
  %loadingUpdate% 5
  rem reg export HKU  files\backups\registry\HKU.reg >>%debug_log%
  %loadingUpdate% 6
  reg export HKCC files\backups\registry\HKCC.reg>>%debug_log%
  %loadingUpdate% 1
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
%module-sleep% 2
%loadingUpdate% 1
%module-sleep% 1
goto :mainMenu

























:languageMenu
set command=command
%logo%
echo.%lang-languageMenu01%
echo.^(1^) English
echo.^(2^) Русский
echo.^(3^) Українська
echo.
echo.%lang-back%
echo.
echo.
echo.
set /p command=%lang-enterCommand%



if "%command%" == "0" exit /b
if "%command%" NEQ "1" if "%command%" NEQ "2" if "%command%" NEQ "3" goto :languageMenu

if "%command%" == "1" set setting-lang=english
if "%command%" == "2" set setting-lang=russian
if "%command%" == "3" set setting-lang=ukrainian
call :settingsSave
exit /b







:mainMenu
set command=command
%logo%
%loadingUpdate% reset
echo.%lang-mainMenu01%
echo.%lang-mainMenu02%
echo.%lang-mainMenu03%
echo.%lang-mainMenu04%
echo.%lang-mainMenu05%
echo.%lang-mainMenu06%
echo.%lang-mainMenu07%
echo.%lang-mainMenu08%
echo.%lang-mainMenu09%
echo.
echo.
echo.
if "%setting-firstRun%" == "true" (
  echo.%lang-firstRunMenuNotification01%
  echo.%lang-firstRunMenuNotification02%
  echo.%lang-firstRunMenuNotification03%
  echo.%lang-firstRunMenuNotification04%
  echo.
  echo.
  echo.
  set setting-firstRun=false
  call :settingsSave
)
set /p command=%lang-enterCommand%



if "%command%" == "1" call :deleteMenu
rem if "%command%" == "2" call :exceptionsMenu
if "%command%" == "3" call subroutines\databasesUpdate.cmd
if "%command%" == "4" call :importMenu
rem if "%command%" == "5" call :helpMenu
rem if "%command%" == "6" call :report
rem if "%command%" == "7" call :about
if "%command%" == "8" call :settingsMenu
if "%command%" == "9" call :clearTemp
if "%command%" == "0" call :exit
if "%command%" == "#" call uninstall.cmd

if exist temp\rebootNow goto :exit reboot
goto :mainMenu







:deleteMenu
set command=command
%logo%
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
echo.%lang-deleteMenu22%
echo.%lang-back%
echo.%lang-deleteMenu23%
set /p command=%lang-enterCommand%



if "%command%" == "0" exit /b
for /l %%i in (1,1,5) do if "%command%" == "%%i" (
  set deleteLevel=%command%
  call subroutines\cleaning.cmd
  exit /b
)
goto :deleteMenu







:importMenu
set command=command
%logo%
echo.%lang-importMenu01%
echo.%lang-importMenu02%
echo.
echo.%lang-back%
echo.
echo.
echo.
if "%importError%" == "1" (
  color c
  set importError=0
  echo.%lang-importError%
  echo.
  echo.
  echo.
)
set /p command=%lang-enterCommand%



if "%command%" == "0" exit /b
if "%command%" == "1" (
  if not exist %desktopLocation%\adVirCDatabases.zip (
    set importError=1
    goto :importMenu
  )
  set importReturnCode=1
  call subroutines\databasesUpdate.cmd
  exit /b
)
goto :importMenu







:settingsMenu
set command=command
%logo%
echo.%lang-settingsMenu01%
echo.%lang-settingsMenu02% %setting-lang%

if "%setting-logging%" == "true" (
  echo.%lang-settingsMenu03% %lang-settingEnabled%
) else echo.%lang-settingsMenu03% %lang-settingDisabled%

if "%setting-debug%" == "true" (
  echo.%lang-settingsMenu04% %lang-settingEnabled%
) else echo.%lang-settingsMenu04% %lang-settingDisabled%

echo.
echo.%lang-settingsMenu05%
echo.%lang-settingsMenu06% %setting-updateChannel%

if "%setting-autoUpdateProgram%" == "true" (
  call echo.%lang-settingsMenu07% %lang-settingEnabled%
) else call echo.%lang-settingsMenu07% %lang-settingDisabled%

if "%setting-autoUpdateDatabases%" == "true" (
  echo.%lang-settingsMenu08% %lang-settingEnabled%
) else echo.%lang-settingsMenu08% %lang-settingDisabled%

if "%setting-remindProgramUpdates%" == "true" (
  call echo.%lang-settingsMenu09% %lang-settingEnabled%
) else call echo.%lang-settingsMenu09% %lang-settingDisabled%

if "%setting-remindDatabasesUpdates%" == "true" (
  echo.%lang-settingsMenu10% %lang-settingEnabled%
) else echo.%lang-settingsMenu10% %lang-settingDisabled%

echo.
echo.%lang-back%
echo.
echo.
echo.
set /p command=%lang-enterCommand%



if "%command%" == "0" exit /b
if "%command%" == "1" (
  call :languageMenu
  call :languageImport
)

if "%command%" == "2" if "%setting-logging%" == "true" (
  set setting-logging=false
) else if "%setting-logging%" == "false" (
  set setting-logging=true
) else set setting-logging=true

if "%command%" == "3" if "%setting-debug%" == "true" (
  set setting-debug=false
) else if "%setting-debug%" == "false" (
  set setting-debug=true
) else set setting-debug=false

if "%command%" == "4" call :updateChannelMenu

if "%command%" == "5" if "%setting-autoUpdateProgram%" == "true" (
  set setting-autoUpdateProgram=false
) else if "%setting-autoUpdateProgram%" == "false" (
  set setting-autoUpdateProgram=true
) else set setting-autoUpdateProgram=false

if "%command%" == "6" if "%setting-autoUpdateDatabases%" == "true" (
  set setting-autoUpdateDatabases=false
) else if "%setting-autoUpdateDatabases%" == "false" (
  set setting-autoUpdateDatabases=true
) else set setting-autoUpdateDatabases=true

if "%command%" == "7" if "%setting-remindProgramUpdates%" == "true" (
  set setting-remindProgramUpdates=false
) else if "%setting-remindProgramUpdates%" == "false" (
  set setting-remindProgramUpdates=true
) else set setting-remindProgramUpdates=true

if "%command%" == "8" if "%setting-remindDatabasesUpdates%" == "true" (
  set setting-remindDatabasesUpdates=false
) else if "%setting-remindDatabasesUpdates%" == "false" (
  set setting-remindDatabasesUpdates=true
) else set setting-remindDatabasesUpdates=true

call :settingsSave
goto :settingsMenu







:updateChannelMenu
set command=command
%logo%
echo.%lang-updateChannelMenu01%
echo.%lang-updateChannelMenu02%
echo.%lang-updateChannelMenu03%
echo.%lang-updateChannelMenu04%
echo.
echo.%lang-back%
echo.
echo.
echo.
set /p command=%lang-enterCommand%



if "%command%" == "0" exit /b
if "%command%" == "1" set setting-updateChannel=release
if "%command%" == "2" set setting-updateChannel=beta
if "%command%" == "3" set setting-updateChannel=nightly
exit /b







:languageImport
for /f "eol=# delims=" %%i in (languages\%setting-lang%.lang) do set lang-%%i
echo.Language: %setting-lang%>>%log%
exit /b







:logLineAppend
for /l %%z in (%2,-1,1) do echo.======================================================================================================================>>%1
exit /b







:settingsSave
echo.# %appName% Settings #>%settings%
echo.autoUpdateDatabases=%setting-autoUpdateDatabases%>>%settings%
echo.autoUpdateProgram=%setting-autoUpdateProgram%>>%settings%
echo.debug=%setting-debug%>>%settings%
echo.firstRun=%setting-firstRun%>>%settings%
echo.lang=%setting-lang%>>%settings%
echo.logging=%setting-logging%>>%settings%
echo.remindDatabasesUpdates=%setting-remindDatabasesUpdates%>>%settings%
echo.remindProgramUpdates=%setting-remindProgramUpdates%>>%settings%
echo.updateChannel=%setting-updateChannel%>>%settings%
exit /b







:clearTemp
for %%i in (files\logs files\reports temp) do (
  if exist %%i rd /s /q %%i
  if not exist %%i md %%i>nul 2>nul
)
exit /b







:corrupted
%logo%
%loadingUpdate% reset
echo.Program Corrupted!>>%log%
echo.^(!^) %appName% Diagnostics: 
echo.   Program Corrupted!
echo.^(i^) Files missing:
for /f "delims=" %%i in (files\reports\corruptedFilesList.db) do echo.    --^> %%i
echo.
echo.^(!^) Reinstall %appName%!
pause>nul
call :exit







:exit
call :settingsSave

reg import files\backups\registry\HKUConsoleCMD_Backup.reg

%loadingUpdate% stop
%module-sleep% 3

if "%1" == "reboot" ( shutdown /r /t 0 ) else if exist temp rd /s /q temp
exit