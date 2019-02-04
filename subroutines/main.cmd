%logo%
echo.%lang_initialization%
%loadingUpdate% 3



set setting_autoUpdateDatabases=true
set setting_autoUpdateProgram=true
set setting_debug=true
set setting_firstRun=true
set setting_lang=lang
set setting_logging=true
set setting_remindDatabasesUpdates=true
set setting_remindProgramUpdates=true
set setting_updateChannel=nightly

set settings=files\settings.ini

set module_moveFile=subroutines\modules\movefile.exe /accepteula
set module_shortcut=subroutines\modules\shortcut.exe /a:c
set module_unZip=subroutines\modules\unzip.exe -qq
set module_wget=subroutines\modules\wget.exe --quiet --show-progress --progress=bar:force:noscroll --no-check-certificate --tries=1

set filesToRemove=temp\filesToRemove.db
set rebootScript=temp\rebootScript.cmd

set cleaning_extensions=temp\cleaning\extensions.db
set cleaning_files=temp\cleaning\files.db
set cleaning_folders=temp\cleaning\folders.db
set cleaning_processes=temp\cleaning\processes.db
set cleaning_registry=temp\cleaning\registry.db
set cleaning_services=temp\cleaning\services.db
set cleaning_shortcuts=temp\cleaning\shortcuts.db
set cleaning_tasks=temp\cleaning\tasks.db
set cleaning_temp=temp\cleaning\temp.db





md files\reports\shortcuts>nul 2>nul
%loadingUpdate% 1



for /f %%a in ('"prompt $h & echo on & for %%b in (1) do rem"') do set inputBS=%%a
for /f "tokens=1,2,* delims=." %%i in ("%date%") do set currentDate=%%k.%%j.%%i
%loadingUpdate% 2



if exist "files\reports\corruptedFilesList.db" echo.>files\reports\corruptedFilesList.db
if "%key_skipFilesChecking%" NEQ "true" (
  for /f "delims=" %%i in (files\fileList.db) do if not exist "%%i" call echo.%%i>>files\reports\corruptedFilesList.db
  for /f "delims=" %%i in (files\fileList.db) do if not exist "%%i" goto :corrupted
  if not exist "files\fileList.db" (
    echo.files\fileList.db>>files\reports\corruptedFilesList.db
    echo.and maybe others...>>files\reports\corruptedFilesList.db
    goto :corrupted
  )
)
%loadingUpdate% 3



for /f "tokens=1,2,* delims=;" %%i in (files\userShellFolders.db) do (
  set location_%%i=%%k
  for /f "skip=1 tokens=1,2,3,*" %%l in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v %%j') do (
    if exist "%%n %%o" (
      set location_%%i=%%n %%o
    ) else set location_%%i=%%o
  )
)
if exist %settings% for /f "eol=# delims=" %%i in (%settings%) do set setting_%%i
%loadingUpdate% 3



call :settingsApply
%loadingUpdate% 2



if exist %log% call :logLineAppend %log% 3
echo.Log ^| %versionName% ^| %logDate%>>%log%
echo.>>%log%
call :logLineAppend %log% 1
%loadingUpdate% 3



if exist %log_debug% call :logLineAppend %log_debug% 3
echo.Debug Log ^| %versionName% ^| %logDate%>>%log_debug%
echo.>>%log_debug%
echo.Operating System: %OS%>>%log_debug%
echo.Current Directory: %cd%>>%log_debug%
echo.Current File Directory: %~dp0>>%log_debug%
echo.User Profile Directory: %userProfile%>>%log_debug%
echo.Processor Architecture: %PROCESSOR_ARCHITECTURE%>>%log_debug%
echo.>>%log_debug%
call :logLineAppend %log_debug% 1
echo.Running tasks:>>%log_debug%
echo.>>%log_debug%
tasklist>>%log_debug%
echo.>>%log_debug%
call :logLineAppend %log_debug% 1

rem echo.User Shell Folders:>>%log_debug%
rem for /f "tokens=1,* delims=;" %%i in (files\userShellFolders.db) do echo.%%i Location: %location_%%i%>>%log_debug%
%loadingUpdate% 6



