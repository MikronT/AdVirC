call design\logLogo.cmd
setlocal EnableDelayedExpansion

for %%i in (%log% %log_debug%) do (
  echo.[Processes]>>%%i
  echo.   [Tasks]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\processes\tasks.db) do (
  set errorLevel=
  schtasks /query /tn "%%i">>%log_debug%
  if "!errorLevel!" == "" call :subroutine %%i
  if "!errorLevel!" == "0" call :subroutine %%i
  if "!errorLevel!" NEQ "" if "!errorLevel!" NEQ "0" echo.Not Found - %%i>>%log_debug%
  echo.!counter_foundObjects!>temp\counter_foundObjects
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
)

endlocal
%module_sleep% 3
exit





:subroutine
echo.%*>>%cleaning_tasks%
echo.    - %*>>%log%
echo.[Task] %*
set /a counter_foundObjects+=1
exit /b