%logo%
%loadingUpdate% 3



set setting_debug=true
set setting_firstRun=true
set setting_language=language
set setting_logging=true
set setting_reports_autoSend=true
set setting_reports_collect=true
set setting_update_channel=nightly
set setting_update_databases_auto=true
set setting_update_databases_remind=true
set setting_update_program_auto=true
set setting_update_program_remind=true

set settings=files\settings\settings.ini

set module_moveFile=subroutines\modules\movefile.exe /accepteula
set module_shortcut=subroutines\modules\shortcut.exe /a:c
set module_unZip=subroutines\modules\unzip.exe -qq
set module_wget=subroutines\modules\wget.exe --quiet --no-check-certificate --tries=1

set stringBuilder_build=set stringBuilder_string=%%stringBuilder_string%%

set cleaning_filesToRemove=temp\filesToRemove.db
set cleaning_rebootScript=temp\rebootScript.cmd

set cleaning_extensions=temp\cleaning\extensions.db
set cleaning_files=temp\cleaning\files.db
set cleaning_folders=temp\cleaning\folders.db
set cleaning_processes=temp\cleaning\processes.db
set cleaning_registry=temp\cleaning\registry.db
set cleaning_services=temp\cleaning\services.db
set cleaning_shortcuts=temp\cleaning\shortcuts.db
set cleaning_tasks=temp\cleaning\tasks.db
set cleaning_temp=temp\cleaning\temp.db





for /f %%a in ('"prompt $h & echo on & for %%b in (1) do rem"') do set inputBS=%%a

set currentDate=%date%
for /f "tokens=2 delims= " %%i in ("%currentDate%") do set currentDate=%%i
for /f "tokens=1-3 delims=/." %%i in ("%currentDate%") do set currentDate=%%k.%%j.%%i
%loadingUpdate% 2



if "%key_skipFilesChecking%" NEQ "true" (
  for /f "delims=" %%i in (files\fileList.db) do if not exist "%%i" call echo.%%i>>temp\corruptedFilesList.db
  for /f "delims=" %%i in (files\fileList.db) do if not exist "%%i" goto :diagnostic
  if not exist "files\fileList.db" (
    echo.files\fileList.db>>temp\corruptedFilesList.db
    echo.and maybe others...>>temp\corruptedFilesList.db
    goto :diagnostic
  )
)
%loadingUpdate% 3



for /f "eol=# tokens=1,* delims==" %%i in (languages\english.lang) do set language_%%i=%%j
if exist "%settings%" for /f "eol=# delims=" %%i in (%settings%) do set setting_%%i
for /f "eol=# tokens=1,2,* delims=;" %%i in (files\userShellFolders.db) do (
  set location_%%i=%%k
  for /f "skip=2 tokens=2,* delims= " %%l in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v %%j') do set location_%%i=%%m
)
%loadingUpdate% 4



call :settings_apply
%loadingUpdate% 2



if "%setting_logging%" == "true" (
  if exist "%log%" call :log_append_line %log% 3
  echo.Log ^| %versionName% ^| %currentDate%>>%log%
  echo.>>%log%
  echo.Operating System: %OS%>>%log%
  echo.Current Directory: %cd%>>%log%
  %loadingUpdate% 3

  if "%setting_debug%" == "true" (
    if exist "%log_debug%" call :log_append_line %log_debug% 3
    echo.Debug Log ^| %versionName% ^| %versionCode% ^| %currentDate%>>%log_debug%
    echo.>>%log_debug%
    echo.Current File Directory: %~dp0>>%log_debug%
    echo.User Profile Directory: %userProfile%>>%log_debug%
    echo.Processor Architecture: %processor_architecture%>>%log_debug%
    call :log_append_line %log_debug% 1
    %loadingUpdate% 3

    echo.User Shell Folders:>>%log_debug%
    echo.- 3D Objects location:  %location_threeDObjects%>>%log_debug%
    echo.- Contacts location:    %location_contacts%>>%log_debug%
    echo.- Desktop location:     %location_desktop%>>%log_debug%
    echo.- Documents location:   %location_documents%>>%log_debug%
    echo.- Downloads location:   %location_downloads%>>%log_debug%
    echo.- Favorites location:   %location_favorites%>>%log_debug%
    echo.- Links location:       %location_links%>>%log_debug%
    echo.- Music location:       %location_music%>>%log_debug%
    echo.- Pictures location:    %location_pictures%>>%log_debug%
    echo.- Saved Games location: %location_savedGames%>>%log_debug%
    echo.- Searches location:    %location_searches%>>%log_debug%
    echo.- Videos location:      %location_videos%>>%log_debug%
    call :log_append_line %log_debug% 1
    %loadingUpdate% 3
  ) else %loadingUpdate% 6
) else %loadingUpdate% 9



