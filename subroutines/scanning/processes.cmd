call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Processes]>>%log%
echo.   [Processes]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\processes\processes.db) do (
  set errorLevel=
  tasklist /fi "imagename eq %%i">>%debugLog%
  if "!errorLevel!" == "0" (
    echo.[Process] %%i>>%deleteScript%
    echo.    - %%i>>%log%
    echo.[Process] %%i
    set /a foundObjects+=1
  ) else (
    echo.Process not found - %%i>>%debugLog%
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