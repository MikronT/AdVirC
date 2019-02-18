call design\logLogo.cmd
setlocal EnableDelayedExpansion

for %%i in (%log% %log_debug%) do (
  echo.[File System]>>%%i
  echo.   [Temp]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\temp.db) do (
  if exist "%%i" (
    echo.%%i>>%cleaning_temp%
    echo.    - %%i>>%log%
    echo.[Temp] %%i
    set /a counter_foundObjects+=1
  ) else (
    echo.Not Found - %%i>>%log_debug%
  )
  echo.!counter_foundObjects!>temp\counter_foundObjects
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
)

endlocal
%module_sleep% 3
exit