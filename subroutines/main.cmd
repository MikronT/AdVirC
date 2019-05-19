@%logo%
if "%*" NEQ "" ( call %* & exit /b )
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

set setting_cleaningRule_experimental=false
set setting_cleaningRule_heuristic=true
set setting_debug=false
set setting_firstRun=true
set setting_language=default
set setting_logging=true
set setting_logging_advanced=false
set setting_tipOfTheDay=true
set setting_update_channel=release
set setting_update_databases_auto=true
set setting_update_databases_remind=true
set setting_update_program_auto=false
set setting_update_program_remind=true

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
set update_program_url_release=https://drive.google.com/uc?export=download^^^&id=1ithl15gsBdGRzSC13zEP98s4LeP2Z_PB
set update_program_url_beta=https://drive.google.com/uc?export=download^^^&id=12dw__c80MEL5-47di6XKSyZ3bgsDuUTv
set update_program_url_nightly=https://drive.google.com/uc?export=download^^^&id=1SrUFMV-hHGXm1-0gdgqdmZ6KoHNwoT-n

set update_databases_output=temp\%program_name%Databases.zip
set update_databases_url_release=https://drive.google.com/uc?export=download^^^&id=1yDLbetVLq0OSjEVbgaTcMgsUU2MtWLZp
set update_databases_url_beta=https://drive.google.com/uc?export=download^^^&id=1E8cgGbR14ZcdudNdAVVqzRLo-ijH8zM1
set update_databases_url_nightly=https://drive.google.com/uc?export=download^^^&id=1wOEuF5polVS5eUYLTVzZC280lqYgoxVo



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
  (for /f "skip=2 tokens=2,* delims= " %%l in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v %%j') do set location_%%i=%%m)>nul 2>nul
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
%loadingUpdate% 4



rem if "%setting_firstRun%" == "true" (
rem   echo.%language_info_registryBackup_creating%
rem   if not exist %dataDir%\backups\registry md %dataDir%\backups\registry>nul 2>nul
rem   reg export HKLM %dataDir%\backups\registry\HKLM.reg /y>>%log_debug%
rem   %loadingUpdate% 7
rem   reg export HKU  %dataDir%\backups\registry\HKU.reg  /y>>%log_debug%
rem   %loadingUpdate% 8
rem   echo.%language_info_registryBackup_created%
rem   echo.
rem ) else %loadingUpdate% 15
%loadingUpdate% 15



echo.%%lastLoggedOnUserSID%%>temp\lastLoggedOnUserSID
for /f "tokens=2*" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnUserSID') do set lastLoggedOnUserSID=%%j
call echo.%language_info_lastLoggedOnUserSID%
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
if "%command%" == "6" call :menu_about
if "%command%" == "7" call :menu_settings
if "%command%" == "8" call :menu_dataManagement
if "%command%" == "9" (
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
echo.%language_menu_cleaning03%
echo.%language_menu_cleaning04%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" (
  call subroutines\cleaning.cmd --key_auto=false
  %input_clear% & exit /b
)
if "%command%" == "2" (
  call subroutines\cleaning.cmd --key_auto=true
  %input_clear% & exit /b
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
  %viewPager% initiate %settings_exceptions% %settings_exceptions%
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
  color c
  set databases_notExist_error=0
  echo.%language_databases_notExist_error%
  echo.
  echo.
  echo.
)
%input%



if "%command%" == "0" ( %input_clear% & exit /b )

if exist %dataDir%\databases\rewrited\dirs\temp.db (
  %viewPager% initiate %settings_exceptions% %dataDir%\databases\original\fileList.db %dataDir%\databases\rewrited
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
if "!errorLevel!" == "4417" (
  set /a counter_viewPager_page-=10
  set /a counter_viewPager_page_next-=10
  goto :menu_exceptions_new_selection
)

echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
%viewPager% control add
goto :menu_exceptions_new_selection







:menu_exceptions_defined
%log_append_place% :     [Defined Exceptions Menu]
%input_clear%
%logo%
echo.%language_menu_exceptions_defined01%
echo.%language_menu_exceptions_defined02%
echo.

setlocal EnableDelayedExpansion

if exist %settings_exceptions% (
  %viewPager% generate
  if "!errorLevel!" == "4417" (
    set /a counter_viewPager_page-=10
    set /a counter_viewPager_page_next-=10
    goto :menu_exceptions_defined
  )
) else echo.%language_viewPager_nothing%

endlocal

echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if exist %settings_exceptions% %viewPager% control remove
goto :menu_exceptions_defined







:menu_databases_import
%log_append_place% :   [Databases Import Menu]
%input_clear%
%logo%
echo.%language_menu_databases_import01%
echo.%language_menu_databases_import02%
echo.%language_menu_databases_import03%
echo.%language_menu_databases_import04% %program_name%Databases-%setting_update_channel%.zip
echo.
echo.%language_back%
echo.
echo.
echo.
if "%databases_import_error%" == "1" (
  color c
  set databases_import_error=0
  echo.%language_databases_import_error%
  echo.
  echo.
  echo.
)
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" (
  if not exist "%location_desktop%\%program_name%Databases-%setting_update_channel%.zip" (
    set databases_import_error=1
    goto :menu_databases_import
  )
  call :databases_update --key_import=true
  %input_clear% & exit /b
)
goto :menu_databases_import







:menu_help
%log_append_place% :   [Help Menu]
%input_clear%
%logo%
echo.%language_menu_help01%
echo.%language_menu_help02%
echo.
echo.  %language_menu_main01%
echo.  %language_menu_main02%
echo.  %language_menu_main03%
echo.  %language_menu_main04%
echo.  %language_menu_main05%
echo.  %language_menu_main06%
echo.  %language_menu_main07%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" NEQ "1" if "%command%" NEQ "2" if "%command%" NEQ "3" if "%command%" NEQ "4" if "%command%" NEQ "7" if "%command%" NEQ "8" if "%command%" NEQ "9" if "%command%" NEQ "#" goto :menu_help

call :menu_help_pageTemplate begin

if "%command%" == "1" (
  call echo.%language_menu_help_cleaning_perform01%
  echo.%language_menu_help_cleaning_perform02%
  echo.
  echo.  %language_menu_cleaning01%
  echo.  %language_menu_cleaning02%
  echo.
  call echo.%language_menu_help_cleaning_perform03%
  echo.
  %logo_log% onlyLogo
  echo.
  echo.%language_menu_help_cleaning_perform04%
  call echo.%language_menu_help_cleaning_perform05%

  call :menu_help_pageTemplate

  call echo.%language_menu_help_cleaning_perform05%
  echo.
  call echo.  %language_cleaning_editing01%
  echo.  %language_cleaning_editing02%
  echo.  %language_cleaning_editing03%
  echo.
  echo.%language_menu_help_cleaning_perform06%
  echo.%language_menu_help_cleaning_perform07%
  echo.%language_menu_help_cleaning_perform08%
  echo.
  call echo.  %language_cleaning_foundObjects%
  call echo.  %language_cleaning_deletedObjects%
  echo.
  echo.%language_menu_help_cleaning_perform09%
  echo.
  echo.  %language_cleaning_reboot01%
  echo.  %language_cleaning_reboot02%
  echo.  %language_cleaning_reboot03%

  call :menu_help_pageTemplate

  echo.%language_menu_help_cleaning_perform10%
  echo.%language_menu_help_cleaning_perform11%
)
if "%command%" == "2" (
  echo.%language_menu_help_cleaning_exceptions01%
  echo.%language_menu_help_cleaning_exceptions02%
  echo.
  echo.  %language_menu_exceptions01%
  echo.  %language_menu_exceptions02%
  echo.  %language_menu_exceptions03%
  echo.
  echo.%language_menu_help_cleaning_exceptions03%
  echo.
  echo.  %language_menu_exceptions_new01%
  echo.  %language_menu_exceptions_new02%
)
if "%command%" == "3" (
  echo.%language_menu_help_databases_update01%
  echo.%language_menu_help_databases_update02%
)
if "%command%" == "4" (
  echo.%language_menu_help_databases_import01%
  echo.%language_menu_help_databases_import02%
  echo.
  echo.%language_menu_help_databases_import03%
  call echo.%language_menu_help_databases_import04%
  echo.
  echo.  %language_menu_databases_import01%
  echo.  %language_menu_databases_import02%
  echo.  %language_menu_databases_import03%
)
if "%command%" == "7" (
  call echo.%language_menu_help_program_settings01%
  echo.%language_menu_help_program_settings02%
  echo.%language_menu_help_program_settings03%
  echo.
  echo.  %language_menu_settings05% %language_menu_setting_enabled%
  echo.  %language_menu_settings05% %language_menu_setting_disabled%
  echo.
  echo.%language_menu_help_program_settings04%
  echo.
  call echo.  %language_menu_update_channel01%
  echo.  %language_menu_update_channel02%
  echo.  %language_menu_update_channel03%
  echo.  %language_menu_update_channel04%
  echo.
  call echo.%language_menu_help_program_settings05%
)
if "%command%" == "8" (
  echo.%language_menu_help_program_dataManagement01%
  echo.%language_menu_help_program_dataManagement02%
  echo.
  echo.  %language_menu_dataManagement02%
  echo.  %language_menu_dataManagement03%
  echo.  %language_menu_dataManagement04%
  echo.  %language_menu_dataManagement05%
  echo.  %language_menu_dataManagement06%
  echo.  %language_menu_dataManagement07%
  echo.
  echo.%language_menu_help_program_dataManagement03%
)
if "%command%" == "9" (
  echo.%language_menu_help_program_update01%
  echo.%language_menu_help_program_update02%
)
if "%command%" == "#" (
  call echo.%language_menu_help_program_uninstall01%
  call echo.%language_menu_help_program_uninstall02%
)

call :menu_help_pageTemplate end
goto :menu_help







:menu_help_pageTemplate
if "%1" NEQ "begin" (
  echo.
  echo.
  echo.
  echo.%language_menu_help03%
  pause>nul
)

if "%1" NEQ "end" (
  %logo%
  echo.%language_menu_help01%
  echo.
)
exit /b







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
echo.%language_menu_settings17%

if "%setting_cleaningRule_experimental%" == "true" (
  call echo.%language_menu_settings19% %language_menu_setting_enabled%
) else call echo.%language_menu_settings19% %language_menu_setting_disabled%

if "%setting_cleaningRule_heuristic%" == "true" (
  call echo.%language_menu_settings21% %language_menu_setting_enabled%
) else call echo.%language_menu_settings21% %language_menu_setting_disabled%

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
) else set setting_logging_advanced=false

