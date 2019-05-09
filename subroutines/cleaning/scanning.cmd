@%logo_log%
%log_append_place% : [Scanning]
setlocal EnableDelayedExpansion



%log_append_place% :   [Processes]
%log_append_place% :     [Services]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\processes\services.db) do (
  set errorLevel=
  sc query "%%i">>%log_debug%
  if "!errorLevel!" == "" call :cleaning_scanning_subroutine Service %cleaning_services% %%i
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
  schtasks /query /tn "%%i">nul 2>>%log_debug%
  if "!errorLevel!" == "" call :cleaning_scanning_subroutine Task %cleaning_tasks% %%i
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
    reg query "%%i\%%j">nul 2>>%log_debug%
    if "!errorLevel!" == "" call :cleaning_scanning_subroutine Class %cleaning_registry% "%%i\%%j"
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
    reg query "%%i\%%j">nul 2>>%log_debug%
    if "!errorLevel!" == "" call :cleaning_scanning_subroutine Key %cleaning_registry% "%%i\%%j"
    if "!errorLevel!" == "0" call :cleaning_scanning_subroutine Key %cleaning_registry% "%%i\%%j"
    if "%setting_logging_advanced%" == "true" if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Temp]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\temp.db) do (
  if exist "%%i" (
    echo.%%i>>%cleaning_temp%
    echo.    - %%i>>%log%
    echo.[Temp] %%i
    set /a counter_foundObjects+=1
  ) else (
    if "%setting_logging_advanced%" == "true" echo.Not Found - %%i>>%log_debug%
  )
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [AppData Folders]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\folders\appData.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_folders%
      echo.    - %%i\%%j>>%log%
      echo.[Folder] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    )
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
      echo.%%i\%%j>>%cleaning_folders%
      echo.    - %%i\%%j>>%log%
      echo.[Folder] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [System Drive Folders]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\folders\systemDrive.db) do (
  if exist "%systemDrive%\%%i" (
    echo.%systemDrive%\%%i>>%cleaning_folders%
    echo.    - %systemDrive%\%%i>>%log%
    echo.[Folder] %systemDrive%\%%i
    set /a counter_foundObjects+=1
  ) else (
    if "%setting_logging_advanced%" == "true" echo.Not Found - %systemDrive%\%%i>>%log_debug%
  )
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [User Profile Folders]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\userProfile.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\folders\userProfile.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_folders%
      echo.    - %%i\%%j>>%log%
      echo.[Folder] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Windows Directory Folders]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\folders\winDir.db) do (
  if exist "%winDir%\%%i" (
    echo.%winDir%\%%i>>%cleaning_folders%
    echo.    - %winDir%\%%i>>%log%
    echo.[Folder] %winDir%\%%i
    set /a counter_foundObjects+=1
  ) else (
    if "%setting_logging_advanced%" == "true" echo.Not Found - %winDir%\%%i>>%log_debug%
  )
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [AppData Files]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\files\appData.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_files%
      echo.    - %%i\%%j>>%log%
      echo.[File] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    )
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
      echo.%%i\%%j>>%cleaning_files%
      echo.    - %%i\%%j>>%log%
      echo.[File] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [System Drive Files]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\files\systemDrive.db) do (
  if exist "%systemDrive%\%%i" (
    echo.%systemDrive%\%%i>>%cleaning_files%
    echo.    - %systemDrive%\%%i>>%log%
    echo.[File] %systemDrive%\%%i
    set /a counter_foundObjects+=1
  ) else (
    if "%setting_logging_advanced%" == "true" echo.Not Found - %systemDrive%\%%i>>%log_debug%
  )
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Windows Directory Files]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\files\winDir.db) do (
  if exist "%winDir%\%%i" (
    echo.%winDir%\%%i>>%cleaning_files%
    echo.    - %winDir%\%%i>>%log%
    echo.[File] %winDir%\%%i
    set /a counter_foundObjects+=1
  ) else (
    if "%setting_logging_advanced%" == "true" echo.Not Found - %winDir%\%%i>>%log_debug%
  )
  echo.!counter_foundObjects!>temp\counter_foundObjects
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Shortcuts]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\shortcuts.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\files\shortcuts.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_shortcuts%
      echo.    - %%i\%%j>>%log%
      echo.[Shortcut] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [Browsers Shortcuts]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\browsersShortcuts.db) do (
  for /f "tokens=1,2,3* delims=;" %%j in (%dataDir%\databases\rewrited\files\browsersShortcuts.db) do (
    if exist "%%i\%%j.lnk" (
      echo.del /s /q "%%i\%%j.lnk">>%cleaning_rebootScript%
      echo.%cd%\%module_shortcut% /f:"%%i\%%j.lnk" /t:"%%k" /i:"%%k" /w:"%%l">>%cleaning_rebootScript%
      echo.    - %%i\%%j.lnk>>%log%
      echo.[Browser Shortcut] %%i\%%j.lnk ^(can be overrided^)
    ) else (
      if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j.lnk>>%log_debug%
    )
  )
)



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [File System]
%log_append_place% :     [AppData Extensions]



for /f "delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (%dataDir%\databases\rewrited\folders\extensions.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_extensions%
      echo.    - %%i\%%j>>%log%
      echo.[Extension] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    )
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
        echo.%%i\%%j\%%k>>%cleaning_extensions%
        echo.    - %%i\%%j\%%k>>%log%
        echo.[Extension] %%i\%%j\%%k
        set /a counter_foundObjects+=1
      ) else (
        if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j\%%k>>%log_debug%
      )
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
      echo.%%i\%%j>>%cleaning_extensions%
      echo.    - %%i\%%j>>%log%
      echo.[Extension] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j>>%log_debug%
    )
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
        echo.%%i\%%j\%%k>>%cleaning_extensions%
        echo.    - %%i\%%j\%%k>>%log%
        echo.[Extension] %%i\%%j\%%k
        set /a counter_foundObjects+=1
      ) else (
        if "%setting_logging_advanced%" == "true" echo.Not Found - %%i\%%j\%%k>>%log_debug%
      )
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
set /a counter_foundObjects+=1
exit /b