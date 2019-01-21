call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Cleaning]>>%log%
echo.   [Services]>>%log%

for /f "delims=" %%i in (%cleaning-services%) do (
  set errorLevel=
  sc delete "%%i">>%debugLog%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Service] %%i
    set /a deletedObjects+=1
  ) else (
    echo.[Error] Service not found or access denied - %%i>>%log%
    echo.Error^! [Service] %%i
  )
  echo.!deletedObjects!>temp\deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Tasks]>>%log%

for /f "delims=" %%i in (%cleaning-tasks%) do (
  set errorLevel=
  schtasks /delete /tn "%%i" /f>>%debugLog%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Task] %%i
    set /a deletedObjects+=1
  ) else (
    echo.[Error] Task not found or access denied - %%i>>%log%
    echo.Error^! [Task] %%i
  )
  echo.!deletedObjects!>temp\deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Processes]>>%log%

for /f "delims=" %%i in (%cleaning-processes%) do (
  set errorLevel=
  taskkill /f /t /im "%%i">>%debugLog%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Process] %%i
    set /a deletedObjects+=1
  ) else (
    echo.[Error] Process not found or access denied - %%i>>%log%
    echo.Error^! [Process] %%i
  )
  echo.!deletedObjects!>temp\deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Registry]>>%log%

for /f "delims=" %%i in (%cleaning-registry%) do (
  set errorLevel=
  reg delete "%%i" /f>>%debugLog%
  if "!errorLevel!" == "0" (
    echo.    - %%i>>%log%
    echo.[Key] %%i
    set /a deletedObjects+=1
  ) else (
    echo.[Error] Key not found or access denied - %%i>>%log%
    echo.Error^! [Key] %%i
  )
  echo.!deletedObjects!>temp\deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Temp]>>%log%

for /f "delims=" %%i in (%cleaning-temp%) do (
  if exist "%%i" (
    rem rd /s /q "%%i\" clears all subdirectories and files without removing directory
    rd /s /q "%%i">>%debugLog%
    if exist "%%i" (
      echo.[Error] Access denied - %%i>>%log%
      echo.Error^! [Temp] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Temp] %%i
      set /a deletedObjects+=1
    )
  ) else (
    echo.[Warning] Temp not found - %%i>>%log%
    echo.Warning^! [Temp] %%i
  )
  echo.!deletedObjects!>temp\deletedObjects
  if not exist "%%i" md "%%i"
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Folders]>>%log%

for /f "delims=" %%i in (%cleaning-folders%) do (
  if exist "%%i" (
    rd /s /q "%%i">>%debugLog%
    if exist "%%i" (
      echo.[Error] Access denied - %%i>>%log%
      echo.Error^! [Folder] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Folder] %%i
      set /a deletedObjects+=1
    )
  ) else (
    echo.[Warning] Folder not found - %%i>>%log%
    echo.Warning^! [Folder] %%i
  )
  echo.!deletedObjects!>temp\deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Files]>>%log%

for /f "delims=" %%i in (%cleaning-files%) do (
  if exist "%%i" (
    del /q "%%i">>%debugLog%
    if exist "%%i" (
      echo.[Error] Access denied - %%i>>%log%
      echo.Error^! [File] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[File] %%i
      set /a deletedObjects+=1
    )
  ) else (
    echo.[Warning] File not found - %%i>>%log%
    echo.Warning^! [File] %%i
  )
  echo.!deletedObjects!>temp\deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Shortcuts]>>%log%

for /f "delims=" %%i in (%cleaning-shortcuts%) do (
  if exist "%%i" (
    del /s /q "%%i">>%debugLog%
    if exist "%%i" (
      echo.[Error] Access denied - %%i>>%log%
      echo.Error^! [Shortcut] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Shortcut] %%i
      set /a deletedObjects+=1
    )
  ) else (
    echo.[Warning] Shortcut not found - %%i>>%log%
    echo.Warning^! [Shortcut] %%i
  )
  echo.!deletedObjects!>temp\deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.   [Extensions]>>%log%

for /f "delims=" %%i in (%cleaning-extensions%) do (
  if exist "%%i" (
    rd /s /q "%%i">>%debugLog%
    if exist "%%i" (
      echo.[Error] Access denied - %%i>>%log%
      echo.Error^! [Extension] %%i
    ) else (
      echo.    - %%i>>%log%
      echo.[Extension] %%i
      set /a deletedObjects+=1
    )
  ) else (
    echo.[Warning] Extension not found - %%i>>%log%
    echo.Warning^! [Extension] %%i
  )
  echo.!deletedObjects!>temp\deletedObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module-sleep% 3
exit