if "%command%" == "4" if "%setting_debug%" == "true" (
  set setting_debug=false
) else if "%setting_debug%" == "false" (
  set setting_debug=true
) else set setting_debug=false

if "%command%" == "5" if "%setting_tipOfTheDay%" == "true" (
  set setting_tipOfTheDay=false
) else if "%setting_tipOfTheDay%" == "false" (
  set setting_tipOfTheDay=true
) else set setting_tipOfTheDay=true

if "%command%" == "6" call :menu_appearance

if "%command%" == "7" call :menu_update_channel

if "%command%" == "8" if "%setting_update_program_auto%" == "true" (
  set setting_update_program_auto=false
) else if "%setting_update_program_auto%" == "false" (
  set setting_update_program_auto=true
) else set setting_update_program_auto=false

if "%command%" == "9" if "%setting_update_databases_auto%" == "true" (
  set setting_update_databases_auto=false
) else if "%setting_update_databases_auto%" == "false" (
  set setting_update_databases_auto=true
) else set setting_update_databases_auto=true

if /i "%command%" == "A" if "%setting_update_program_remind%" == "true" (
  set setting_update_program_remind=false
) else if "%setting_update_program_remind%" == "false" (
  set setting_update_program_remind=true
) else set setting_update_program_remind=true

if /i "%command%" == "B" if "%setting_update_databases_remind%" == "true" (
  set setting_update_databases_remind=false
) else if "%setting_update_databases_remind%" == "false" (
  set setting_update_databases_remind=true
) else set setting_update_databases_remind=true

