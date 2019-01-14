%logo%

if not exist files\databases\rewrited\dirs\temp.db (
  echo.%lang-noVirusDataBasesError%
  %module-sleep% 3
  exit /b
)

set order=services tasks processes registry     temp     folders files links extensions heuristic experimental
set foundObjects=0
set deletedObjects=0







echo.[Scanning]>>%log%
for %%d in (%order%) do start /wait subroutines\scanning\%%d.cmd







setlocal EnableDelayedExpansion
echo.[Deleting]>>%log%
for %%d in (%order%) do (
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