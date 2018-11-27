call design\logLogo.cmd

echo.[Links]>>%log%
for /f "delims=" %%i in (files\databases\2-main\rewrited\linkDirs.db) do (
  for /f "delims=" %%j in (files\databases\2-main\rewrited\links.db) do (
    if exist "%%i\%%j" (
      del /q "%%i\%%j"
      if exist "%%i\%%j" (
        echo.del /q "%%i\%%j">>%reboot%
      ) else (
        echo. - %%i\%%j>>%log%
        echo - %%i\%%j
        set /a k+=1
      )
    )
  )
)

echo.[Links - Browser Shortcuts]>>%log%
set shortcutNameToken=1
:browserShortcutsCycle
for /f "tokens=1,2,3,4* delims=;" %%i in (files\databases\2-main\rewrited\browsersLinks.db) do (
  if exist "%%j" (
    if not exist "files\reports\shortcuts\%%i-%shortcutNameToken%.lnk" (
      copy "%%j" files\reports\shortcuts\%%i-%shortcutNameToken%.lnk /y
      del /q "%%j"
      %moduleShortcut% /f:"%%j" /t:"%%k" /a:c /i:"%%k" /w:"%%l"
      echo.Owerrided %%i>>%log%
    ) else (
      set /a shortcutNameToken+=1
      goto browserShortcutsCycle
    )
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

>nul timeout /nobreak /t 3
exit