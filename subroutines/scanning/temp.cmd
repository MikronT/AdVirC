call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[File System]>>%log%
echo.   [Temp]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\temp.db) do (
  if exist "%%i" (
    echo.%%i>>%cleaning-temp%
    echo.    - %%i>>%log%
    echo.[Temp] %%i
    set /a foundObjects+=1
  ) else (
    echo.Temp not found - %%i>>%debugLog%
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