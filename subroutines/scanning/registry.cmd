call design\logLogo.cmd
setlocal EnableDelayedExpansion

for %%i in (%log% %log_debug%) do (
  echo.[Registry]>>%%i
  echo.   [Classes]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\classes.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\registry\classes.db) do (
    set errorLevel=
    reg query "%%i\%%j">>%log_debug%
    if "!errorLevel!" == "0" (
      echo.%%i\%%j>>%cleaning_registry%
      echo.    - %%i\%%j>>%log%
      echo.[Class] %%i\%%j
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
  echo.[Registry]>>%%i
  echo.   [Keys]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\keys.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\registry\keys.db) do (
    set errorLevel=
    reg query "%%i\%%j">>%log_debug%
    if "!errorLevel!" == "0" (
      echo.%%i\%%j>>%cleaning_registry%
      echo.    - %%i\%%j>>%log%
      echo.[Key] %%i\%%j
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

endlocal
%module_sleep% 3
exit