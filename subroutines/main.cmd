@%logo%
%loadingUpdate% 3



set input=%method% :input
set log_append_delimiter=%method% :log_append_delimiter
set log_append_line=%method% :log_append_line
set log_append_place=%method% :log_append_place
set logo_log=%method% :logo log 1

set stringBuilder=set stringBuilder_string=%%stringBuilder_string%%
set update=/b subroutines\update.cmd

set module_moveFile=subroutines\modules\movefile.exe /accepteula
set module_shortcut=subroutines\modules\shortcut.exe /a:c
set module_unZip=subroutines\modules\unzip.exe -qq
set module_wget=subroutines\modules\wget.exe --quiet --no-check-certificate --tries=1

set setting_debug=true
set setting_firstRun=true
set setting_language=default
set setting_logging=true
set setting_logging_advanced=true
set setting_reports_autoSend=true
set setting_reports_collect=true
set setting_update_channel=nightly
set setting_update_databases_auto=true
set setting_update_databases_remind=true
set setting_update_program_auto=true
set setting_update_program_remind=true

set settings=%dataDir%\settings\settings.ini

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

set databases_version_code=0
set databases_version_code_level1=0
set databases_version_code_level2=0
set databases_version_code_level3=0
set databases_version_code_level4=0
set databases_version_code_level5=0
set databases_version_code_level6=0
set databases_version_code_level7=0
set databases_version_code_level8=0

set update_program_version_output=temp\%program_name%.version
set update_program_version_url=https://drive.google.com/uc?export=download^^^&id=1ZCUccG0U3VoePdTmwqQmid3d7vlQZWGY

set update_databases_version_output=temp\%program_name%Databases.version
set update_databases_version_url=https://drive.google.com/uc?export=download^^^&id=1ene7znlMRqGpXFQqgBFZfFCghN8FBF1O

set update_program_output=temp\%program_name%.zip
set update_program_url=https://drive.google.com/uc?export=download^^^&id=1ssADcfpKfFf9mjtVuL9lQ7NLoc4comTh

set update_databases_output=temp\%program_name%Databases.zip
set update_databases_url=https://drive.google.com/uc?export=download^^^&id=1u1mKCVHfk3LS8zFJ97gxLQ9f_UsH_zsy



for /f %%i in ('"prompt $h & echo on & for %%j in (1) do rem"') do set inputBS=%%i
for /f "skip=2 tokens=3,* delims= " %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ReleaseId') do set windowsVersionID=%%i

set currentDate=%date%
for /f "tokens=2 delims= " %%i in ("%currentDate%") do set currentDate=%%i
for /f "tokens=1-3 delims=/." %%i in ("%currentDate%") do set currentDate=%%k.%%j.%%i

for /f "tokens=1-7 delims=." %%i in ("%program_version_code%") do (
  set program_version_code_level1=%%i
  set program_version_code_level2=%%j
  set program_version_code_level3=%%k
  set program_version_code_level4=%%l
  set program_version_code_level5=%%m
  set program_version_code_level6=%%n
  set program_version_code_level7=%%o
)

if exist "%dataDir%\databases\original\databases.version" (
  for /f "delims=" %%i in (%dataDir%\databases\original\databases.version) do set databases_version_code=%%i
  for /f "tokens=1-8 delims=." %%i in (%dataDir%\databases\original\databases.version) do (
    set databases_version_code_level1=%%i
    set databases_version_code_level2=%%j
    set databases_version_code_level3=%%k
    set databases_version_code_level4=%%l
    set databases_version_code_level5=%%m
    set databases_version_code_level6=%%n
    set databases_version_code_level7=%%o
    set databases_version_code_level8=%%p
  )
)
%loadingUpdate% 4





if "%key_skipFilesChecking%" NEQ "true" (
  for /f "eol=# delims=" %%i in (files\fileList.db) do if not exist "%%i" call echo.%%i>>temp\corruptedFilesList.db
  for /f "eol=# delims=" %%i in (files\fileList.db) do if not exist "%%i" goto :diagnostic
  if not exist "files\fileList.db" (
    echo.files\fileList.db>>temp\corruptedFilesList.db
    echo.and maybe others...>>temp\corruptedFilesList.db
    goto :diagnostic
  )
)
%loadingUpdate% 3





