if "%1" == "reset" (
  set loadingCounter=0
) else set /a loadingCounter+=%1
if "%1" == "stop" set loadingCounter=stop

echo.%loadingCounter%>temp\loadingCounter
exit /b