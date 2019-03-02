%logo%
for %%i in (%log% %log_debug%) do echo.[Cleaning]>>%%i

if not exist files\databases\rewrited\dirs\temp.db (
  echo.%language_databases_notExist_error%
  %module_sleep% 1
  exit /b
)

if not exist temp\cleaning md temp\cleaning>nul 2>nul

set counter_foundObjects=0
set counter_deletedObjects=0

for %%i in (%cleaning_filesToRemove% %cleaning_rebootScript% %cleaning_extensions% %cleaning_files% %cleaning_folders% %cleaning_processes% %cleaning_registry% %cleaning_services% %cleaning_shortcuts% %cleaning_tasks% %cleaning_temp%) do if exist "%%i" del /q "%%i"

echo.@echo off>%cleaning_rebootScript%
echo.chcp 65001>>%cleaning_rebootScript%







echo.[Scanning]>>%log%
start /wait subroutines\cleaning\scanning.cmd



echo.[Editing]>>%log%
for %%i in (%cleaning_extensions% %cleaning_files% %cleaning_folders% %cleaning_processes% %cleaning_registry% %cleaning_services% %cleaning_shortcuts% %cleaning_tasks% %cleaning_temp%) do if exist "%%i" call start /wait notepad "%cd%\%%i"



echo.[Cleaning]>>%log%
start /wait subroutines\cleaning\deleting.cmd
start /wait subroutines\cleaning\rules.cmd







for /f "delims=" %%i in (%cleaning_filesToRemove%) do %module_moveFile% "%%i" "">nul







set errorLevel=
schtasks /create /tn "AdVirC Reboot Script Task" /xml "files\rebootScriptTask.xml" /ru system /f
if "%errorLevel%" NEQ "0" echo.%language_cleaning_taskCreating_error%







%logo%
call echo.%language_cleaning_deletedObjects%

echo.Objects deleted: %counter_deletedObjects%.>>%log%
echo.Objects found: %counter_foundObjects%.>>%log_debug%

echo.%language_cleaning_reboot01%
echo.%language_cleaning_reboot02%
echo.%language_cleaning_reboot03%
pause>nul

echo.%language_cleaning_reboot04%
%module_sleep% 5

echo.>temp\return_rebootNow
exit /b