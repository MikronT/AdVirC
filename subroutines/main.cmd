@%logo%
%loadingUpdate% 3



set input=%method% :input
set log_append_delimiter=%method% :log_append_delimiter
set log_append_line=%method% :log_append_line
set log_append_place=%method% :log_append_place
set logo_log=%method% :logo log 1
set viewPager=%method% :viewPager

set input_clear=set command=
set stringBuilder=set stringBuilder_string=%%stringBuilder_string%%
set update=subroutines\update.cmd

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
set setting_tipOfTheDay=true
set setting_update_channel=nightly
set setting_update_databases_auto=true
set setting_update_databases_remind=true
set setting_update_program_auto=true
set setting_update_program_remind=true

set settings=%dataDir%\settings\settings.ini
set settings_exceptions=%dataDir%\settings\exceptions.db

set cleaning_filesToRemove=temp\filesToRemove.db
set cleaning_rebootScript=temp\rebootScript.cmd
set cleaning_rebootScriptTask=temp\rebootScriptTask.xml

set cleaning_extensions=temp\cleaning\extensions.db
set cleaning_files=temp\cleaning\files.db
set cleaning_folders=temp\cleaning\folders.db
set cleaning_processes=temp\cleaning\processes.db
set cleaning_registry=temp\cleaning\registry.db
set cleaning_services=temp\cleaning\services.db
set cleaning_shortcuts=temp\cleaning\shortcuts.db
set cleaning_tasks=temp\cleaning\tasks.db
set cleaning_temp=temp\cleaning\temp.db

set program_version_code_level1=0
set program_version_code_level2=0
set program_version_code_level3=0
set program_version_code_level4=0
set program_version_code_level5=0
set program_version_code_level6=0
set program_version_code_level7=0

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



for /f %%i in ('"prompt $h & echo on & for %%j in (1) do rem"') do set input_backspace=%%i
for /f "skip=2 tokens=3,* delims= " %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ReleaseId') do set windowsVersionID=%%i

set currentDate=%date%
for /f "tokens=2 delims= " %%i in ("%currentDate%") do set currentDate=%%i
for /f "tokens=1-3 delims=/." %%i in ("%currentDate%") do set currentDate=%%k.%%j.%%i

for /f "tokens=1-7 delims=." %%i in ("%program_version_code%") do (
  if "%%i" NEQ "" set program_version_code_level1=%%i
  if "%%j" NEQ "" set program_version_code_level2=%%j
  if "%%k" NEQ "" set program_version_code_level3=%%k
  if "%%l" NEQ "" set program_version_code_level4=%%l
  if "%%m" NEQ "" set program_version_code_level5=%%m
  if "%%n" NEQ "" set program_version_code_level6=%%n
  if "%%o" NEQ "" set program_version_code_level7=%%o
)

if exist "%dataDir%\databases\original\databases.version" (
  for /f "delims="             %%i in (%dataDir%\databases\original\databases.version) do set databases_version_code=%%i
  for /f "tokens=1-8 delims=." %%i in (%dataDir%\databases\original\databases.version) do (
    if "%%i" NEQ "" set databases_version_code_level1=%%i
    if "%%j" NEQ "" set databases_version_code_level2=%%j
    if "%%k" NEQ "" set databases_version_code_level3=%%k
    if "%%l" NEQ "" set databases_version_code_level4=%%l
    if "%%m" NEQ "" set databases_version_code_level5=%%m
    if "%%n" NEQ "" set databases_version_code_level6=%%n
    if "%%o" NEQ "" set databases_version_code_level7=%%o
    if "%%p" NEQ "" set databases_version_code_level8=%%p
  )
)
%loadingUpdate% 4