if /i "%command%" == "C" if "%setting_cleaningRule_experimental%" == "true" (
  set setting_cleaningRule_experimental=false
) else if "%setting_cleaningRule_experimental%" == "false" (
  set setting_cleaningRule_experimental=true
) else set setting_cleaningRule_experimental=false

if /i "%command%" == "D" if "%setting_cleaningRule_heuristic%" == "true" (
  set setting_cleaningRule_heuristic=false
) else if "%setting_cleaningRule_heuristic%" == "false" (
  set setting_cleaningRule_heuristic=true
) else set setting_cleaningRule_heuristic=true

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







:menu_appearance
%log_append_place% :   [Appearance Menu]
%input_clear%
%logo%
echo.%language_menu_appearance01%
echo.%language_menu_appearance02%
echo.%language_menu_appearance03%
echo.%language_menu_appearance04%
echo.%language_menu_appearance05%
echo.%language_menu_appearance06%
echo.%language_menu_appearance07%
echo.%language_menu_appearance08%
echo.%language_menu_appearance09%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" set setting_theme=0b
if "%command%" == "2" set setting_theme=b0
if "%command%" == "3" set setting_theme=5d
if "%command%" == "4" set setting_theme=1f
if "%command%" == "5" set setting_theme=0e
if "%command%" == "6" set setting_theme=d0
if "%command%" == "7" call :menu_appearance_customTheme
goto :menu_appearance







