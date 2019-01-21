call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Processes]>>%log%
echo.   [Services]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\processes\services.db) do (
  set errorLevel=
  sc query "%%i">>%debugLog%
  if "!errorLevel!" == "0" (
    echo.%%i>>%cleaning-services%
    echo.    - %%i>>%log%
    echo.[Service] %%i
    set /a foundObjects+=1
  ) else (
    echo.Service not found - %%i>>%debugLog%
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