%logo%
%loadingUpdate% 3



if "%setting_lang%" NEQ "english" if "%setting_lang%" NEQ "russian" if "%setting_lang%" NEQ "ukrainian" call :languageMenu force
call :languageImport
%loadingUpdate% 1





%logo%
echo.  ^(^i^) %versionName%
echo.%lang_selectedLanguage%
echo.%lang_initializationRun%
%loadingUpdate% 1



if not exist files\reports\systemInfo.rpt systeminfo>files\reports\systemInfo.rpt >nul 2>nul
%loadingUpdate% 2



if "%setting_firstRun%" == "true" (
  echo.%lang_creatingRegistryBackup%
  rem reg export HKCR files\backups\registry\HKCR.reg /y>>%log_debug%
  %loadingUpdate% 3
  rem reg export HKLM files\backups\registry\HKLM.reg /y>>%log_debug%
  %loadingUpdate% 5
  rem reg export HKU  files\backups\registry\HKU.reg  /y>>%log_debug%
  %loadingUpdate% 6
  reg export HKCC files\backups\registry\HKCC.reg /y>>%log_debug%
  %loadingUpdate% 1
  echo.%lang_registryBackupCreated%
) else %loadingUpdate% 15



echo.%%lastLoggedOnUserSID%%>temp\temp_lastLoggedOnUserSID
for /f "tokens=2*" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnUserSID') do set lastLoggedOnUserSID=%%j
for /f "delims=" %%i in (temp\temp_lastLoggedOnUserSID) do call echo.%%i>files\reports\lastLoggedOnUserSID.rpt
call echo.%lang_lastLoggedOnUserSID%
%loadingUpdate% 2



if exist "%appData%\Mozilla\Firefox\Profiles" (
  for /f "delims=" %%i in ('dir "%appData%\Mozilla\Firefox\Profiles" /a:d /b') do set mozillaFirefoxUserProfile=%%i
  call echo.%lang_mozillaFirefoxUserProfile%
)
%loadingUpdate% 1



call echo.%lang_processorArchitecture%
%loadingUpdate% 1



echo.>>%log%
echo.>>%log%
echo.>>%log%
%loadingUpdate% 1
%module_sleep% 1
goto :mainMenu

























:languageMenu
set command=
%logo%
echo.%lang_languageMenu01%
echo.  ^(1^) English
echo.  ^(2^) Русский
echo.  ^(3^) Українська
if "%1" NEQ "force" (
  echo.
  echo.%lang_back%
)
echo.
echo.
echo.
set /p command=%inputBS%   %lang_enterCommand%



if "%command%" == "0" if "%1" NEQ "force" ( set command= & exit /b )
if "%command%" NEQ "1" if "%command%" NEQ "2" if "%command%" NEQ "3" goto :languageMenu

if "%command%" == "1" set setting_lang=english
if "%command%" == "2" set setting_lang=russian
if "%command%" == "3" set setting_lang=ukrainian

call :settingsSave
set command=
exit /b







:mainMenu
set command=
%logo%
%loadingUpdate% reset
echo.%lang_mainMenu01%
echo.%lang_mainMenu02%
echo.%lang_mainMenu03%
echo.%lang_mainMenu04%
echo.%lang_mainMenu05%
echo.%lang_mainMenu06%
echo.%lang_mainMenu07%
echo.%lang_mainMenu08%
echo.%lang_mainMenu09%
echo.
echo.
echo.
if "%setting_firstRun%" == "true" (
  echo.%lang_firstRunMenuNotification01%
  echo.%lang_firstRunMenuNotification02%
  echo.%lang_firstRunMenuNotification03%
  echo.%lang_firstRunMenuNotification04%
  echo.
  echo.
  echo.
  set setting_firstRun=false
  call :settingsSave
)
set /p command=%inputBS%   %lang_enterCommand%