echo.%language_initialization%
%loadingUpdate% 2



if "%setting_language%" NEQ "english" if "%setting_language%" NEQ "russian" if "%setting_language%" NEQ "ukrainian" call :menu_language force
call :language_import

if "%setting_logging%" == "true" (
  echo.Language: %setting_language%>>%log%
  call :log_append_line %log% 1
)
%loadingUpdate% 3





%logo%
echo.%language_initialization2%

set stringBuilder_string=  ^(i^) %versionName%
if "%setting_debug%" == "true" call %stringBuilder_build% ^(Version Code: %versionCode%^)
echo.%stringBuilder_string%

echo.%language_info_language%
%loadingUpdate% 2



if "%setting_firstRun%" == "true" (
  echo.%language_info_registryBackup_creating%
  if not exist files\backups\registry md files\backups\registry>nul 2>nul
  rem reg export HKCR files\backups\registry\HKCR.reg /y>>%log_debug%
  %loadingUpdate% 3
  rem reg export HKLM files\backups\registry\HKLM.reg /y>>%log_debug%
  %loadingUpdate% 5
  rem reg export HKU  files\backups\registry\HKU.reg  /y>>%log_debug%
  %loadingUpdate% 6
  rem reg export HKCC files\backups\registry\HKCC.reg /y>>%log_debug%
  %loadingUpdate% 1
  echo.%language_info_registryBackup_created%
) else %loadingUpdate% 15



echo.%%lastLoggedOnUserSID%%>temp\temp_lastLoggedOnUserSID
for /f "tokens=2*" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnUserSID') do set lastLoggedOnUserSID=%%j
if "%setting_reports_collect%" == "true" for /f "delims=" %%i in (temp\temp_lastLoggedOnUserSID) do call echo.%%i>files\reports\lastLoggedOnUserSID.rpt
call echo.%language_info_lastLoggedOnUserSID%
%loadingUpdate% 2



if exist "%appData%\Mozilla\Firefox\Profiles" (
  for /f "delims=" %%i in ('dir "%appData%\Mozilla\Firefox\Profiles" /a:d /b') do set mozillaFirefoxUserProfile=%%i
  if "%setting_reports_collect%" == "true" echo.%mozillaFirefoxUserProfile%>files\reports\mozillaFirefoxUserProfile.rpt
  call echo.%language_info_mozillaFirefoxUserProfile%
)
%loadingUpdate% 2



call echo.%language_info_processorArchitecture%
%loadingUpdate% 1
%module_sleep% 1
goto :menu_main

























:menu_language
if "%1" NEQ "force" for %%i in (%log% %log_debug%) do echo.[Language Menu]>>%%i
set command=
%logo%
echo.%language_menu_language01%
echo.  ^(1^) English
echo.  ^(2^) Русский
echo.  ^(3^) Українська
if "%1" NEQ "force" (
  echo.
  echo.%language_back%
)
echo.
echo.
echo.
set /p command=%inputBS%   %language_input%



if "%command%" == "0" if "%1" NEQ "force" ( set command= & exit /b )
if "%command%" NEQ "1" if "%command%" NEQ "2" if "%command%" NEQ "3" goto :menu_language

