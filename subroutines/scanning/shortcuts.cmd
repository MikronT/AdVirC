call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[File System]>>%log%
echo.   [Shortcuts]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\shortcuts.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\files\shortcuts.db) do (
    if exist "%%i\%%j" (
      echo.del /s /q "%%i\%%j">>%deleteScript%
      echo.    - %%i\%%j>>%log%
      echo.[Shortcut] %%i\%%j
      set /a foundObjects+=1
    ) else (
      echo.Shortcut not found - %%i\%%j>>%debugLog%
    )
    echo.%foundObjects%>temp\foundObjects
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.[File System]>>%log%
echo.   [Browsers Shortcuts]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\browsersShortcuts.db) do (
  for /f "tokens=1,2,3* delims=;" %%j in (files\databases\rewrited\files\browsersShortcuts.db) do (
    if exist "%%i\%%j.lnk" (
      if not exist "files\reports\shortcuts\%%j" md "files\reports\shortcuts\%%j"
      call :subroutine %%j
      copy "%%i\%%j.lnk" "files\reports\shortcuts\%%j\%%x.lnk" /y
      echo.del /s /q "%%i\%%j.lnk">>%deleteScript%
      echo.%module-shortcut% /a:c /f:"%%i\%%j.lnk" /t:"%%k" /i:"%%k" /w:"%%l">>%deleteScript%
      echo.    - %%i\%%j.lnk>>%log%
      echo.[Browser Shortcut] %%i\%%j.lnk ^(Overrided^)
    ) else (
      echo.Browser Shortcut not found - %%i\%%j.lnk>>%debugLog%
    )
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module-sleep% 3
exit





:subroutine
for /l %%x in (1,1,1000) do if not exist "files\reports\shortcuts\%*\%%x.lnk" exit /b
exit /b