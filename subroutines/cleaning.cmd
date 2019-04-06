@%logo%
%log_append_place% : [Cleaning]

if not exist %dataDir%\databases\rewrited\dirs\temp.db (
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







start subroutines\cleaning\scanning.cmd



:scanning_cycle
%logo%
call echo.%language_cleaning_foundObjects%

set counter_foundObjects_last=%counter_foundObjects%
goto :scanning_checkEngine



:scanning_checkEngine
(for /f "delims=" %%i in (temp\counter_foundObjects) do set counter_foundObjects=%%i)>nul 2>nul

if exist temp\return_scanningCompleted goto :editing
if "%counter_foundObjects%" NEQ "%counter_foundObjects_last%" goto :scanning_cycle

%module_sleep% 1
goto :scanning_checkEngine







:editing
%log_append_place% :   [Editing]
%input_clear%
%logo%
call echo.%language_cleaning_editing01%
echo.%language_cleaning_editing02%
echo.%language_cleaning_editing03%
echo.
echo.
echo.
%input%



if "%command%" == "1" (
  %logo%
  echo.%language_cleaning_editing04%
  echo.%language_cleaning_editing05%
  pause>nul

  for %%i in (%cleaning_extensions% %cleaning_files% %cleaning_folders% %cleaning_processes% %cleaning_registry% %cleaning_services% %cleaning_shortcuts% %cleaning_tasks% %cleaning_temp%) do if exist "%%i" call start /wait notepad "%cd%\%%i"
) else if "%command%" NEQ "2" goto :editing







:deleting
start subroutines\cleaning\deleting.cmd



:deleting_cycle
%logo%
call echo.%language_cleaning_foundObjects%
call echo.%language_cleaning_deletedObjects%

set counter_deletedObjects_last=%counter_deletedObjects%
goto :deleting_checkEngine



:deleting_checkEngine
(for /f "delims=" %%i in (temp\counter_deletedObjects) do set counter_deletedObjects=%%i)>nul 2>nul

if exist temp\return_deletingCompleted goto :rules
if "%counter_deletedObjects%" NEQ "%counter_deletedObjects_last%" goto :deleting_cycle

%module_sleep% 1
goto :deleting_checkEngine







:rules
start /wait subroutines\cleaning\rules.cmd







for /f "delims=" %%i in (%cleaning_filesToRemove%) do %module_moveFile% "%%i" "">>%log_debug%







copy /y "%cleaning_rebootScript%" "%temp%\%program_name%RebootScript.cmd">>%log_debug%

set errorLevel=
schtasks /create /tn "%program_name% Reboot Script Task" /xml "files\rebootScriptTask.xml" /ru system /f>nul 2>nul
if "%errorLevel%" NEQ "0" echo.%language_cleaning_taskCreating_error%







echo.Objects found: %counter_foundObjects%.>>%log%
echo.Objects deleted: %counter_deletedObjects%.>>%log%

echo.%language_cleaning_reboot01%
echo.%language_cleaning_reboot02%
echo.%language_cleaning_reboot03%
pause>nul

echo.%language_cleaning_reboot04%
%module_sleep% 5

echo.>temp\return_reboot
exit /b