if "%command%" == "1" set setting_language=english
if "%command%" == "2" set setting_language=russian
if "%command%" == "3" set setting_language=ukrainian

set command=
exit /b







:menu_main
for %%i in (%log% %log_debug%) do echo.[Main Menu]>>%%i
%loadingUpdate% reset
call :settings_save
set command=
%logo%
echo.%language_menu_main01%
echo.%language_menu_main02%
echo.%language_menu_main03%
echo.%language_menu_main04%
echo.%language_menu_main05%
echo.%language_menu_main06%
echo.%language_menu_main07%
echo.%language_menu_main08%
echo.%language_menu_main09%
echo.
echo.
echo.
if "%setting_firstRun%" == "true" (
  echo.%language_menu_main_firstRunTip%
  echo.%language_menu_main_tipOfTheDay01%
  echo.%language_menu_main_tipOfTheDay02%
  echo.%language_menu_main_tipOfTheDay03%
  echo.
  echo.
  echo.
  set setting_firstRun=false
)
set /p command=%inputBS%   %language_input%



if "%command%" == "1" call :menu_cleaning
rem if "%command%" == "2" call :menu_exceptions
if "%command%" == "3" call subroutines\databases.cmd
if "%command%" == "4" call :menu_databases_import
rem if "%command%" == "5" call :menu_help
rem if "%command%" == "6" call :menu_report
rem if "%command%" == "7" call :menu_about
if "%command%" == "8" call :menu_settings
if "%command%" == "9" call :clearTemp
if "%command%" == "0" call :exit
if "%command%" == "#" call uninstall.cmd

if exist temp\rebootNow call :exit reboot
goto :menu_main







:menu_cleaning
for %%i in (%log% %log_debug%) do echo.[Cleaning Menu]>>%%i
set command=
%logo%
echo.%language_menu_cleaning01%
echo.%language_menu_cleaning02%
echo.
echo.%language_back%
echo.
echo.
echo.
set /p command=%inputBS%   %language_input%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" == "1" (
  call subroutines\cleaning.cmd
  set command=
  exit /b
)
goto :menu_cleaning







:menu_databases_import
for %%i in (%log% %log_debug%) do echo.[Databases Import Menu]>>%%i
set command=
%logo%
echo.%language_menu_databases_import01%
echo.%language_menu_databases_import02%
echo.
echo.%language_back%
echo.
echo.
echo.
if "%databases_import_error%" == "1" (
  color 0c
  set databases_import_error=0
  echo.%language_databases_import_error%
  echo.
  echo.
  echo.
)
set /p command=%inputBS%   %language_input%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" == "1" (
  if not exist "%location_desktop%\adVirCDatabases.zip" (
    set databases_import_error=1
    goto :menu_databases_import
  )
  call subroutines\databases.cmd import
  set command=
  exit /b
)
goto :menu_databases_import







:menu_report
for %%i in (%log% %log_debug%) do echo.[Report Menu]>>%%i
set command=
%logo%
echo.%language_menu_report01%
echo.%language_menu_report02%
echo.
echo.%language_back%
echo.
echo.
echo.
set /p command=%inputBS%   %language_input%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" == "1" (
  systeminfo>files\reports\systemInfo.rpt >nul 2>nul
  set command=
  exit /b
)
goto :menu_report







:menu_settings
for %%i in (%log% %log_debug%) do echo.[Settings Menu]>>%%i
set command=
%logo%
echo.%language_menu_settings01%

set stringBuilder_string=%language_menu_settings03%
if "%setting_language%" == "english" (
  call %stringBuilder_build% %language_menu_setting_language_english%
) else if "%setting_language%" == "russian" (
  call %stringBuilder_build% %language_menu_setting_language_russian%
) else call %stringBuilder_build% %language_menu_setting_language_ukrainian%
call %stringBuilder_build% %language_menu_settings04%
if "%setting_update_channel%" == "release" (
  call %stringBuilder_build% %language_menu_setting_update_channel_release%
) else if "%setting_update_channel%" == "beta" (
  call %stringBuilder_build% %language_menu_setting_update_channel_beta%
) else call %stringBuilder_build% %language_menu_setting_update_channel_nightly%
echo.%stringBuilder_string%

