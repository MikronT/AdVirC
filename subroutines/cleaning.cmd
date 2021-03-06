@%logo%
%log_append_place% : [Cleaning]

for /f "tokens=1,* delims=- " %%i in ("%*") do if "%%i" NEQ "" set key_%%i

if not exist %dataDir%\databases\rewrited\dirs\temp.db if "%key_auto%" == "true" (
  if exist "%location_desktop%\%program_name%Databases v2.0.zip" (
         call subroutines\main.cmd :databases_update --import=true
  ) else call subroutines\main.cmd :databases_update
  %loadingUpdate% reset
) else (
  echo.%language_databases_notExist_error%
  %module_sleep% 1
  exit /b
)

start /min powershell "Exit"

set counter_foundObjects=0
set counter_deletedObjects=0

if not exist temp\cleaning md temp\cleaning

if not exist %dataDir%\backups\registry_%currentDate%.reg (
  echo.Windows Registry Editor Version 5.00>%dataDir%\backups\registry_%currentDate%.reg
  echo.>>%dataDir%\backups\registry_%currentDate%.reg
)

for %%i in (temp\return_deletingCompleted temp\return_scanningCompleted %cleaning_filesToRemove% %cleaning_extensions% %cleaning_files% %cleaning_folders% %cleaning_processes% %cleaning_registry% %cleaning_services% %cleaning_shortcuts% %cleaning_tasks% %cleaning_temp%) do if exist "%%i" del /q "%%i"

echo.@echo off>%cleaning_rebootScript%
echo.chcp 65001>>%cleaning_rebootScript%

echo.^<?xml version="1.0" encoding="UTF-16"?^>>%cleaning_rebootScriptTask%
echo.^<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"^>>>%cleaning_rebootScriptTask%
echo.  ^<Triggers^>>>%cleaning_rebootScriptTask%
echo.    ^<LogonTrigger id="Trigger1"^>>>%cleaning_rebootScriptTask%
echo.      ^<Enabled^>true^</Enabled^>>>%cleaning_rebootScriptTask%
echo.    ^</LogonTrigger^>>>%cleaning_rebootScriptTask%
echo.  ^</Triggers^>>>%cleaning_rebootScriptTask%
echo.  ^<Principals^>>>%cleaning_rebootScriptTask%
echo.    ^<Principal id="Principal1"^>>>%cleaning_rebootScriptTask%
echo.      ^<LogonType^>InteractiveToken^</LogonType^>>>%cleaning_rebootScriptTask%
echo.      ^<RunLevel^>HighestAvailable^</RunLevel^>>>%cleaning_rebootScriptTask%
echo.    ^</Principal^>>>%cleaning_rebootScriptTask%
echo.  ^</Principals^>>>%cleaning_rebootScriptTask%
echo.  ^<Settings^>>>%cleaning_rebootScriptTask%
echo.    ^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>>>%cleaning_rebootScriptTask%
echo.    ^<DisallowStartIfOnBatteries^>false^</DisallowStartIfOnBatteries^>>>%cleaning_rebootScriptTask%
echo.    ^<StopIfGoingOnBatteries^>true^</StopIfGoingOnBatteries^>>>%cleaning_rebootScriptTask%
echo.    ^<AllowHardTerminate^>true^</AllowHardTerminate^>>>%cleaning_rebootScriptTask%
echo.    ^<StartWhenAvailable^>true^</StartWhenAvailable^>>>%cleaning_rebootScriptTask%
echo.    ^<RunOnlyIfNetworkAvailable^>false^</RunOnlyIfNetworkAvailable^>>>%cleaning_rebootScriptTask%
echo.    ^<IdleSettings^>>>%cleaning_rebootScriptTask%
echo.      ^<Duration^>PT10M^</Duration^>>>%cleaning_rebootScriptTask%
echo.      ^<WaitTimeout^>PT1H^</WaitTimeout^>>>%cleaning_rebootScriptTask%
echo.      ^<StopOnIdleEnd^>true^</StopOnIdleEnd^>>>%cleaning_rebootScriptTask%
echo.      ^<RestartOnIdle^>false^</RestartOnIdle^>>>%cleaning_rebootScriptTask%
echo.    ^</IdleSettings^>>>%cleaning_rebootScriptTask%
echo.    ^<AllowStartOnDemand^>true^</AllowStartOnDemand^>>>%cleaning_rebootScriptTask%
echo.    ^<Enabled^>true^</Enabled^>>>%cleaning_rebootScriptTask%
echo.    ^<Hidden^>false^</Hidden^>>>%cleaning_rebootScriptTask%
echo.    ^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>>>%cleaning_rebootScriptTask%
echo.    ^<WakeToRun^>false^</WakeToRun^>>>%cleaning_rebootScriptTask%
echo.    ^<ExecutionTimeLimit^>PT72H^</ExecutionTimeLimit^>>>%cleaning_rebootScriptTask%
echo.    ^<Priority^>1^</Priority^>>>%cleaning_rebootScriptTask%
echo.  ^</Settings^>>>%cleaning_rebootScriptTask%
echo.  ^<Actions Context="Principal1"^>>>%cleaning_rebootScriptTask%
echo.    ^<Exec^>>>%cleaning_rebootScriptTask%
echo.      ^<Command^>%winDir%\System32\cmd.exe^</Command^>>>%cleaning_rebootScriptTask%
echo.      ^<Arguments^>/c "%temp%\%program_name%RebootScript.cmd"^</Arguments^>>>%cleaning_rebootScriptTask%
echo.    ^</Exec^>>>%cleaning_rebootScriptTask%
echo.  ^</Actions^>>>%cleaning_rebootScriptTask%
echo.^</Task^>>>%cleaning_rebootScriptTask%

