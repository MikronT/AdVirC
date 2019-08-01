@%logo_log%
%log_append_place% : [Scanning]
setlocal EnableDelayedExpansion



%log_append_place% :   [Processes]
%log_append_place% :     [Services]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\processes\services.db) do (
  set errorLevel=
  sc query "%%i">nul
  if "!errorLevel!" == ""  call :cleaning_scanning_subroutine Service %cleaning_services% %%i
  if "!errorLevel!" == "0" call :cleaning_scanning_subroutine Service %cleaning_services% %%i
  if "%setting_logging_advanced%" == "true" if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [Processes]
%log_append_place% :     [Tasks]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\processes\tasks.db) do (
  set errorLevel=
  schtasks /query /tn "%%i">nul 2>nul
  if "!errorLevel!" == ""  call :cleaning_scanning_subroutine Task %cleaning_tasks% %%i
  if "!errorLevel!" == "0" call :cleaning_scanning_subroutine Task %cleaning_tasks% %%i
  if "%setting_logging_advanced%" == "true" if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [Processes]
%log_append_place% :     [Processes]

if "%setting_debug%" == "true" (
  %log_append_line% %log_debug% 1
  echo.    All Running Processes:>>%log_debug%
  tasklist>>%log_debug%
  %log_append_line% %log_debug% 1
)
%loadingUpdate% 1



for /f "delims=" %%i in (%dataDir%\databases\rewrited\processes\processes.db) do (
  for /f "skip=3 delims= " %%j in ('tasklist /fi "imagename eq %%i"') do if "%%j" == "%%i" (
    call :cleaning_scanning_subroutine Process %cleaning_processes% %%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [Registry]
%log_append_place% :     [Classes]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\classes.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\registry\classes.db) do (
    set errorLevel=
    reg query "%%i\%%j">nul 2>nul
    if "!errorLevel!" == ""  call :cleaning_scanning_subroutine Class %cleaning_registry% "%%i\%%j"
    if "!errorLevel!" == "0" call :cleaning_scanning_subroutine Class %cleaning_registry% "%%i\%%j"
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
    if "!errorLevel!" == ""  call :cleaning_scanning_subroutine Key %cleaning_registry% "%%i\%%j"
    if "!errorLevel!" == "0" call :cleaning_scanning_subroutine Key %cleaning_registry% "%%i\%%j"
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
      if "!errorLevel!" == ""  call :cleaning_scanning_subroutine Key %cleaning_registry% "%%i\%%j\%%k"
      if "!errorLevel!" == "0" call :cleaning_scanning_subroutine Key %cleaning_registry% "%%i\%%j\%%k"
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
          if "!errorLevel!" == ""  call :cleaning_scanning_subroutine Key %cleaning_registry% "%%i\%%j\%%k\%%l\%%m"
          if "!errorLevel!" == "0" call :cleaning_scanning_subroutine Key %cleaning_registry% "%%i\%%j\%%k\%%l\%%m"
          if "%setting_logging_advanced%" == "true" if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i\%%j\%%k\%%l\%%m>>%log_debug%
          echo.!counter_foundObjects!>temp\counter_foundObjects
    )
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Temp]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\temp.db) do (
  if exist "%%i" (
    call :cleaning_scanning_subroutine Temp %cleaning_temp% %%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i>>%log_debug%
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [AppData Folders]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\folders\appData.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine Folder %cleaning_folders% %%i\%%j
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
      call :cleaning_scanning_subroutine Folder %cleaning_folders% %%i\%%j
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
    call :cleaning_scanning_subroutine Folder %cleaning_folders% %systemDrive%\%%i
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
      call :cleaning_scanning_subroutine Folder %cleaning_folders% %%i\%%j
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
    call :cleaning_scanning_subroutine Folder %cleaning_folders% %winDir%\%%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %winDir%\%%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [AppData Files]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\files\appData.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine File %cleaning_files% %%i\%%j
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
      call :cleaning_scanning_subroutine File %cleaning_files% %%i\%%j
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
    call :cleaning_scanning_subroutine File %cleaning_files% %systemDrive%\%%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %systemDrive%\%%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Windows Directory Files]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\files\winDir.db) do (
  if exist "%winDir%\%%i" (
    call :cleaning_scanning_subroutine File %cleaning_files% %winDir%\%%i
  ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %winDir%\%%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Shortcuts]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\shortcuts.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\files\shortcuts.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine Shortcut %cleaning_shortcuts% %%i\%%j
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
      echo.[Browser Shortcut] %%i\%%j.lnk ^(can be overrided^)
    ) else if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j.lnk>>%log_debug%
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [AppData Extensions]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\folders\extensions.db) do (
    if exist "%%i\%%j" (
      call :cleaning_scanning_subroutine Extension %cleaning_extensions% %%i\%%j
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
        call :cleaning_scanning_subroutine Extension %cleaning_extensions% %%i\%%j\%%k
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
      call :cleaning_scanning_subroutine Extension %cleaning_extensions% %%i\%%j
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
        call :cleaning_scanning_subroutine Extension %cleaning_extensions% %%i\%%j\%%k
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