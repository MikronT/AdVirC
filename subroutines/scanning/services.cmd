call design\logLogo.cmd

echo.[Services]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\processes\services.cmd) do (
  set errorLevel=
  sc @@@@@@@@@@@@@@@@@@@@@@ "%%i">>%debugLog%
  if "!errorLevel!" == "0" (
    echo. - %%i>>%log%
    echo.[Service] %%i
    set /a counter-foundObjects+=1
  ) else (
    echo.sc delete "%%i">>%deleteScript%
    echo.Service not found - %%i>>%debugLog%
  )
)
echo.%counter-foundObjects%>temp\counter-foundObjects

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

%module-sleep% 3
exit