%loadingUpdate% 1









start subroutines\cleaning\scanning.cmd



:scanning_cycle
%logo%
call echo.%language_cleaning_foundObjects%

set counter_foundObjects_last=%counter_foundObjects%
goto :scanning_checkEngine



:scanning_checkEngine
%module_sleep% 1

(for /f "delims=" %%i in (temp\counter_foundObjects) do set counter_foundObjects=%%i)>nul 2>nul

if exist temp\return_scanningCompleted goto :exceptions
if "%counter_foundObjects%" NEQ "%counter_foundObjects_last%" goto :scanning_cycle
goto :scanning_checkEngine









:exceptions
%loadingUpdate% 1 force

if "%counter_foundObjects%" == "0" (
  %loadingUpdate% 1
  goto :deleting
)

echo.
echo.%language_cleaning_exceptionsRewriting%

if exist %dataDir%\settings\exceptions.db for %%i in (%cleaning_extensions% %cleaning_files% %cleaning_folders% %cleaning_processes% %cleaning_registry% %cleaning_services% %cleaning_shortcuts% %cleaning_tasks% %cleaning_temp%) do if exist "%%i" (
  for /f "eol=# delims=" %%j in (%dataDir%\settings\exceptions.db) do (
    copy /y %%i %%i.old>>%log_debug%
    del /q %%i

    for /f "eol=- delims=" %%k in ('find /i /v "%%j" %%i.old') do echo.%%k>>%%i

    del /q %%i.old
  )
)

%loadingUpdate% 1
if "%key_auto%" == "true" goto :deleting









:cleaning_actions
%log_append_place% :   [Cleaning Actions]
%input_clear%
%logo%
call echo.%language_cleaning_foundObjects%
echo.
echo.%language_cleaning_actions01%
call echo.%language_cleaning_actions02%
echo.%language_cleaning_actions03%
echo.
echo.%language_back%
echo.
echo.
echo.
%input%



if "%command%" == "0" ( %input_clear% & exit /b )
if "%command%" == "1" (
  %logo%
  echo.%language_cleaning_actions04%
  echo.%language_cleaning_actions05%
  pause>nul

  for %%i in (%cleaning_extensions% %cleaning_files% %cleaning_folders% %cleaning_processes% %cleaning_registry% %cleaning_services% %cleaning_shortcuts% %cleaning_tasks%) do if exist "%%i" call start /wait notepad "%cd%\%%i"
  goto :cleaning_actions
)
if "%command%" == "2" goto :deleting
goto :cleaning_actions