call :language_import
if exist "%settings%" for /f "eol=# delims=" %%i in (%settings%) do set setting_%%i
for /f "eol=# tokens=1,2,* delims=;" %%i in (files\userShellFolders.db) do (
  set location_%%i=%%k
  for /f "skip=2 tokens=2,* delims= " %%l in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v %%j') do set location_%%i=%%m
)
%loadingUpdate% 3



call :settings_apply
%loadingUpdate% 2



if "%setting_logging%" == "true" (
  if exist "%log%" %log_append_delimiter% %log%

  echo.Log ^| %program_version_name% ^| %currentDate%>>%log%
  echo.>>%log%
  echo.Operating System:   %os%>>%log%
  echo.Windows Version ID: %windowsVersionID%>>%log%
  echo.Current Directory:  %cd%>>%log%
  %loadingUpdate% 3

  if "%setting_debug%" == "true" (
    if exist "%log_debug%" %log_append_delimiter% %log_debug%

    echo.Debug Log ^| %program_version_name% ^| %program_version_code% ^| %currentDate%>>%log_debug%
    echo.>>%log_debug%
    echo.Current File Directory: %~dp0>>%log_debug%
    echo.User Profile Directory: %userProfile%>>%log_debug%
    echo.Processor Architecture: %processor_architecture%>>%log_debug%
    echo.>>%log_debug%
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
    %log_append_line% %log_debug% 1
    %loadingUpdate% 3
  ) else %loadingUpdate% 6
) else %loadingUpdate% 9



echo.%language_initialization%
%loadingUpdate% 1



if "%setting_update_databases_auto%" == "true" (
  start %update% --key_check=databases
) else if "%setting_update_databases_remind%" == "true" start %update% --key_check=databases

if "%setting_update_program_auto%" == "true" (
  start %update% --key_check=program
) else if "%setting_update_program_remind%" == "true" start %update% --key_check=program
%loadingUpdate% 2



if "%setting_language%" NEQ "english" if "%setting_language%" NEQ "russian" if "%setting_language%" NEQ "ukrainian" call :menu_language force
call :language_import

if "%setting_logging%" == "true" (
  echo.Language:           %setting_language%>>%log%
  %log_append_line% %log% 1
)
%loadingUpdate% 2





%logo%
echo.%language_initialization2%
echo.
echo.  ^(i^) %program_version_name%

if "%setting_debug%" == "true" call echo.%language_info_versionCode_program%
if "%setting_debug%" == "true" if exist "%dataDir%\databases\original\databases.version" call echo.%language_info_versionCode_databases%

set stringBuilder_string=%language_info_language%
if "%setting_language%" == "english" (
  call %stringBuilder% %language_menu_setting_language_english%
) else if "%setting_language%" == "russian" (
  call %stringBuilder% %language_menu_setting_language_russian%
) else call %stringBuilder% %language_menu_setting_language_ukrainian%
echo.%stringBuilder_string%
echo.

call echo.%language_info_windowsVersionID%
call echo.%language_info_processorArchitecture%
echo.
%loadingUpdate% 2



if "%setting_firstRun%" == "true" (
  echo.%language_info_registryBackup_creating%
  if not exist %dataDir%\backups\registry md %dataDir%\backups\registry>nul 2>nul
  rem reg export HKCR %dataDir%\backups\registry\HKCR.reg /y>>%log_debug%
  %loadingUpdate% 3
  rem reg export HKLM %dataDir%\backups\registry\HKLM.reg /y>>%log_debug%
  %loadingUpdate% 6
  rem reg export HKU  %dataDir%\backups\registry\HKU.reg  /y>>%log_debug%
  %loadingUpdate% 5
  rem reg export HKCC %dataDir%\backups\registry\HKCC.reg /y>>%log_debug%
  %loadingUpdate% 1
  echo.%language_info_registryBackup_created%
  echo.
  set setting_firstRun=false
) else %loadingUpdate% 15



echo.%%lastLoggedOnUserSID%%>temp\lastLoggedOnUserSID
for /f "tokens=2*" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnUserSID') do set lastLoggedOnUserSID=%%j
if "%setting_reports_collect%" == "true" for /f "delims=" %%i in (temp\lastLoggedOnUserSID) do call echo.%%i>%dataDir%\reports\lastLoggedOnUserSID.rpt
call echo.%language_info_lastLoggedOnUserSID%
%loadingUpdate% 2



