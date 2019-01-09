%logo%

if not exist files\databases\rewrited\dirs (
  echo.%lang-noVirusDataBasesError%
  %module-sleep% 3
  exit /b
)

set counter-foundObjects=0
set counter-deletedObjects=0







setlocal EnableDelayedExpansion
echo.[Scanning]>>%log%
for %%d in (services tasks processes registry temp folders files links extensions heuristic experimental) do start /wait subroutines\scanning\%%d.cmd







echo.[Deleting]>>%log%
for %%d in (services tasks processes registry temp folders files links extensions heuristic experimental) do (
  set temp-lang-cleaning=lang-cleaning%%d
  echo.!temp-lang-cleaning!
  start /wait subroutines\deleting\%%d.cmd
)
endlocal







for /f "delims=" %%i in (%filesToDelete%) do %module-moveFile% /accepteula "%%i" ""







%logo%
call echo.%lang-deletedObjects%

echo.Objects deleted: %counter-deletedObjects%.>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%
echo.========================================================================================================================>>%log%

%module-sleep% 3



echo.%lang-restartMessage01%
echo.%lang-restartMessage02%
echo.%lang-restartMessage03%
pause>nul

echo.%lang-restartMessage04%
%module-sleep% 5
echo.>temp\rebootNow
exit /b