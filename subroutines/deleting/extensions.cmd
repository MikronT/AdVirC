call design\logLogo.cmd

echo.[Extensions]>>%log%
for /f "delims=" %%i in (files\databases\2-main\rewrited\extensionsPaths.db) do (
  for /f "delims=" %%j in (files\databases\2-main\rewrited\extensionsIDs.db) do (
    if exist "%%i\%%j" (
      rd /s /q "%%i\%%j"
      del /q "%%i\%%j"
      if exist "%%i\%%j" (
        echo.rd /s /q "%%i\%%j">>%reboot%
        echo.del /q "%%i\%%j">>%reboot%
      ) else (
        echo. - %%i\%%j>>%log%
        echo - %%i\%%j
        set /a k+=1
      )
    )
  )
)
echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

%moduleSleep% 3
exit