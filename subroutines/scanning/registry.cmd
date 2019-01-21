call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Registry]>>%log%
echo.   [Classes]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\classes.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\registry\classes.db) do (
    set errorLevel=
    reg query "%%i\%%j">>%debugLog%
    if "!errorLevel!" == "0" (
      echo.[Class] %%i\%%j>>%deleteScript%
      echo.    - %%i\%%j>>%log%
      echo.[Class] %%i\%%j
      set /a foundObjects+=1
    ) else (
      echo.Class not found - %%i\%%j>>%debugLog%
    )
    echo.!foundObjects!>temp\foundObjects
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.[Registry]>>%log%
echo.   [Keys]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\keys.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\registry\keys.db) do (
    set errorLevel=
    reg query "%%i\%%j">>%debugLog%
    if "!errorLevel!" == "0" (
      echo.[Key] %%i\%%j>>%deleteScript%
      echo.    - %%i\%%j>>%log%
      echo.[Key] %%i\%%j
      set /a foundObjects+=1
    ) else (
      echo.Key not found - %%i\%%j>>%debugLog%
    )
    echo.!foundObjects!>temp\foundObjects
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module-sleep% 3
exit