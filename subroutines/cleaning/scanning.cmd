@%logo_log%
%log_append_place% : [Scanning]
setlocal EnableDelayedExpansion



%log_append_place% :   [Processes]
%log_append_place% :     [Services]
echo.%language_cleaning_scanning_services%



for /f "delims=" %%i in (%dataDir%\databases\rewrited\processes\services.db) do (
  set errorLevel=
  sc query "%%i">nul
  if "!errorLevel!" == ""  call :cleaning_scanning_subroutine %language_cleaning_label_service% %cleaning_services% %%i
  if "!errorLevel!" == "0" call :cleaning_scanning_subroutine %language_cleaning_label_service% %cleaning_services% %%i
  if "%setting_logging_advanced%" == "true" if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [Processes]
%log_append_place% :     [Tasks]
echo.%language_cleaning_scanning_tasks%



for /f "delims=" %%i in (%dataDir%\databases\rewrited\processes\tasks.db) do (
  set errorLevel=
  schtasks /query /tn "%%i">nul 2>nul
  if "!errorLevel!" == ""  call :cleaning_scanning_subroutine %language_cleaning_label_task% %cleaning_tasks% %%i
  if "!errorLevel!" == "0" call :cleaning_scanning_subroutine %language_cleaning_label_task% %cleaning_tasks% %%i
  if "%setting_logging_advanced%" == "true" if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [Processes]
%log_append_place% :     [Processes]
echo.%language_cleaning_scanning_processes%

if "%setting_debug%" == "true" (
  %log_append_line% %log_debug% 1
  echo.    All Running Processes:>>%log_debug%
  tasklist>>%log_debug%
  %log_append_line% %log_debug% 1
)
%loadingUpdate% 1



for /f "delims=" %%i in (%dataDir%\databases\rewrited\processes\processes.db) do (
  for /f "skip=3 delims= " %%j in ('tasklist /fi "imagename eq %%i"') do if "%%j" == "%%i" (
    call :cleaning_scanning_subroutine %language_cleaning_label_process% %language_cleaning_label_process% %%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [Registry]
%log_append_place% :     [Classes]
echo.%language_cleaning_scanning_registry%



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\classes.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\registry\classes.db) do (
    set errorLevel=
    reg query "%%i\%%j">nul 2>nul
    if "!errorLevel!" == ""  call :cleaning_scanning_subroutine %language_cleaning_label_class% %cleaning_registry% "%%i\%%j"
    if "!errorLevel!" == "0" call :cleaning_scanning_subroutine %language_cleaning_label_class% %cleaning_registry% "%%i\%%j"
    if "%setting_logging_advanced%" == "true" if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [Registry]
%log_append_place% :     [Keys]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\keys.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\registry\keys.db) do (
    set errorLevel=
    reg query "%%i\%%j">nul 2>nul
    if "!errorLevel!" == ""  call :cleaning_scanning_subroutine %language_cleaning_label_key% %cleaning_registry% "%%i\%%j"
    if "!errorLevel!" == "0" call :cleaning_scanning_subroutine %language_cleaning_label_key% %cleaning_registry% "%%i\%%j"
    if "%setting_logging_advanced%" == "true" if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [Registry]
%log_append_place% :     [Keys]
%log_append_place% :       [Software]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\keys.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\dirs\keys-software.db) do (
    for /f "delims=" %%k in (%dataDir%\databases\rewrited\registry\keys-software.db) do (
      set errorLevel=
      reg query "%%i\%%j\%%k">nul 2>nul
      if "!errorLevel!" == ""  call :cleaning_scanning_subroutine %language_cleaning_label_key% %cleaning_registry% "%%i\%%j\%%k"
      if "!errorLevel!" == "0" call :cleaning_scanning_subroutine %language_cleaning_label_key% %cleaning_registry% "%%i\%%j\%%k"
      if "%setting_logging_advanced%" == "true" if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i\%%j\%%k>>%log_debug%
      echo.!counter_foundObjects!>temp\counter_foundObjects
    )
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [Registry]
%log_append_place% :     [Keys]
%log_append_place% :       [Software]
%log_append_place% :         [Run]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\keys.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\dirs\keys-software.db) do (
    for /f "delims=" %%k in (%dataDir%\databases\rewrited\dirs\keys-software-run.db) do (
      for /f "delims=" %%l in (%dataDir%\databases\rewrited\dirs\keys-software-runs.db) do (
        for /f "delims=" %%m in (%dataDir%\databases\rewrited\registry\keys-software-run.db) do (
          set errorLevel=
          reg query "%%i\%%j\%%k\%%l\%%m">nul 2>nul
          if "!errorLevel!" == ""  call :cleaning_scanning_subroutine %language_cleaning_label_key% %cleaning_registry% "%%i\%%j\%%k\%%l\%%m"
          if "!errorLevel!" == "0" call :cleaning_scanning_subroutine %language_cleaning_label_key% %cleaning_registry% "%%i\%%j\%%k\%%l\%%m"
          if "%setting_logging_advanced%" == "true" if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i\%%j\%%k\%%l\%%m>>%log_debug%
          echo.!counter_foundObjects!>temp\counter_foundObjects
        )
      )
    )
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Temp]
echo.%language_cleaning_scanning_temp%



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\temp.db) do (
  if exist "%%i" (
    call :cleaning_scanning_subroutine %language_cleaning_label_temp% %cleaning_temp% %%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i>>%log_debug%
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [AppData Folders]
echo.%language_cleaning_scanning_folders%



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\folders\appData.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine %language_cleaning_label_folder% %cleaning_folders% %%i\%%j
    ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Program Folders]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\folders\programFiles.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine %language_cleaning_label_folder% %cleaning_folders% %%i\%%j
    ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [System Drive Folders]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\folders\systemDrive.db) do (
  if exist "%systemDrive%\%%i" (
    call :cleaning_scanning_subroutine %language_cleaning_label_folder% %cleaning_folders% %systemDrive%\%%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %systemDrive%\%%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [User Profile Folders]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\userProfile.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\folders\userProfile.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine %language_cleaning_label_folder% %cleaning_folders% %%i\%%j
    ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Windows Directory Folders]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\folders\winDir.db) do (
  if exist "%winDir%\%%i" (
    call :cleaning_scanning_subroutine %language_cleaning_label_folder% %cleaning_folders% %winDir%\%%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %winDir%\%%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [AppData Files]
echo.%language_cleaning_scanning_files%



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\files\appData.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine %language_cleaning_label_file% %cleaning_files% %%i\%%j
    ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Program Files]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\files\programFiles.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine %language_cleaning_label_file% %cleaning_files% %%i\%%j
    ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [System Drive Files]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\files\systemDrive.db) do (
  if exist "%systemDrive%\%%i" (
    call :cleaning_scanning_subroutine %language_cleaning_label_file% %cleaning_files% %systemDrive%\%%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %systemDrive%\%%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Windows Directory Files]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\files\winDir.db) do (
  if exist "%winDir%\%%i" (
    call :cleaning_scanning_subroutine %language_cleaning_label_file% %cleaning_files% %winDir%\%%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %winDir%\%%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Shortcuts]
echo.%language_cleaning_scanning_shortcuts%



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\shortcuts.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\files\shortcuts.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine %language_cleaning_label_shortcut% %cleaning_shortcuts% %%i\%%j
    ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Browsers Shortcuts]



if "%setting_cleaningRule_heuristic%" == "true" for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\shortcuts.db) do (
  for /f "tokens=1,2,3* delims=;" %%j in (%dataDir%\databases\rewrited\files\browserShortcuts.db) do (
    if exist "%%i\%%j.lnk" (
      echo.del /s /q "%%i\%%j.lnk">>%cleaning_rebootScript%
      echo.%cd%\%module_shortcut% /f:"%%i\%%j.lnk" /t:"%%k" /i:"%%k" /w:"%%l">>%cleaning_rebootScript%
      echo.    - %%i\%%j.lnk>>%log%
      echo.[%language_cleaning_label_shortcut%] %%i\%%j.lnk ^(can be overrided^)
    ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j.lnk>>%log_debug%
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [AppData Extensions]
echo.%language_cleaning_scanning_extensions%



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\folders\extensions.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine %language_cleaning_label_extension% %cleaning_extensions% %%i\%%j
    ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [AppData Browsers Extensions]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\dirs\extensions.db) do (
    for /f "delims=" %%k in (%dataDir%\databases\rewrited\folders\extensions.db) do (
      if exist "%%i\%%j\%%k" (
        call :cleaning_scanning_subroutine %language_cleaning_label_extension% %cleaning_extensions% %%i\%%j\%%k
      ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j\%%k>>%log_debug%
      echo.!counter_foundObjects!>temp\counter_foundObjects
    )
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Program Files Extensions]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\folders\extensions.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine %language_cleaning_label_extension% %cleaning_extensions% %%i\%%j
    ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Program Files Browsers Extensions]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\dirs\extensions.db) do (
    for /f "delims=" %%k in (%dataDir%\databases\rewrited\folders\extensions.db) do (
      if exist "%%i\%%j\%%k" (
        call :cleaning_scanning_subroutine %language_cleaning_label_extension% %cleaning_extensions% %%i\%%j\%%k
      ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j\%%k>>%log_debug%
      echo.!counter_foundObjects!>temp\counter_foundObjects
    )
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1



endlocal
echo.>temp\return_scanningCompleted
%module_sleep% 5
exit









:cleaning_scanning_subroutine
for /f "tokens=1,2,* delims= " %%i in ("%*") do (
  echo.%%k>>%%j
  echo.    - %%k>>%log%
  echo.[%%i] %%k
)
if "%1" NEQ "Temp" set /a counter_foundObjects+=1
exit /b