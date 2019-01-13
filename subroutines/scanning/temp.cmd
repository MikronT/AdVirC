call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Dirs]>>%log%
echo.   [Temp]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\processes\temp.db) do (
  set errorLevel=
  schtasks /query /tn "%%i">>%debugLog%
  if "!errorLevel!" == "0" (
    echo.schtasks /delete /tn "%%i" /f>>%deleteScript%
    echo.    - %%i>>%log%
    echo.[Temp] %%i
    set /a foundObjects+=1
  ) else (
    echo.Temp not found - %%i>>%debugLog%
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