if "%command%" == "1" call :cleaningMenu
rem if "%command%" == "2" call :exceptionsMenu
if "%command%" == "3" call subroutines\databases.cmd
if "%command%" == "4" call :importMenu
rem if "%command%" == "5" call :helpMenu
rem if "%command%" == "6" call :report
rem if "%command%" == "7" call :about
if "%command%" == "8" call :settingsMenu
if "%command%" == "9" call :clearTemp
if "%command%" == "0" call :exit
if "%command%" == "#" call uninstall.cmd

if exist temp\rebootNow call :exit reboot
goto :mainMenu







:cleaningMenu
set command=
%logo%
echo.%lang_cleaningMenu01%
echo.%lang_cleaningMenu02%
echo.
echo.%lang_back%
echo.
echo.
echo.
set /p command=%inputBS%   %lang_enterCommand%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" == "1" (
  call subroutines\cleaning.cmd
  set command=
  exit /b
)
goto :cleaningMenu







:importMenu
set command=
%logo%
echo.%lang_importMenu01%
echo.%lang_importMenu02%
echo.
echo.%lang_back%
echo.
echo.
echo.
if "%error_import%" == "1" (
  color 0c
  set error_import=0
  echo.%lang_importError%
  echo.
  echo.
  echo.
)
set /p command=%inputBS%   %lang_enterCommand%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" == "1" (
  if not exist "%location_desktop%\adVirCDatabases.zip" (
    set error_import=1
    goto :importMenu
  )
  call subroutines\databases.cmd import
  set command=
  exit /b
)
goto :importMenu







:settingsMenu
set command=
%logo%
echo.%lang_settingsMenu01%
echo.%lang_settingsMenu02% %setting_lang%

if "%setting_logging%" == "true" (
  echo.%lang_settingsMenu03% %lang_settingEnabled%
) else echo.%lang_settingsMenu03% %lang_settingDisabled%

if "%setting_debug%" == "true" (
  echo.%lang_settingsMenu04% %lang_settingEnabled%
) else echo.%lang_settingsMenu04% %lang_settingDisabled%

echo.%lang_settingsMenu05%
echo.%lang_settingsMenu06%
echo.%lang_settingsMenu07% %setting_updateChannel%

if "%setting_autoUpdateProgram%" == "true" (
  call echo.%lang_settingsMenu08% %lang_settingEnabled%
) else call echo.%lang_settingsMenu08% %lang_settingDisabled%

if "%setting_autoUpdateDatabases%" == "true" (
  echo.%lang_settingsMenu09% %lang_settingEnabled%
) else echo.%lang_settingsMenu09% %lang_settingDisabled%

if "%setting_remindProgramUpdates%" == "true" (
  call echo.%lang_settingsMenu10% %lang_settingEnabled%
) else call echo.%lang_settingsMenu10% %lang_settingDisabled%

if "%setting_remindDatabasesUpdates%" == "true" (
  echo.%lang_settingsMenu11% %lang_settingEnabled%
) else echo.%lang_settingsMenu11% %lang_settingDisabled%

echo.
echo.%lang_back%
echo.
echo.
echo.
set /p command=%inputBS%   %lang_enterCommand%



if "%command%" == "0" (
  call :settingsApply
  set command=
  exit /b
)
if "%command%" == "1" (
  call :languageMenu
  call :languageImport
)

if "%command%" == "2" if "%setting_logging%" == "true" (
  set setting_logging=false
) else if "%setting_logging%" == "false" (
  set setting_logging=true
) else set setting_logging=true

if "%command%" == "3" if "%setting_debug%" == "true" (
  set setting_debug=false
) else if "%setting_debug%" == "false" (
  set setting_debug=true
) else set setting_debug=false

if "%command%" == "4" call :updateChannelMenu

if "%command%" == "5" if "%setting_autoUpdateProgram%" == "true" (
  set setting_autoUpdateProgram=false
) else if "%setting_autoUpdateProgram%" == "false" (
  set setting_autoUpdateProgram=true
) else set setting_autoUpdateProgram=false

if "%command%" == "6" if "%setting_autoUpdateDatabases%" == "true" (
  set setting_autoUpdateDatabases=false
) else if "%setting_autoUpdateDatabases%" == "false" (
  set setting_autoUpdateDatabases=true
) else set setting_autoUpdateDatabases=true

