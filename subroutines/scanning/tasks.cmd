call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Processes]>>%log%
echo.   [Tasks]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\processes\tasks.db) do (
  set errorLevel=
  schtasks /query /tn "%%i">>%log_debug%
  if "!errorLevel!" == "0" (
    echo.%%i>>%cleaning_tasks%
    echo.    - %%i>>%log%
    echo.[Task] %%i
    set /a counter_foundObjects+=1
  ) else (
    echo.Task not found - %%i>>%log_debug%
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