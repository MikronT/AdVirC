@%logo_log%
%log_append_place% : [Deleting]
setlocal EnableDelayedExpansion



%log_append_place% :   [Processes]>>%%i
%log_append_place% :     [Services]>>%%i



if exist %cleaning_services% for /f "delims=" %%i in (%cleaning_services%) do (
  set errorLevel=
  sc delete "%%i">>%log_debug%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Service] %%i
    set /a counter_deletedObjects+=1
  ) else (
    echo.sc delete "%%i">>%cleaning_rebootScript%
    echo.    [Error] Not Found/Access Denied - %%i>>%log%
    echo.[Error] [Service] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)



%log_append_place% :   Script Completed>>%%i
%log_append_place% :   [Processes]>>%%i
%log_append_place% :     [Tasks]>>%%i



if exist %cleaning_tasks% for /f "delims=" %%i in (%cleaning_tasks%) do (
  set errorLevel=
  schtasks /delete /tn "%%i" /f>>%log_debug%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Task] %%i
    set /a counter_deletedObjects+=1
  ) else (
    echo.schtasks /delete /tn "%%i" /f>>%cleaning_rebootScript%
    echo.    [Error] Not Found/Access Denied - %%i>>%log%
    echo.[Error] [Task] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)



%log_append_place% :   Script Completed>>%%i
%log_append_place% :   [Processes]>>%%i
%log_append_place% :     [Processes]>>%%i



if exist %cleaning_processes% for /f "delims=" %%i in (%cleaning_processes%) do (
  set errorLevel=
  taskkill /f /t /im "%%i">>%log_debug%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Process] %%i
    set /a counter_deletedObjects+=1
  ) else (
    echo.    [Error] Not Found/Access Denied - %%i>>%log%
    echo.[Error] [Process] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)



%log_append_place% :   Script Completed>>%%i
%log_append_place% :   [Registry]>>%%i



if exist %cleaning_registry% for /f "delims=" %%i in (%cleaning_registry%) do (
  set errorLevel=
  reg delete %%i /f>>%log_debug%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Key] %%i
    set /a counter_deletedObjects+=1
  ) else (
    echo.reg delete %%i /f>>%cleaning_rebootScript%
    echo.    [Error] Not Found/Access Denied - %%i>>%log%
    echo.[Error] [Key] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)



%log_append_place% :   Script Completed>>%%i
%log_append_place% :   [File System]>>%%i
%log_append_place% :     [Temp]>>%%i



if exist %cleaning_temp% for /f "delims=" %%i in (%cleaning_temp%) do (
  if exist "%%i" (
    rem rd /s /q "%%i\" clears all subdirectories and files without removing directory
    rd /s /q "%%i">>%log_debug%
    if exist "%%i" (
      dir /a:-d /s /b "%%i">>%cleaning_filesToRemove%
      echo.rd /s /q "%%i\">>%cleaning_rebootScript%
      echo.    [Error] Access Denied - %%i>>%log%
      echo.[Error] [Temp] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Temp] %%i
      set /a counter_deletedObjects+=1
    )
  ) else (
    echo.    [Warning] Not Found - %%i>>%log%
    echo.[Warning] [Temp] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
  md "%%i">nul 2>nul
)



%log_append_place% :   Script Completed>>%%i
%log_append_place% :   [File System]>>%%i
%log_append_place% :     [Folders]>>%%i



if exist %cleaning_folders% for /f "delims=" %%i in (%cleaning_folders%) do (
  if exist "%%i" (
    rd /s /q "%%i">>%log_debug%
    if exist "%%i" (
      dir /a:-d /s /b "%%i">>%cleaning_filesToRemove%
      echo.rd /s /q "%%i">>%cleaning_rebootScript%
      echo.    [Error] Access Denied - %%i>>%log%
      echo.[Error] [Folder] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Folder] %%i
      set /a counter_deletedObjects+=1
    )
  ) else (
    echo.    [Warning] Not Found - %%i>>%log%
    echo.[Warning] [Folder] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)



%log_append_place% :   Script Completed>>%%i
%log_append_place% :   [File System]>>%%i
%log_append_place% :     [Files]>>%%i



if exist %cleaning_files% for /f "delims=" %%i in (%cleaning_files%) do (
  if exist "%%i" (
    del /q "%%i">>%log_debug%
    if exist "%%i" (
      echo.%%i>>%cleaning_filesToRemove%
      echo.del /q "%%i">>%cleaning_rebootScript%
      echo.    [Error] Access Denied - %%i>>%log%
      echo.[Error] [File] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[File] %%i
      set /a counter_deletedObjects+=1
    )
  ) else (
    echo.    [Warning] Not Found - %%i>>%log%
    echo.[Warning] [File] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)



%log_append_place% :   Script Completed>>%%i
%log_append_place% :   [File System]>>%%i
%log_append_place% :     [Shortcuts]>>%%i



if exist %cleaning_shortcuts% for /f "delims=" %%i in (%cleaning_shortcuts%) do (
  if exist "%%i" (
    del /s /q "%%i">>%log_debug%
    if exist "%%i" (
      echo.%%i>>%cleaning_filesToRemove%
      echo.del /q "%%i">>%cleaning_rebootScript%
      echo.    [Error] Access Denied - %%i>>%log%
      echo.[Error] [Shortcut] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Shortcut] %%i
      set /a counter_deletedObjects+=1
    )
  ) else (
    echo.    [Warning] Not Found - %%i>>%log%
    echo.[Warning] [Shortcut] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)



%log_append_place% :   Script Completed>>%%i
%log_append_place% :   [File System]>>%%i
%log_append_place% :     [Extensions]>>%%i



if exist %cleaning_extensions% for /f "delims=" %%i in (%cleaning_extensions%) do (
  if exist "%%i" (
    rd /s /q "%%i">>%log_debug%
    if exist "%%i" (
      dir /a:-d /s /b "%%i">>%cleaning_filesToRemove%
      echo.rd /s /q "%%i">>%cleaning_rebootScript%
      echo.    [Error] Access Denied - %%i>>%log%
      echo.[Error] [Extension] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Extension] %%i
      set /a counter_deletedObjects+=1
    )
  ) else (
    echo.    [Warning] Not Found - %%i>>%log%
    echo.[Warning] [Extension] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)



%log_append_place% :   Script Completed>>%%i



endlocal
echo.>temp\return_deletingCompleted
%module_sleep% 3
exit