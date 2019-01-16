call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[File System]>>%log%
echo.   [File]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\.db) do (
  if exist "%%i" (
    echo.del /s /q "%%i">>%deleteScript%
    echo.    - %%i>>%log%
    echo.[File] %%i
    set /a foundObjects+=1
  ) else (
    echo.File not found - %%i>>%debugLog%
  )
  echo.%foundObjects%>temp\foundObjects
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module-sleep% 3
exit