call design\logLogo.cmd

echo.[Services]>>%log%
for /f "delims=" %%i in (files\databases\4-full\rewrited\services.db) do (
  set errorLevel=
  sc delete %%i>>%log%
  if %errorLevel% == 0 (
    echo. - %%i>>%log%
    echo. - %%i
    set /a k+=1
  ) else echo.sc delete %%i>>%reboot%
)
echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

%moduleSleep% 3
exit