if "%command%" == "7" if "%setting_remindProgramUpdates%" == "true" (
  set setting_remindProgramUpdates=false
) else if "%setting_remindProgramUpdates%" == "false" (
  set setting_remindProgramUpdates=true
) else set setting_remindProgramUpdates=true

if "%command%" == "8" if "%setting_remindDatabasesUpdates%" == "true" (
  set setting_remindDatabasesUpdates=false
) else if "%setting_remindDatabasesUpdates%" == "false" (
  set setting_remindDatabasesUpdates=true
) else set setting_remindDatabasesUpdates=true

call :settingsSave
goto :settingsMenu







:updateChannelMenu
set command=
%logo%
call echo.%lang_updateChannelMenu01%
echo.%lang_updateChannelMenu02%
echo.%lang_updateChannelMenu03%
echo.%lang_updateChannelMenu04%
echo.
echo.%lang_back%
echo.
echo.
echo.
set /p command=%inputBS%   %lang_enterCommand%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" NEQ "1" if "%command%" NEQ "2" if "%command%" NEQ "3" goto :updateChannelMenu

if "%command%" == "1" set setting_updateChannel=release
if "%command%" == "2" set setting_updateChannel=beta
if "%command%" == "3" set setting_updateChannel=nightly
set command=
exit /b







:clearTemp
for %%i in (files\databases files\logs files\reports) do (
  if exist %%i rd /s /q %%i
  md %%i>nul 2>nul
)
for /f "delims=" %%i in ('dir /b temp') do if "%%i" NEQ "counter_loading" del /q "temp\%%i"
exit /b







:logLineAppend
for /l %%z in (%2,-1,1) do echo.======================================================================================================================>>%1
exit /b







:languageImport
for /f "eol=# tokens=1,* delims==" %%i in (languages\%setting_lang%.lang) do set lang_%%i=%%j
echo.Language: %setting_lang%>>%log%
exit /b







:settingsSave
echo.# %appName% Settings #>%settings%
echo.autoUpdateDatabases=%setting_autoUpdateDatabases%>>%settings%
echo.autoUpdateProgram=%setting_autoUpdateProgram%>>%settings%
echo.debug=%setting_debug%>>%settings%
echo.firstRun=%setting_firstRun%>>%settings%
echo.lang=%setting_lang%>>%settings%
echo.logging=%setting_logging%>>%settings%
echo.remindDatabasesUpdates=%setting_remindDatabasesUpdates%>>%settings%
echo.remindProgramUpdates=%setting_remindProgramUpdates%>>%settings%
echo.updateChannel=%setting_updateChannel%>>%settings%
exit /b







:settingsApply
if "%setting_logging%" == "true" (
  md files\logs>nul 2>nul
  set log="files\logs\%appName%_log_%currentDate%.log"
  if "%setting_debug%" == "true" set log_debug="files\logs\%appName%_log_debug_%currentDate%.log"
) else (
  set log=nul
  set log_debug=nul
)
exit /b







:corrupted
%logo%
%loadingUpdate% reset
color 0c
echo.  ^(^!^) %appName% Diagnostics: Program Corrupted^!
echo.  ^(^!^) Reinstall %appName%^!
echo.
echo.  ^(^i^) Files missing:
for /f "delims=" %%i in (files\reports\corruptedFilesList.db) do echo.      - %%i
echo.
echo.  ^(^?^) Do you want to run %appName% without these files^?
echo.      ^(^0^) Exit
echo.      ^(^1^) Run
echo.
echo.
echo.
set /p command=%inputBS%   ^(^>^) Enter the number of command ^> 



if "%command%" == "0" call :exit
if "%command%" == "1" (
  start starter.cmd --key_wait=5 --key_skipFilesChecking=true
  call :exit
)
goto :corrupted







:exit
%loadingUpdate% stop

rem call :settingsSave
reg import files\backups\registry\HKUConsoleCMD_Backup.reg 2>nul

timeout /nobreak /t 1 >nul

if "%1" == "reboot" ( shutdown /r /t 0 ) else if exist temp rd /s /q temp
exit