call design\logLogo.cmd

echo.[Dirs]>>%log%
for /f "delims=" %%i in (%deleteLevelPath%\dirs.db) do (
  if exist "%%i" (
    rd /s /q "%%i"
    if exist "%%i" (
      echo.rd /s /q "%%i">>%reboot%
    ) else (
      echo. - %%i>>%log%
      echo - %%i
      set /a k+=1
    )
  )
)
for /f "delims=" %%i in (%deleteLevelPath%\dirs-pf.db) do (
  if exist "%ProgramFiles%\%%i" (
    rd /s /q "%ProgramFiles%\%%i"
    if exist "%ProgramFiles%\%%i" (
      echo.rd /s /q "%ProgramFiles%\%%i">>%reboot%
    ) else (
      echo. - %ProgramFiles%\%%i>>%log%
      echo - %ProgramFiles%\%%i
      set /a k+=1
    )
  )
)
for /f "delims=" %%i in (%deleteLevelPath%\dirs-pf.db) do (
  if exist "%ProgramFiles(x86)%\%%i" (
    rd /s /q "%ProgramFiles(x86)%\%%i"
    if exist "%ProgramFiles(x86)%\%%i" (
      echo.rd /s /q "%ProgramFiles(x86)%\%%i">>%reboot%
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

%moduleSleep% 3
exit