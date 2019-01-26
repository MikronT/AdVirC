call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Cleaning]>>%log%
echo.   [Services]>>%log%

for /f "delims=" %%i in (%cleaning_services%) do (
  set errorLevel=
  sc delete "%%i">>%log_debug%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Service] %%i
    set /a counter_deletedObjects+=1
  ) else (
    echo.sc delete "%%i">>%rebootScript%
    echo.[Error] Service not found or access denied - %%i>>%log%
    echo.Error^! [Service] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Tasks]>>%log%

for /f "delims=" %%i in (%cleaning_tasks%) do (
  set errorLevel=
  schtasks /delete /tn "%%i" /f>>%log_debug%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Task] %%i
    set /a counter_deletedObjects+=1
  ) else (
    echo.schtasks /delete /tn "%%i" /f>>%rebootScript%
    echo.[Error] Task not found or access denied - %%i>>%log%
    echo.Error^! [Task] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Processes]>>%log%

for /f "delims=" %%i in (%cleaning_processes%) do (
  set errorLevel=
  taskkill /f /t /im "%%i">>%log_debug%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Process] %%i
    set /a counter_deletedObjects+=1
  ) else (
    echo.[Error] Process not found or access denied - %%i>>%log%
    echo.Error^! [Process] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Registry]>>%log%

for /f "delims=" %%i in (%cleaning_registry%) do (
  set errorLevel=
  reg delete "%%i" /f>>%log_debug%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Key] %%i
    set /a counter_deletedObjects+=1
  ) else (
    echo.reg delete "%%i" /f>>%rebootScript%
    echo.[Error] Key not found or access denied - %%i>>%log%
    echo.Error^! [Key] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Temp]>>%log%

for /f "delims=" %%i in (%cleaning_temp%) do (
  if exist "%%i" (
    rem rd /s /q "%%i\" clears all subdirectories and files without removing directory
    rd /s /q "%%i">>%log_debug%
    if exist "%%i" (
      dir /a:-d /s /b "%%i">>%filesToRemove%
      echo.rd /s /q "%%i\">>%rebootScript%
      echo.[Error] Access denied - %%i>>%log%
      echo.Error^! [Temp] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Temp] %%i
      set /a counter_deletedObjects+=1
    )
  ) else (
    echo.[Warning] Temp not found - %%i>>%log%
    echo.Warning^! [Temp] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
  md "%%i">nul 2>nul
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Folders]>>%log%

for /f "delims=" %%i in (%cleaning_folders%) do (
  if exist "%%i" (
    rd /s /q "%%i">>%log_debug%
    if exist "%%i" (
      dir /a:-d /s /b "%%i">>%filesToRemove%
      echo.rd /s /q "%%i">>%rebootScript%
      echo.[Error] Access denied - %%i>>%log%
      echo.Error^! [Folder] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Folder] %%i
      set /a counter_deletedObjects+=1
    )
  ) else (
    echo.[Warning] Folder not found - %%i>>%log%
    echo.Warning^! [Folder] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Files]>>%log%

for /f "delims=" %%i in (%cleaning_files%) do (
  if exist "%%i" (
    del /q "%%i">>%log_debug%
    if exist "%%i" (
      echo.%%i>>%filesToRemove%
      echo.del /q "%%i">>%rebootScript%
      echo.[Error] Access denied - %%i>>%log%
      echo.Error^! [File] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[File] %%i
      set /a counter_deletedObjects+=1
    )
  ) else (
    echo.[Warning] File not found - %%i>>%log%
    echo.Warning^! [File] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Shortcuts]>>%log%

for /f "delims=" %%i in (%cleaning_shortcuts%) do (
  if exist "%%i" (
    del /s /q "%%i">>%log_debug%
    if exist "%%i" (
      echo.%%i>>%filesToRemove%
      echo.del /q "%%i">>%rebootScript%
      echo.[Error] Access denied - %%i>>%log%
      echo.Error^! [Shortcut] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Shortcut] %%i
      set /a counter_deletedObjects+=1
    )
  ) else (
    echo.[Warning] Shortcut not found - %%i>>%log%
    echo.Warning^! [Shortcut] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Extensions]>>%log%

for /f "delims=" %%i in (%cleaning_extensions%) do (
  if exist "%%i" (
    rd /s /q "%%i">>%log_debug%
    if exist "%%i" (
      dir /a:-d /s /b "%%i">>%filesToRemove%
      echo.rd /s /q "%%i">>%rebootScript%
      echo.[Error] Access denied - %%i>>%log%
      echo.Error^! [Extension] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Extension] %%i
      set /a counter_deletedObjects+=1
    )
  ) else (
    echo.[Warning] Extension not found - %%i>>%log%
    echo.Warning^! [Extension] %%i
  )
  echo.!counter_deletedObjects!>temp\counter_deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module_sleep% 3
exit