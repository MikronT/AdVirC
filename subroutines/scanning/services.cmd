call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Processes]>>%log%
echo.   [Services]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\processes\services.db) do (
  set errorLevel=
  sc query "%%i">>%log_debug%
  if "!errorLevel!" == "0" (
    echo.%%i>>%cleaning_services%
    echo.    - %%i>>%log%
    echo.[Service] %%i
    set /a counter_foundObjects+=1
  ) else (
    echo.Service not found - %%i>>%log_debug%
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