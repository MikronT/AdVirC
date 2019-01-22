%logo%

if not exist files\databases\rewrited\dirs\temp.db (
  echo.%lang-noVirusDataBasesError%
  %module-sleep% 3
  exit /b
)

set foundObjects=0
set deletedObjects=0

echo.@echo off>%rebootScript%
echo.chcp 65001>>%rebootScript%

echo.>%filesToRemove%







echo.[Scanning]>>%log%
for %%d in (services tasks processes registry temp folders files shortcuts extensions) do start /wait subroutines\scanning\%%d.cmd



echo.[Cleaning]>>%log%
for %%d in (deleting experimental heuristic) do start /wait subroutines\cleaning\%%d.cmd



for /f "delims=" %%i in (%filesToRemove%) do %module-moveFile% "%%i" ""







%logo%
call echo.%lang-deletedObjects%

echo.Objects deleted: %deletedObjects%.>>%log%
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