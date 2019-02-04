if "%1" == "reset" (
  set counter_loading=0
) else (
  if "%1" == "stop" (
    set counter_loading=stop
  ) else set /a counter_loading+=%1
)

echo.%counter_loading%>temp\counter_loading
exit /b