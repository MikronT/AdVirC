call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Processes]>>%log%
echo.   [Tasks]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\processes\tasks.db) do (
  set errorLevel=
  schtasks /query /tn "%%i">>%debugLog%
  if "!errorLevel!" == "0" (
    echo.%%i>>%cleaning-tasks%
    echo.    - %%i>>%log%
    echo.[Task] %%i
    set /a foundObjects+=1
  ) else (
    echo.Task not found - %%i>>%debugLog%
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