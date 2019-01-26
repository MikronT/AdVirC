%logo%

if not exist files\databases\rewrited\dirs\temp.db (
  echo.%lang_noVirusDataBasesError%
  %module_sleep% 3
  exit /b
)

set counter_foundObjects=0
set counter_deletedObjects=0

echo.@echo off>%rebootScript%
echo.chcp 65001>>%rebootScript%

echo.>%filesToRemove%







echo.[Scanning]>>%log%
for %%d in (services tasks processes registry temp folders files shortcuts extensions) do start /wait subroutines\scanning\%%d.cmd



echo.[Editing]>>%log%
for %%d in (services tasks processes registry temp folders files shortcuts extensions) do start /wait notepad cleaning_%%d.db



echo.[Cleaning]>>%log%
for %%d in (deleting experimental heuristic) do start /wait subroutines\cleaning\%%d.cmd



for /f "delims=" %%i in (%filesToRemove%) do %module_moveFile% "%%i" ""



set errorLevel=
schtasks /create /tn "AdVirC Reboot Script Task" /xml "files\rebootScriptTask.xml" /ru system /f
if "%errorLevel%" NEQ "0" echo.%lang_taskCreatingError%







%logo%
call echo.%lang_counter_deletedObjects%

echo.Objects deleted: %counter_deletedObjects%.>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%
echo.========================================================================================================================>>%log%

%module_sleep% 3



echo.%lang_restartMessage01%
echo.%lang_restartMessage02%
echo.%lang_restartMessage03%
pause>nul

echo.%lang_restartMessage04%
%module_sleep% 5

echo.>temp\rebootNow
exit /b