if exist "%appData%\Mozilla\Firefox\Profiles" (
  echo.%%mozillaFirefoxUserProfile%%>temp\mozillaFirefoxUserProfile
  for /f "delims=" %%i in ('dir "%appData%\Mozilla\Firefox\Profiles" /a:d /b') do set mozillaFirefoxUserProfile=%%i
  if "%setting_reports_collect%" == "true" for /f "delims=" %%i in (temp\mozillaFirefoxUserProfile) do call echo.%%i>%dataDir%\reports\mozillaFirefoxUserProfile.rpt
  call echo.%language_info_mozillaFirefoxUserProfile%
)
%loadingUpdate% 2



%module_sleep% 1
%loadingUpdate% reset



if "%setting_update_databases_auto%" == "true" start /wait %update% --key_update=databases
if "%setting_update_program_auto%" == "true" start /wait %update% --key_update=program
goto :menu_main

























:menu_main
%log_append_place% : [Main Menu]
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
if "%setting_update_databases_remind%" == "true" if exist temp\return_update_databases_available (
  echo.%language_menu_main_update_databases_available%
  if not exist temp\return_update_program_available (
    echo.
    echo.
    echo.
  )
)
if "%setting_update_program_remind%" == "true" if exist temp\return_update_program_available (
  call echo.%language_menu_main_update_program_available%
  echo.
  echo.
  echo.
)
if "%setting_firstRun%" == "true" echo.%language_menu_main_firstRunTip%
echo.%language_menu_main_tipOfTheDay01%
echo.%language_menu_main_tipOfTheDay02%
echo.%language_menu_main_tipOfTheDay03%
echo.
echo.
echo.
%input%



if "%command%" == "1" call :menu_cleaning
rem if "%command%" == "2" call :menu_exceptions
if "%command%" == "3" call subroutines\databases.cmd
if "%command%" == "4" call :menu_databases_import
rem if "%command%" == "5" call :menu_help
if "%command%" == "6" call :menu_report
rem if "%command%" == "7" call :menu_about
if "%command%" == "8" call :menu_settings
if "%command%" == "9" call :menu_dataManagement
if "%command%" == "0" call :exit
if "%command%" == "#" call uninstall.cmd

if exist temp\return_rebootNow call :exit reboot
goto :menu_main







:menu_cleaning
%log_append_place% :   [Cleaning Menu]
set command=
%logo%
echo.%language_menu_cleaning01%
echo.%language_menu_cleaning02%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" == "1" (
  call subroutines\cleaning.cmd
  set command=
  exit /b
)
goto :menu_cleaning







:menu_exceptions
goto :menu_exceptions







:menu_databases_import
%log_append_place% :   [Databases Import Menu]
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
%input%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" == "1" (
  if not exist "%location_desktop%\%program_name%Databases v2.0.zip" (
    set databases_import_error=1
    goto :menu_databases_import
  )
  call subroutines\databases.cmd --key_import=true
  set command=
  exit /b
)
goto :menu_databases_import







:menu_help
goto :menu_help







:menu_report
%log_append_place% :   [Report Menu]
set command=
%logo%
echo.%language_menu_report01%
echo.%language_menu_report02%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" == "1" (
  systeminfo>%dataDir%\reports\systemInfo.rpt >nul 2>nul
  set command=
  exit /b
)
goto :menu_report







:menu_about
goto :menu_about







:menu_settings
%log_append_place% :   [Settings Menu]
set command=
%logo%
echo.%language_menu_settings01%

set stringBuilder_string=%language_menu_settings03%
if "%setting_language%" == "english" (
  call %stringBuilder% %language_menu_setting_language_english%
) else if "%setting_language%" == "russian" (
  call %stringBuilder% %language_menu_setting_language_russian%
) else call %stringBuilder% %language_menu_setting_language_ukrainian%
call %stringBuilder% %language_menu_settings04%
if "%setting_update_channel%" == "release" (
  call %stringBuilder% %language_menu_setting_update_channel_release%
) else if "%setting_update_channel%" == "beta" (
  call %stringBuilder% %language_menu_setting_update_channel_beta%
) else call %stringBuilder% %language_menu_setting_update_channel_nightly%
echo.%stringBuilder_string%