set stringBuilder_string=%language_menu_settings05%
if "%setting_logging%" == "true" (
  call %stringBuilder_build% %language_menu_setting_enabled%
) else call %stringBuilder_build% %language_menu_setting_disabled%
call %stringBuilder_build% %language_menu_settings06%
if "%setting_update_program_auto%" == "true" (
  call %stringBuilder_build% %language_menu_setting_enabled%
) else call %stringBuilder_build% %language_menu_setting_disabled%
echo.%stringBuilder_string%

set stringBuilder_string=%language_menu_settings07%
if "%setting_debug%" == "true" (
  call %stringBuilder_build% %language_menu_setting_enabled%
) else call %stringBuilder_build% %language_menu_setting_disabled%
call %stringBuilder_build% %language_menu_settings08%
if "%setting_update_databases_auto%" == "true" (
  call %stringBuilder_build% %language_menu_setting_enabled%
) else call %stringBuilder_build% %language_menu_setting_disabled%
echo.%stringBuilder_string%

if "%setting_update_program_remind%" == "true" (
  call echo.%language_menu_settings10% %language_menu_setting_enabled%
) else call echo.%language_menu_settings10% %language_menu_setting_disabled%

if "%setting_update_databases_remind%" == "true" (
  call echo.%language_menu_settings12% %language_menu_setting_enabled%
) else call echo.%language_menu_settings12% %language_menu_setting_disabled%

if "%setting_reports_collect%" == "true" (
  call echo.%language_menu_settings13% %language_menu_setting_enabled%
) else call echo.%language_menu_settings13% %language_menu_setting_disabled%

if "%setting_reports_autoSend%" == "true" (
  call echo.%language_menu_settings15% %language_menu_setting_enabled%
) else call echo.%language_menu_settings15% %language_menu_setting_disabled%

echo.
echo.%language_back%
echo.
echo.
echo.
set /p command=%inputBS%   %language_input%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" == "1" (
  call :menu_language
  call :language_import
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
) else set setting_debug=true

if "%command%" == "4" call :menu_update_channel

if "%command%" == "5" if "%setting_update_program_auto%" == "true" (
  set setting_update_program_auto=false
) else if "%setting_update_program_auto%" == "false" (
  set setting_update_program_auto=true
) else set setting_update_program_auto=true

if "%command%" == "6" if "%setting_update_databases_auto%" == "true" (
  set setting_update_databases_auto=false
) else if "%setting_update_databases_auto%" == "false" (
  set setting_update_databases_auto=true
) else set setting_update_databases_auto=true

if "%command%" == "7" if "%setting_update_program_remind%" == "true" (
  set setting_update_program_remind=false
) else if "%setting_update_program_remind%" == "false" (
  set setting_update_program_remind=true
) else set setting_update_program_remind=true

if "%command%" == "8" if "%setting_update_databases_remind%" == "true" (
  set setting_update_databases_remind=false
) else if "%setting_update_databases_remind%" == "false" (
  set setting_update_databases_remind=true
) else set setting_update_databases_remind=true

if "%command%" == "9" if "%setting_reports_collect%" == "true" (
  set setting_reports_collect=false
) else if "%setting_reports_collect%" == "false" (
  set setting_reports_collect=true
) else set setting_reports_collect=true

if "%command%" == "#" if "%setting_reports_autoSend%" == "true" (
  set setting_reports_autoSend=false
) else if "%setting_reports_autoSend%" == "false" (
  set setting_reports_autoSend=true
) else set setting_reports_autoSend=true

call :settings_apply
call :settings_save
goto :menu_settings







