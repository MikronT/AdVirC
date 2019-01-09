if "%1" == "reset" (
  set counter-loading=0
) else set /a counter-loading+=%1
if "%1" == "stop" set counter-loading=stop

echo.%counter-loading%>temp\counter-loading
exit /b