call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Processes]>>%log%
echo.   [Processes]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\processes\processes.db) do (
  set errorLevel=
  tasklist /fi "imagename eq %%i">>%log_debug%
  if "!errorLevel!" == "0" (
    echo.%%i>>%cleaning_processes%
    echo.    - %%i>>%log%
    echo.[Process] %%i
    set /a counter_foundObjects+=1
  ) else (
    echo.Process not found - %%i>>%log_debug%
  )
  echo.!counter_foundObjects!>temp\counter_foundObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module_sleep% 3
exit