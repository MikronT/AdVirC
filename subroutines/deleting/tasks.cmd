call design\logLogo.cmd

echo.[Tasks]>>%log%
for /f "delims=" %%i in (files\databases\4-full\rewrited\tasks.db) do (
  set errorLevel=
  schtasks /delete /tn %%i /f>>%log%
  if %errorLevel% == 0 (
    echo. - %%i>>%log%
    echo. - %%i
    set /a k+=1
  ) else echo.schtasks /delete /tn %%i /f>>%reboot%
)
echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

%moduleSleep% 3
exit