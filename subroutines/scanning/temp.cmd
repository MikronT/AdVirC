call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[File System]>>%log%
echo.   [Temp]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\temp.db) do (
  if exist "%%i" (
    echo.%%i>>%cleaning_temp%
    echo.    - %%i>>%log%
    echo.[Temp] %%i
    set /a counter_foundObjects+=1
  ) else (
    echo.Temp not found - %%i>>%log_debug%
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