if "%key_skipFilesChecking%" NEQ "true" (
  for /f "eol=# delims=" %%i in (files\fileList.db) do if not exist "%%i" call echo.%%i>>temp\corruptedFilesList.db
  for /f "eol=# delims=" %%i in (files\fileList.db) do if not exist "%%i" goto :diagnostic
  if not exist files\fileList.db (
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
  if exist %log% %log_append_delimiter% %log%

  echo.Log ^| %program_version_name% ^| %currentDate%>>%log%
  echo.>>%log%
  echo.Operating System:   %os%>>%log%
  echo.Windows Version ID: %windowsVersionID%>>%log%
  echo.Current Directory:  %cd%>>%log%
  %loadingUpdate% 3

  if "%setting_debug%" == "true" (
    if exist %log_debug% %log_append_delimiter% %log_debug%

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



echo.%language_initialization01%
%loadingUpdate% 1



if "%setting_update_databases_auto%" == "true" (
  start /b %update% --key_check=databases
) else if "%setting_update_databases_remind%" == "true" start /b %update% --key_check=databases

if "%setting_update_program_auto%" == "true" (
  start /b %update% --key_check=program
) else if "%setting_update_program_remind%" == "true" start /b %update% --key_check=program
%loadingUpdate% 2



if "%setting_language%" NEQ "english" if "%setting_language%" NEQ "russian" if "%setting_language%" NEQ "ukrainian" call :menu_language force
call :language_import

if "%setting_logging%" == "true" (
  echo.Language:           %setting_language%>>%log%
  %log_append_line% %log% 1
)
%loadingUpdate% 2





%logo%
echo.%language_initialization02%
echo.
echo.  ^(i^) %program_version_name%

if "%setting_debug%" == "true" (
  call echo.%language_info_versionCode_program%
  if exist %dataDir%\databases\original\databases.version call echo.%language_info_versionCode_databases%
)

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
  reg export HKCR %dataDir%\backups\registry\HKCR.reg /y>>%log_debug%
  %loadingUpdate% 3
  reg export HKLM %dataDir%\backups\registry\HKLM.reg /y>>%log_debug%
  %loadingUpdate% 6
  reg export HKU  %dataDir%\backups\registry\HKU.reg  /y>>%log_debug%
  %loadingUpdate% 5
  reg export HKCC %dataDir%\backups\registry\HKCC.reg /y>>%log_debug%
  %loadingUpdate% 1
  echo.%language_info_registryBackup_created%
  echo.
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



if "%setting_update_databases_auto%" == "true" start /wait /b %update% --key_update=databases
if "%setting_update_program_auto%" == "true"   start /wait /b %update% --key_update=program
goto :menu_main

























:menu_main
%log_append_place% : [Main Menu]

%loadingUpdate% reset
call :settings_save

if exist temp\return_reboot call :exit reboot
if exist temp\return_update call :exit update

%input_clear%
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
echo.%language_menu_main10%
echo.%language_menu_main11%
echo.%language_menu_main12%
echo.
echo.
echo.
call :menu_main_tips
%input%



if "%command%" == "1" call :menu_cleaning
if "%command%" == "2" call :menu_exceptions
if "%command%" == "3" call :databases_update
if "%command%" == "4" call :menu_databases_import
if "%command%" == "5" call :menu_help
if "%command%" == "6" call :menu_report
if "%command%" == "7" call :menu_about
if "%command%" == "8" call :menu_settings
if "%command%" == "9" call :menu_dataManagement
if /i "%command%" == "A" (
  start /wait /b %update% --key_check=program
  start /wait /b %update% --key_update=program
)
if "%command%" == "#" call uninstall.cmd
if "%command%" == "0" call :exit
goto :menu_main







:menu_main_tips
if "%setting_update_databases_remind%" == "true" if exist temp\return_update_databases_available echo.%language_menu_main_update_databases_available%
if "%setting_update_program_remind%" == "true" if exist temp\return_update_program_available call echo.%language_menu_main_update_program_available%

if exist temp\return_update_databases_available (
  if "%setting_firstRun%" == "true" (
    echo.
  ) else if "%setting_tipOfTheDay%" == "true" (
    echo.
  ) else for /l %%i in (3,-1,1) do echo.
) else if exist temp\return_update_program_available (
  if "%setting_firstRun%" == "true" (
    echo.
  ) else if "%setting_tipOfTheDay%" == "true" (
    echo.
  ) else for /l %%i in (3,-1,1) do echo.
)



if "%setting_firstRun%" == "true" echo.%language_menu_main_firstRunTip%
if "%setting_tipOfTheDay%" == "true" (
  setlocal EnableDelayedExpansion
  set /a random_tipNumber=%random%*4/32768+1

  if !random_tipNumber! LSS 10 (
    set temp_tipOfTheDay=language_menu_main_tipOfTheDay0!random_tipNumber!
  ) else set temp_tipOfTheDay=language_menu_main_tipOfTheDay!random_tipNumber!
  call echo.%%!temp_tipOfTheDay!%%
  endlocal
)

if "%setting_firstRun%" == "true" ( for /l %%i in (3,-1,1) do echo. ) else if "%setting_tipOfTheDay%" == "true" for /l %%i in (3,-1,1) do echo.
exit /b







:menu_cleaning
%log_append_place% :   [Cleaning Menu]
%input_clear%
%logo%
echo.%language_menu_cleaning01%
echo.%language_menu_cleaning02%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" (
  call subroutines\cleaning.cmd
  %input_clear%
  exit /b
)
goto :menu_cleaning







:menu_exceptions
%log_append_place% :   [Exceptions Menu]
%input_clear%
%logo%
echo.%language_menu_exceptions01%
echo.%language_menu_exceptions02%
echo.%language_menu_exceptions03%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" call :menu_exceptions_new
if "%command%" == "2" (
  %viewPager% initiate %settings_exceptions%
  call :menu_exceptions_defined
)
goto :menu_exceptions







:menu_exceptions_new
%log_append_place% :     [New Exception Menu]
%input_clear%
%logo%
echo.%language_menu_exceptions_new01%
echo.%language_menu_exceptions_new02%
echo.
echo.%language_back%
echo.
echo.
echo.
if "%databases_notExist_error%" == "1" (
  color 0c
  set databases_notExist_error=0
  echo.%language_databases_notExist_error%
  echo.
  echo.
  echo.
)
%input%



if "%command%" == "0" ( %input_clear% & exit /b )

if exist %dataDir%\databases\rewrited\dirs\temp.db (
  %viewPager% initiate %dataDir%\databases\original\fileList.db %dataDir%\databases\rewrited
  call :menu_exceptions_new_selection
) else set databases_notExist_error=1
goto :menu_exceptions_new







:menu_exceptions_new_selection
%log_append_place% :       [New Exception Selection Menu]
%input_clear%
%logo%
echo.%language_menu_exceptions_new01%
echo.%language_menu_exceptions_new03%
echo.

%viewPager% generate

echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
%viewPager% control add %settings_exceptions%
goto :menu_exceptions_new_selection







:menu_exceptions_defined
%log_append_place% :     [Defined Exceptions Menu]
%input_clear%
%logo%
echo.%language_menu_exceptions_defined01%
echo.%language_menu_exceptions_defined02%
echo.

if exist %settings_exceptions% (
  %viewPager% generate
) else echo.%language_viewPager_nothing%

echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if exist %settings_exceptions% %viewPager% control remove %settings_exceptions%
goto :menu_exceptions_defined







:menu_databases_import
%log_append_place% :   [Databases Import Menu]
%input_clear%
%logo%
echo.%language_menu_databases_import01%
echo.%language_menu_databases_import02%
echo.%language_menu_databases_import03%
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



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" (
  if not exist "%location_desktop%\%program_name%Databases v2.0.zip" (
    set databases_import_error=1
    goto :menu_databases_import
  )
  call :databases_update --key_import=true
  %input_clear%
  exit /b
)
goto :menu_databases_import







:menu_help
%log_append_place% :   [Help Menu]
%input_clear%
%logo%
echo.%language_menu_help01%
echo.%language_menu_help02%
echo.
echo.%language_menu_main01%
echo.%language_menu_main02%
echo.%language_menu_main03%
echo.%language_menu_main04%
echo.%language_menu_main05%
echo.%language_menu_main06%
echo.%language_menu_main07%
echo.
echo.%language_menu_main09%
echo.%language_menu_main10%
echo.%language_menu_main11%
echo.%language_menu_main12%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )

