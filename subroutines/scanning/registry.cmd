call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Registry]>>%log%
echo.   [Classes]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\classes.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\registry\classes.db) do (
    set errorLevel=
    reg query "%%i\%%j">>%log_debug%
    if "!errorLevel!" == "0" (
      echo.%%i\%%j>>%cleaning_registry%
      echo.    - %%i\%%j>>%log%
      echo.[Class] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      echo.Class not found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
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
    reg query "%%i\%%j">>%log_debug%
    if "!errorLevel!" == "0" (
      echo.%%i\%%j>>%cleaning_registry%
      echo.    - %%i\%%j>>%log%
      echo.[Key] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      echo.Key not found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module_sleep% 3
exit