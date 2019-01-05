call design\logLogo.cmd

echo.[Registry]>>%log%
for /f "delims=" %%i in (files\databases\3-deep\rewrited\registry.db) do (
  set errorLevel=
  reg delete %%i /f>>%log%
  if %errorLevel% == 0 (
    echo. - %%i>>%log%
    echo. - %%i
    set /a k+=1
  ) else echo.reg delete %%i /f>>%reboot%
)
echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

%module-sleep% 3
exit