%logo%
echo.%language_menu_help01%
echo.

echo.
echo.
echo.
echo.%language_menu_help03%
pause>nul
goto :menu_help







:menu_report
%log_append_place% :   [Report Menu]
%input_clear%
%logo%
echo.%language_menu_report01%
echo.%language_menu_report02%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" (
  systeminfo>%dataDir%\reports\systemInfo.rpt >nul 2>nul
  %input_clear%
  exit /b
)
goto :menu_report







:menu_about
%log_append_place% :   [About Menu]

if "%setting_debug%" == "true" if exist %dataDir%\databases\original\databases.version for /f "delims=" %%i in (%dataDir%\databases\original\databases.version) do set databases_version_code=%%i

%input_clear%
%logo%
echo.%language_menu_about01%
echo.%language_menu_about02%
echo.%language_menu_about03%
echo.
echo.  ^(i^) %program_version_name%

if "%setting_debug%" == "true" (
  call echo.%language_info_versionCode_program%
  if exist %dataDir%\databases\original\databases.version call echo.%language_info_versionCode_databases%
)

echo.
echo.  ^(i^) MikronT ^(github.com/MikronT^)
echo.
echo.
echo.
echo.%language_menu_about04%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" start notepad "%cd%\license.txt"
goto :menu_about







:menu_settings
%log_append_place% :   [Settings Menu]
%input_clear%
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

