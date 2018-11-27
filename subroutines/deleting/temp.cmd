call design\logLogo.cmd

echo.[Temp]>>%log%
for /f "delims=" %%i in (files\databases\4-full\rewrited\temp.db) do (
  dir %%i /a:d /b>>temp\tempCurrentDirs.db
  dir %%i /a:-d /b>>temp\tempCurrentFiles.db
  
  for /f "delims=" %%d in (temp\tempCurrentDirs.db) do (rd /s /q "%%i\%%d")
  for /f "delims=" %%f in (temp\tempCurrentFiles.db) do (del /q "%%i\%%d")
  
  del /s /q temp\tempCurrentDirs.db
  del /s /q temp\tempCurrentFiles.db
  
  REM Working Model: rd /s /q "%%i"
)
echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

>nul timeout /nobreak /t 3
exit