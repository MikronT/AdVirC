call design\logLogo.cmd
setlocal EnableDelayedExpansion

for %%i in (%log% %log_debug%) do (
  echo.[Registry]>>%%i
  echo.   [Classes]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\classes.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\registry\classes.db) do (
    set errorLevel=
    reg query "%%i\%%j">>%log_debug%
    if "!errorLevel!" == "" call :subroutine %%i\%%j
    if "!errorLevel!" == "0" call :subroutine %%i\%%j
    if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
  echo.[Registry]>>%%i
  echo.   [Keys]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\keys.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\registry\keys.db) do (
    set errorLevel=
    reg query "%%i\%%j">>%log_debug%
    if "!errorLevel!" == "" call :subroutine2 %%i\%%j
    if "!errorLevel!" == "0" call :subroutine2 %%i\%%j
    if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i\%%j>>%log_debug%
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
)

endlocal
%module_sleep% 3
exit





:subroutine
echo.%*>>%cleaning_registry%
echo.    - %*>>%log%
echo.[Class] %*
set /a counter_foundObjects+=1
exit /b





:subroutine2
echo.%*>>%cleaning_registry%
echo.    - %*>>%log%
echo.[Key] %*
set /a counter_foundObjects+=1
exit /b