:menu_update_channel
for %%i in (%log% %log_debug%) do echo.[Update Channel Menu]>>%%i
set command=
%logo%
call echo.%language_menu_update_channel01%
echo.%language_menu_update_channel02%
echo.%language_menu_update_channel03%
echo.%language_menu_update_channel04%
echo.
echo.%language_back%
echo.
echo.
echo.
set /p command=%inputBS%   %language_input%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" NEQ "1" if "%command%" NEQ "2" if "%command%" NEQ "3" goto :menu_update_channel

if "%command%" == "1" set setting_update_channel=release
if "%command%" == "2" set setting_update_channel=beta
if "%command%" == "3" set setting_update_channel=nightly
set command=
exit /b







:clearTemp
for %%i in (files\databases files\logs files\reports) do (
  if exist "%%i" rd /s /q "%%i"
)
for /f "delims=" %%i in ('dir /b temp') do if "%%i" NEQ "counter_loading" del /q "temp\%%i"

call :settings_apply
exit /b







:language_import
for /f "eol=# tokens=1,* delims==" %%i in (languages\%setting_language%.lang) do set language_%%i=%%j
exit /b







:log_append_line
for /l %%z in (%2,-1,1) do echo.======================================================================================================================>>%1
exit /b







:settings_save
if not exist files\settings md files\settings>nul 2>nul

echo.# %appName% Settings #>%settings%
echo.debug=%setting_debug%>>%settings%
echo.firstRun=%setting_firstRun%>>%settings%
echo.language=%setting_language%>>%settings%
echo.logging=%setting_logging%>>%settings%
echo.reports_autoSend=%setting_reports_autoSend%>>%settings%
echo.reports_collect=%setting_reports_collect%>>%settings%
echo.update_channel=%setting_update_channel%>>%settings%
echo.update_databases_auto=%setting_update_databases_auto%>>%settings%
echo.update_databases_remind=%setting_update_databases_remind%>>%settings%
echo.update_program_auto=%setting_update_program_auto%>>%settings%
echo.update_program_remind=%setting_update_program_remind%>>%settings%
exit /b







:settings_apply
if "%setting_logging%" == "true" (
  if not exist files\logs md files\logs>nul 2>nul
  set log=files\logs\%appName%_%currentDate%_log.log
  if "%setting_debug%" == "true" (
    set log_debug=files\logs\%appName%_%currentDate%_log_debug.log
  ) else set log_debug=nul
) else (
  set log=nul
  set log_debug=nul
)

if "%setting_reports_collect%" == "true" if not exist files\reports md files\reports>nul 2>nul
exit /b







:diagnostic
set log_diagnostic=files\logs\%appName%_%currentDate%_log_diagnostic.log
if not exist files\logs md files\logs>nul 2>nul

echo.[Diagnostic]>>%log_diagnostic%
echo.Missing Files:>>%log_diagnostic%
for /f "delims=" %%i in (temp\corruptedFilesList.db) do echo.- %%i>>%log_diagnostic%

%logo%
%loadingUpdate% reset
color 0c
echo.  ^(^!^) %appName% Diagnostic: Program Corrupted^!
echo.  ^(^!^) Reinstall %appName%^!
echo.
echo.  ^(i^) Files missing:
for /f "delims=" %%i in (temp\corruptedFilesList.db) do echo.      - %%i
echo.
echo.  ^(^?^) Do you want to run %appName% without these files^?
echo.      ^(0^) Exit
echo.      ^(1^) Run
echo.
echo.
echo.
set /p command=%inputBS%   ^(^>^) Enter the number of command ^> 



if "%command%" == "0" call :exit
if "%command%" == "1" (
  echo.Starting without some files>>%log_diagnostic%
  start starter.cmd --key_wait=5 --key_skipFilesChecking=true
  call :exit
)
goto :diagnostic







:exit
%loadingUpdate% stop

reg import files\backups\consoleSettingsBackup.reg 2>nul

%module_sleep% -m 300

if "%1" == "reboot" ( shutdown /r /t 0 ) else if exist temp rd /s /q temp
exit