:deleting
%loadingUpdate% 2

start subroutines\cleaning\deleting.cmd



:deleting_cycle
%logo%
if "%counter_foundObjects%" NEQ "0" (
  call echo.%language_cleaning_foundObjects%
  call echo.%language_cleaning_deletedObjects%
)

set counter_deletedObjects_last=%counter_deletedObjects%
goto :deleting_checkEngine



:deleting_checkEngine
%module_sleep% 1

(for /f "delims=" %%i in (temp\counter_deletedObjects) do set counter_deletedObjects=%%i)>nul 2>nul

if exist temp\return_deletingCompleted goto :rules
if "%counter_deletedObjects%" NEQ "%counter_deletedObjects_last%" goto :deleting_cycle
goto :deleting_checkEngine









:rules
%loadingUpdate% 1 force

if "%setting_cleaningRule_experimental%" == "true" (     start /wait subroutines\cleaning\rules.cmd
) else if "%setting_cleaningRule_heuristic%" == "true" ( start /wait subroutines\cleaning\rules.cmd
) else %loadingUpdate% 2
%loadingUpdate% 3 force









for %%i in (%dataDir%\backups\registry_%currentDate%.reg) do if "%%~zi" == "40" del /q "%dataDir%\backups\registry_%currentDate%.reg"

if exist %cleaning_filesToRemove% for /f "eol=# delims=" %%i in (%cleaning_filesToRemove%) do %module_moveFile% "%%i" "">>%log_debug%
%loadingUpdate% 2



echo.del /q "%winDir%\System32\Tasks\%program_name% Reboot Script Task">>%cleaning_rebootScript%

copy /y %cleaning_rebootScript% "%temp%\%program_name%RebootScript.cmd">>%log_debug%

set errorLevel=
schtasks /create /tn "%program_name% Reboot Script Task" /xml temp\rebootScriptTask.xml /ru system /f>nul 2>nul
if "%errorLevel%" NEQ "0" if "%errorLevel%" NEQ "" echo.%language_cleaning_taskCreating_error%
%loadingUpdate% 3









%logo%
echo.Objects found:   %counter_foundObjects%>>%log%
echo.Objects deleted: %counter_deletedObjects%>>%log%

call echo.%language_cleaning_foundObjects%
call echo.%language_cleaning_deletedObjects%
%loadingUpdate% 1

if "%key_auto%" NEQ "true" (
  echo.%language_cleaning_reboot01%
  echo.%language_cleaning_reboot02%
  echo.%language_cleaning_reboot03%
  start /min powershell "Add-Type -AssemblyName System.Windows.Forms; $balloon = New-Object System.Windows.Forms.NotifyIcon; $path = (Get-Process -id $pid).Path; $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path); $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info; $balloon.BalloonTipText = '%language_cleaning_reboot_shellMsg_info_text%'; $balloon.BalloonTipTitle = """%language_cleaning_reboot_shellMsg_info_title%"""; $balloon.Visible = $true; $balloon.ShowBalloonTip(5000)"
  pause>nul

  echo.%language_cleaning_reboot04%
  %module_sleep% 5
) else (
  echo.%language_cleaning_reboot05%
  start /min powershell "Add-Type -AssemblyName System.Windows.Forms; $balloon = New-Object System.Windows.Forms.NotifyIcon; $path = (Get-Process -id $pid).Path; $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path); $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning; $balloon.BalloonTipText = '%language_cleaning_reboot_shellMsg_warning_text%'; $balloon.BalloonTipTitle = """%language_cleaning_reboot_shellMsg_warning_title%"""; $balloon.Visible = $true; $balloon.ShowBalloonTip(5000)"
  %module_sleep% 30
)

echo.>temp\return_reboot
exit /b