set stringBuilder_string=%language_menu_settings05%
if "%setting_logging%" == "true" (
  call %stringBuilder% %language_menu_setting_enabled%
) else call %stringBuilder% %language_menu_setting_disabled%
call %stringBuilder% %language_menu_settings06%
if "%setting_update_program_auto%" == "true" (
  call %stringBuilder% %language_menu_setting_enabled%
) else call %stringBuilder% %language_menu_setting_disabled%
echo.%stringBuilder_string%

set stringBuilder_string=%language_menu_settings07%
if "%setting_logging_advanced%" == "true" (
  call %stringBuilder% %language_menu_setting_enabled%
) else call %stringBuilder% %language_menu_setting_disabled%
call %stringBuilder% %language_menu_settings08%
if "%setting_update_databases_auto%" == "true" (
  call %stringBuilder% %language_menu_setting_enabled%
) else call %stringBuilder% %language_menu_setting_disabled%
echo.%stringBuilder_string%

set stringBuilder_string=%language_menu_settings09%
if "%setting_debug%" == "true" (
  call %stringBuilder% %language_menu_setting_enabled%
) else call %stringBuilder% %language_menu_setting_disabled%
call %stringBuilder% %language_menu_settings10%
if "%setting_update_program_remind%" == "true" (
  call %stringBuilder% %language_menu_setting_enabled%
) else call %stringBuilder% %language_menu_setting_disabled%
echo.%stringBuilder_string%

if "%setting_update_databases_remind%" == "true" (
  call echo.%language_menu_settings12% %language_menu_setting_enabled%
) else call echo.%language_menu_settings12% %language_menu_setting_disabled%

echo.%language_menu_settings13%

if "%setting_reports_collect%" == "true" (
  call echo.%language_menu_settings15% %language_menu_setting_enabled%
) else call echo.%language_menu_settings15% %language_menu_setting_disabled%

if "%setting_reports_autoSend%" == "true" (
  call echo.%language_menu_settings17% %language_menu_setting_enabled%
) else call echo.%language_menu_settings17% %language_menu_setting_disabled%

echo.
echo.%language_back%
echo.
echo.
echo.
%input%



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

if "%command%" == "3" if "%setting_logging_advanced%" == "true" (
  set setting_logging_advanced=false
) else if "%setting_logging_advanced%" == "false" (
  set setting_logging_advanced=true
) else set setting_logging_advanced=true

if "%command%" == "4" if "%setting_debug%" == "true" (
  set setting_debug=false
) else if "%setting_debug%" == "false" (
  set setting_debug=true
) else set setting_debug=true

if "%command%" == "5" call :menu_update_channel

if "%command%" == "6" if "%setting_update_program_auto%" == "true" (
  set setting_update_program_auto=false
) else if "%setting_update_program_auto%" == "false" (
  set setting_update_program_auto=true
) else set setting_update_program_auto=true

if "%command%" == "7" if "%setting_update_databases_auto%" == "true" (
  set setting_update_databases_auto=false
) else if "%setting_update_databases_auto%" == "false" (
  set setting_update_databases_auto=true
) else set setting_update_databases_auto=true

if "%command%" == "8" if "%setting_update_program_remind%" == "true" (
  set setting_update_program_remind=false
) else if "%setting_update_program_remind%" == "false" (
  set setting_update_program_remind=true
) else set setting_update_program_remind=true

if "%command%" == "9" if "%setting_update_databases_remind%" == "true" (
  set setting_update_databases_remind=false
) else if "%setting_update_databases_remind%" == "false" (
  set setting_update_databases_remind=true
) else set setting_update_databases_remind=true

if "%command%" == "#" if "%setting_reports_collect%" == "true" (
  set setting_reports_collect=false
) else if "%setting_reports_collect%" == "false" (
  set setting_reports_collect=true
) else set setting_reports_collect=true

if /i "%command%" == "A" if "%setting_reports_autoSend%" == "true" (
  set setting_reports_autoSend=false
) else if "%setting_reports_autoSend%" == "false" (
  set setting_reports_autoSend=true
) else set setting_reports_autoSend=true

call :settings_apply
call :settings_save
goto :menu_settings







:menu_language
if "%1" NEQ "force" %log_append_place% :     [Language Menu]
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
%input%



