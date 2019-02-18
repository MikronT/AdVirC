call design\logLogo.cmd
setlocal EnableDelayedExpansion

for %%i in (%log% %log_debug%) do (
  echo.[File System]>>%%i
  echo.   [Shortcuts]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\shortcuts.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\files\shortcuts.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_shortcuts%
      echo.    - %%i\%%j>>%log%
      echo.[Shortcut] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      echo.Not Found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
)

for %%i in (%log% %log_debug%) do (
  echo.[File System]>>%%i
  echo.   [Browsers Shortcuts]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\browsersShortcuts.db) do (
  for /f "tokens=1,2,3* delims=;" %%j in (files\databases\rewrited\files\browsersShortcuts.db) do (
    if exist "%%i\%%j.lnk" (
      md "files\reports\shortcuts\%%j">nul 2>nul
      del /s /q "%%i\%%j.lnk">>%deleteScript%
      %module_shortcut% /f:"%%i\%%j.lnk" /t:"%%k" /i:"%%k" /w:"%%l">>%deleteScript%
      echo.    - %%i\%%j.lnk>>%log%
      echo.[Browser Shortcut] %%i\%%j.lnk ^(Overrided^)
    ) else (
      echo.Not Found - %%i\%%j.lnk>>%log_debug%
    )
  )
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
)

endlocal
%module_sleep% 3
exit