set stringBuilder_string=%language_menu_settings11%
if "%setting_tipOfTheDay%" == "true" (
  call %stringBuilder% %language_menu_setting_enabled%
) else call %stringBuilder% %language_menu_setting_disabled%
call %stringBuilder% %language_menu_settings12%
if "%setting_update_databases_remind%" == "true" (
  call %stringBuilder% %language_menu_setting_enabled%
) else call %stringBuilder% %language_menu_setting_disabled%
echo.%stringBuilder_string%

echo.%language_menu_settings13%
echo.%language_menu_settings15%

if "%setting_reports_collect%" == "true" (
  call echo.%language_menu_settings17% %language_menu_setting_enabled%
) else call echo.%language_menu_settings17% %language_menu_setting_disabled%

if "%setting_reports_autoSend%" == "true" (
  call echo.%language_menu_settings19% %language_menu_setting_enabled%
) else call echo.%language_menu_settings19% %language_menu_setting_disabled%

echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
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

if "%command%" == "5" if "%setting_tipOfTheDay%" == "true" (
  set setting_tipOfTheDay=false
) else if "%setting_tipOfTheDay%" == "false" (
  set setting_tipOfTheDay=true
) else set setting_tipOfTheDay=true

if "%command%" == "6" call :menu_update_channel

if "%command%" == "7" if "%setting_update_program_auto%" == "true" (
  set setting_update_program_auto=false
) else if "%setting_update_program_auto%" == "false" (
  set setting_update_program_auto=true
) else set setting_update_program_auto=true

if "%command%" == "8" if "%setting_update_databases_auto%" == "true" (
  set setting_update_databases_auto=false
) else if "%setting_update_databases_auto%" == "false" (
  set setting_update_databases_auto=true
) else set setting_update_databases_auto=true

if "%command%" == "9" if "%setting_update_program_remind%" == "true" (
  set setting_update_program_remind=false
) else if "%setting_update_program_remind%" == "false" (
  set setting_update_program_remind=true
) else set setting_update_program_remind=true

if "%command%" == "#" if "%setting_update_databases_remind%" == "true" (
  set setting_update_databases_remind=false
) else if "%setting_update_databases_remind%" == "false" (
  set setting_update_databases_remind=true
) else set setting_update_databases_remind=true

if /i "%command%" == "A" if "%setting_reports_collect%" == "true" (
  set setting_reports_collect=false
) else if "%setting_reports_collect%" == "false" (
  set setting_reports_collect=true
) else set setting_reports_collect=true

if /i "%command%" == "B" if "%setting_reports_autoSend%" == "true" (
  set setting_reports_autoSend=false
) else if "%setting_reports_autoSend%" == "false" (
  set setting_reports_autoSend=true
) else set setting_reports_autoSend=true

call :settings_apply
call :settings_save
goto :menu_settings







:menu_language
if "%1" NEQ "force" %log_append_place% :     [Language Menu]
%input_clear%
%logo%
if "%1" NEQ "force" (
  echo.%language_menu_language01%
) else echo.  Language
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



if "%command%" == "0" if "%1" NEQ "force" ( %input_clear% & exit /b )
if "%command%" NEQ "1" if "%command%" NEQ "2" if "%command%" NEQ "3" goto :menu_language

if "%command%" == "1" set setting_language=english
if "%command%" == "2" set setting_language=russian
if "%command%" == "3" set setting_language=ukrainian

%input_clear%
exit /b