if "%command%" == "0" if "%1" NEQ "force" ( set command= & exit /b )
if "%command%" NEQ "1" if "%command%" NEQ "2" if "%command%" NEQ "3" goto :menu_language

if "%command%" == "1" set setting_language=english
if "%command%" == "2" set setting_language=russian
if "%command%" == "3" set setting_language=ukrainian

set command=
exit /b







:menu_update_channel
%log_append_place% :     [Update Channel Menu]
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
%input%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" NEQ "1" if "%command%" NEQ "2" if "%command%" NEQ "3" goto :menu_update_channel

if "%command%" == "1" set setting_update_channel=release
if "%command%" == "2" set setting_update_channel=beta
if "%command%" == "3" set setting_update_channel=nightly

set command=
exit /b







:menu_dataManagement
%log_append_place% :   [Data Management Menu]
set command=
%logo%
echo.%language_menu_dataManagement01%
echo.%language_menu_dataManagement02%
echo.%language_menu_dataManagement03%
echo.%language_menu_dataManagement04%
echo.%language_menu_dataManagement05%
echo.%language_menu_dataManagement06%
echo.%language_menu_dataManagement07%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( set command= & exit /b )
if "%command%" == "1" for /f "delims=" %%i in ('dir /b temp') do if "%%i" NEQ "counter_loading" del /q "temp\%%i"
if "%command%" == "2" if exist "%dataDir%\logs"      rd /s /q "%dataDir%\logs"
if "%command%" == "3" if exist "%dataDir%\reports"   rd /s /q "%dataDir%\reports"
if "%command%" == "4" if exist "%dataDir%\databases" rd /s /q "%dataDir%\databases"
if "%command%" == "5" if exist "%dataDir%\settings"  rd /s /q "%dataDir%\settings"
if "%command%" == "6" if exist "%dataDir%\backups"   rd /s /q "%dataDir%\backups"

call :settings_apply
goto :menu_dataManagement







:language_import
if "%setting_language%" == "default" (
  for /f "eol=# tokens=1,* delims==" %%i in (languages\english.lang) do set language_%%i=%%j
) else for /f "eol=# tokens=1,* delims==" %%i in (languages\%setting_language%.lang) do set language_%%i=%%j
exit /b







:settings_save
if not exist %dataDir%\settings md %dataDir%\settings>nul 2>nul

echo.# %program_name% Settings #>%settings%
echo.debug=%setting_debug%>>%settings%
echo.firstRun=%setting_firstRun%>>%settings%
echo.language=%setting_language%>>%settings%
echo.logging=%setting_logging%>>%settings%
echo.logging_advanced=%setting_logging_advanced%>>%settings%
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
  if not exist %dataDir%\logs md %dataDir%\logs>nul 2>nul
  set log=%dataDir%\logs\%program_name%_%currentDate%.log
  if "%setting_debug%" == "true" (
    set log_debug=%dataDir%\logs\%program_name%_%currentDate%_debug.log
  ) else set log_debug=nul
) else (
  set log=nul
  set log_debug=nul
)

if "%setting_reports_collect%" == "true" if not exist %dataDir%\reports md %dataDir%\reports>nul 2>nul
exit /b







:diagnostic
set log_diagnostic=%dataDir%\logs\%program_name%_%currentDate%_diagnostic.log
if not exist %dataDir%\logs md %dataDir%\logs>nul 2>nul

echo.[Diagnostic]>>%log_diagnostic%
echo.Missing Files:>>%log_diagnostic%
for /f "delims=" %%i in (temp\corruptedFilesList.db) do echo.- %%i>>%log_diagnostic%

%logo%
%loadingUpdate% reset
color 0c
echo.  ^(^!^) %program_name% Diagnostic: Program Corrupted^!
echo.  ^(^!^) Reinstall %program_name%^!
echo.
echo.  ^(i^) Files missing:
for /f "delims=" %%i in (temp\corruptedFilesList.db) do echo.      - %%i
echo.
echo.  ^(^?^) Do you want to run %program_name% without these files^?
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

reg import %dataDir%\backups\consoleSettingsBackup.reg 2>nul

%module_sleep% -m 300

if "%1" == "reboot" ( shutdown /r /t 0 ) else if exist temp rd /s /q temp
exit