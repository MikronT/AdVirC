call design\logLogo.cmd

echo.[Processes]>>%log%
for /f "delims=" %%i in (files\databases\4-full\rewrited\processes.db) do (
  set errorLevel=
  taskkill /f /t /im %%i
  if %errorLevel% == 0 (
    echo - %%i>>%log%
    echo - %%i
    set /a k+=1
  ) else echo.taskkill /f /t /im %%i>>%reboot%
)
echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

>nul timeout /nobreak /t 3
exit