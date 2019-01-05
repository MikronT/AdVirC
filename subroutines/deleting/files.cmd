call design\logLogo.cmd

echo.[Files]>>%log%
for /f "delims=" %%i in (%deleteLevelPath%\files.db) do (
  if exist "%%i" (
    del /q "%%i"
    if exist "%%i" (
      echo.del /q "%%i">>%reboot%
    ) else (
      echo. - %%i>>%log%
      echo - %%i
      set /a k+=1
    )
  )
)
for /f "delims=" %%i in (%deleteLevelPath%\files-pf.db) do (
  if exist "%ProgramFiles%\%%i" (
    del /q "%ProgramFiles%\%%i"
    if exist "%ProgramFiles%\%%i" (
      echo.del /q "%ProgramFiles%\%%i">>%reboot%
    ) else (
      echo. - %ProgramFiles%\%%i>>%log%
      echo - %ProgramFiles%\%%i
      set /a k+=1
    )
  )
)
for /f "delims=" %%i in (%deleteLevelPath%\files-pf.db) do (
  if exist "%ProgramFiles(x86)%\%%i" (
    del /q "%ProgramFiles(x86)%\%%i"
    if exist "%ProgramFiles(x86)%\%%i" (
      echo.del /q "%ProgramFiles(x86)%\%%i">>%reboot%
    ) else (
      echo. - %ProgramFiles(x86)%\%%i>>%log%
      echo - %ProgramFiles(x86)%\%%i
      set /a k+=1
    )
  )
)
echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

%module-sleep% 3
exit