:menu_update_channel
%log_append_place% :     [Update Channel Menu]
%input_clear%
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



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" NEQ "1" if "%command%" NEQ "2" if "%command%" NEQ "3" goto :menu_update_channel

if "%command%" == "1" set setting_update_channel=release
if "%command%" == "2" set setting_update_channel=beta
if "%command%" == "3" set setting_update_channel=nightly

%input_clear%
exit /b







:menu_theme
%log_append_place% :   [Theme Menu]
%input_clear%
%logo%
echo.%language_menu_theme01%
echo.%language_menu_theme02%
echo.%language_menu_theme03%
echo.%language_menu_theme04%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" rem
if "%command%" == "2" rem
if "%command%" == "3" rem
exit /b







:menu_dataManagement
%log_append_place% :   [Data Management Menu]
%input_clear%
%logo%
call echo.%language_menu_dataManagement01%
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



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" for /f "delims=" %%i in ('dir /b temp') do if "%%i" NEQ "counter_loading" (
  rd /s /q temp\%%i>nul 2>nul
  del /q temp\%%i>nul 2>nul
)
if "%command%" == "2" if exist %dataDir%\logs      rd /s /q %dataDir%\logs
if "%command%" == "3" if exist %dataDir%\reports   rd /s /q %dataDir%\reports
if "%command%" == "4" if exist %dataDir%\databases rd /s /q %dataDir%\databases
if "%command%" == "5" if exist %dataDir%\settings  rd /s /q %dataDir%\settings
if "%command%" == "6" if exist %dataDir%\backups   rd /s /q %dataDir%\backups

call :settings_apply
goto :menu_dataManagement







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
echo.tipOfTheDay=%setting_tipOfTheDay%>>%settings%
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







:databases_update
call subroutines\databases.cmd %*
for /f "delims="             %%i in (%dataDir%\databases\original\databases.version) do set databases_version_code=%%i
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
for /f "tokens=1-3 delims= " %%i in (%update_databases_version_output%) do (
  if /i "%%i" == "%setting_update_channel%" (
    for /f "tokens=1-8 delims=." %%l in ("%%j") do (
             if "%%l" NEQ "" if %%l GTR %databases_version_code_level1% ( echo.>temp\return_update_databases_available
      ) else if "%%m" NEQ "" if %%m GTR %databases_version_code_level2% ( echo.>temp\return_update_databases_available
      ) else if "%%n" NEQ "" if %%n GTR %databases_version_code_level3% ( echo.>temp\return_update_databases_available
      ) else if "%%o" NEQ "" if %%o GTR %databases_version_code_level4% ( echo.>temp\return_update_databases_available
      ) else if "%%p" NEQ "" if %%p GTR %databases_version_code_level5% ( echo.>temp\return_update_databases_available
      ) else if "%%q" NEQ "" if %%q GTR %databases_version_code_level6% ( echo.>temp\return_update_databases_available
      ) else if "%%r" NEQ "" if %%r GTR %databases_version_code_level7% ( echo.>temp\return_update_databases_available
      ) else if "%%s" NEQ "" if %%s GTR %databases_version_code_level8% ( echo.>temp\return_update_databases_available
      )
    )
  )
)
exit /b







:language_import
if "%setting_language%" == "default" (
  for /f "eol=# tokens=1,* delims==" %%i in (languages\english.lang) do set language_%%i=%%j
) else for /f "eol=# tokens=1,* delims==" %%i in (languages\%setting_language%.lang) do set language_%%i=%%j
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
set /p command=%input_backspace%   ^(^>^) Enter the number of command ^> 



if "%command%" == "0" call :exit
if "%command%" == "1" (
  echo.Starting without some files>>%log_diagnostic%
  start starter.cmd --key_wait=5 --key_skipFilesChecking=true
  call :exit
)
goto :diagnostic







:exit
if "%setting_firstRun%" == "true" set setting_firstRun=false
call :settings_save

%loadingUpdate% stop

if exist %dataDir%\backups\consoleSettingsBackup.reg reg import %dataDir%\backups\consoleSettingsBackup.reg 2>nul

%module_sleep% -m 300

       if "%1" == "reboot" ( shutdown /r /t 0
) else if "%1" == "update" (
  cd "%temp%\%program_name%-Update"
  start update.cmd --key_target="%cd%"
) else if exist temp rd /s /q temp
exit