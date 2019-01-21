call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[File System]>>%log%
echo.   [AppData Files]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\files\appData.db) do (
    if exist "%%i\%%j" (
      echo.[File] %%i\%%j>>%deleteScript%
      echo.    - %%i\%%j>>%log%
      echo.[File] %%i\%%j
      set /a foundObjects+=1
    ) else (
      echo.File not found - %%i\%%j>>%debugLog%
    )
    echo.!foundObjects!>temp\foundObjects
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.[File System]>>%log%
echo.   [Program Files]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\files\programFiles.db) do (
    if exist "%%i\%%j" (
      echo.[File] %%i\%%j>>%deleteScript%
      echo.    - %%i\%%j>>%log%
      echo.[File] %%i\%%j
      set /a foundObjects+=1
    ) else (
      echo.File not found - %%i\%%j>>%debugLog%
    )
    echo.!foundObjects!>temp\foundObjects
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.[File System]>>%log%
echo.   [System Drive Files]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\files\systemDrive.db) do (
  if exist "%systemDrive%\%%i" (
    echo.[File] %systemDrive%\%%i>>%deleteScript%
    echo.    - %systemDrive%\%%i>>%log%
    echo.[File] %systemDrive%\%%i
    set /a foundObjects+=1
  ) else (
    echo.File not found - %systemDrive%\%%i>>%debugLog%
  )
  echo.!foundObjects!>temp\foundObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.[File System]>>%log%
echo.   [Windows Directory Files]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\files\winDir.db) do (
  if exist "%winDir%\%%i" (
    echo.[File] %winDir%\%%i>>%deleteScript%
    echo.    - %winDir%\%%i>>%log%
    echo.[File] %winDir%\%%i
    set /a foundObjects+=1
  ) else (
    echo.File not found - %winDir%\%%i>>%debugLog%
  )
  echo.!foundObjects!>temp\foundObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module-sleep% 3
exit