:menu_appearance_customTheme
%log_append_place% :   [Theme Customization Menu]
%input_clear%
%logo%
echo.%language_menu_appearance_customTheme01%
echo.%language_menu_appearance_customTheme02%
echo.%language_menu_appearance_customTheme03%
echo.%language_menu_appearance_customTheme04%
echo.%language_menu_appearance_customTheme05%
echo.%language_menu_appearance_customTheme06%
echo.%language_menu_appearance_customTheme07%
echo.%language_menu_appearance_customTheme08%
echo.%language_menu_appearance_customTheme09%
echo.%language_menu_appearance_customTheme10%
echo.%language_menu_appearance_customTheme11%
echo.%language_menu_appearance_customTheme12%
echo.%language_menu_appearance_customTheme13%
echo.%language_menu_appearance_customTheme14%
echo.%language_menu_appearance_customTheme15%
echo.%language_menu_appearance_customTheme16%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" set theme_background=0
if "%command%" == "2" set theme_background=1
if "%command%" == "3" set theme_background=2
if "%command%" == "4" set theme_background=3
if "%command%" == "5" set theme_background=4
if "%command%" == "6" set theme_background=5
if "%command%" == "7" set theme_background=6
if "%command%" == "8" set theme_background=7
if "%command%" == "9" set theme_background=8
if /i "%command%" == "A" set theme_background=9
if /i "%command%" == "B" set theme_background=b
if /i "%command%" == "C" set theme_background=d
if /i "%command%" == "D" set theme_background=e
if /i "%command%" == "E" set theme_background=f
if /i "%command%" == "F" set theme_font=0
if /i "%command%" == "G" set theme_font=1
if /i "%command%" == "H" set theme_font=2
if /i "%command%" == "I" set theme_font=3
if /i "%command%" == "J" set theme_font=4
if /i "%command%" == "K" set theme_font=5
if /i "%command%" == "L" set theme_font=6
if /i "%command%" == "M" set theme_font=7
if /i "%command%" == "N" set theme_font=8
if /i "%command%" == "O" set theme_font=9
if /i "%command%" == "P" set theme_font=b
if /i "%command%" == "Q" set theme_font=d
if /i "%command%" == "R" set theme_font=e
if /i "%command%" == "S" set theme_font=f

if "%theme_background%" NEQ "" if "%theme_font%" NEQ "" set setting_theme=%theme_background%%theme_font%
goto :menu_appearance_customTheme







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
if "%command%" == "3" if exist %dataDir%\databases rd /s /q %dataDir%\databases
if "%command%" == "4" if exist %dataDir%\settings  rd /s /q %dataDir%\settings
if "%command%" == "5" if exist %dataDir%\backups   rd /s /q %dataDir%\backups
if "%command%" == "6" (
  for /f "delims=" %%i in ('dir /b %dataDir%\logs') do if "%%i" NEQ "%program_name%_%currentDate%.log" if "%%i" NEQ "%program_name%_%currentDate%_debug.log" del /q "%dataDir%\logs\%%i"
  for /f "delims=" %%i in ('dir /b %dataDir%\backups') do if "%%i" NEQ "registry_%currentDate%.reg" if "%%i" NEQ "consoleSettings.reg" del /q "%dataDir%\backups\%%i"
)
if "%command%" == "7" (
  if exist %dataDir%\logs      rd /s /q %dataDir%\logs
  if exist %dataDir%\databases rd /s /q %dataDir%\databases
  if exist %dataDir%\settings  rd /s /q %dataDir%\settings
  if exist %dataDir%\backups   rd /s /q %dataDir%\backups
)
if "%command%" == "8" start explorer "%cd%\%dataDir%"
if "%command%" == "9" start explorer "%cd%\temp"

call :settings_apply
goto :menu_dataManagement







:settings_save
if not exist %dataDir%\settings md %dataDir%\settings>nul 2>nul

echo.# %program_name% Settings #>%settings%
echo.cleaningRule_experimental=%setting_cleaningRule_experimental%>>%settings%
echo.cleaningRule_heuristic=%setting_cleaningRule_heuristic%>>%settings%
echo.debug=%setting_debug%>>%settings%
echo.firstRun=%setting_firstRun%>>%settings%
echo.language=%setting_language%>>%settings%
echo.logging=%setting_logging%>>%settings%
echo.logging_advanced=%setting_logging_advanced%>>%settings%
echo.tipOfTheDay=%setting_tipOfTheDay%>>%settings%
echo.theme=%setting_theme%>>%settings%
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

for /f "delims=" %%i in ('color %setting_theme%') do set setting_theme=0b
echo.%setting_theme%>temp\theme
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

if "%setting_update_databases_remind%" == "true" start /wait /b %update% --key_check=databases
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
color c
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

%log_append_line% %log_debug% 1
echo.Environment Variables:>>%log_debug%
set>>%log_debug%

%loadingUpdate% stop

if exist %dataDir%\backups\consoleSettings.reg reg import %dataDir%\backups\consoleSettings.reg 2>nul

%module_sleep% -m 300

       if "%1" == "reboot" ( shutdown /r /t 0
) else if "%1" == "update" (
  set key_target=%cd%
  cd "%temp%\%program_name%-Update"
  start update.cmd
) else if exist temp rd /s /q temp
exit