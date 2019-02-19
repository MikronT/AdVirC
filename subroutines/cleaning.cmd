%logo%

if not exist files\databases\rewrited\dirs\temp.db (
  echo.%language_databases_notExist_error%
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
setlocal EnableDelayedExpansion
for %%d in (services tasks processes registry temp folders files shortcuts extensions) do (
  set temp_editingFile=cleaning_%%d
  call start /wait notepad "%~dp0!!temp_editingFile!!"
)
endlocal



echo.[Cleaning]>>%log%
for %%d in (deleting experimental heuristic) do start /wait subroutines\cleaning\%%d.cmd



for /f "delims=" %%i in (%filesToRemove%) do %module_moveFile% "%%i" ""



set errorLevel=
schtasks /create /tn "AdVirC Reboot Script Task" /xml "files\rebootScriptTask.xml" /ru system /f
if "%errorLevel%" NEQ "0" echo.%language_cleaning_taskCreating_error%







%logo%
call echo.%language_cleaning_deletedObjects%

echo.Objects deleted: %counter_deletedObjects%.>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%
echo.========================================================================================================================>>%log%

%module_sleep% 3



echo.%language_cleaning_reboot01%
echo.%language_cleaning_reboot02%
echo.%language_cleaning_reboot03%
pause>nul

echo.%language_cleaning_reboot04%
%module_sleep% 5

echo.>temp\rebootNow
exit /b