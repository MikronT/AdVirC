%logo%
if not exist files\databases (
  echo %lang-updateVirusDataBasesMessage%
  %moduleSleep% 3
  exit /b
)





if %deleteLevel% LSS 2 (
  set deleteLevelPath=files\databases\1-superficial\rewrited

  ::Dirs-1-Superficial
  echo %lang-dirsDeleting%
  start /wait subroutines\deleting\dirs.cmd
  %moduleSleep% 1

  ::Files-1-Superficial
  echo %lang-filesDeleting%
  start /wait subroutines\deleting\files.cmd
  %moduleSleep% 1
)



if %deleteLevel% GEQ 4 (
  ::Services-4-Full
  echo %lang-servicesDeleting%
  start /wait subroutines\deleting\services.cmd
  %moduleSleep% 1

  ::Processes-4-Full
  echo %lang-processesDeleting%
  start /wait subroutines\deleting\processes.cmd
  %moduleSleep% 1

  ::Tasks-4-Full
  echo %lang-tasksDeleting%
  start /wait subroutines\deleting\tasks.cmd
  %moduleSleep% 1
)



if %deleteLevel% GEQ 3 (
  ::Registry-3-Deep
  echo %lang-registryDeleting%
  start /wait subroutines\deleting\registry.cmd
  %moduleSleep% 1
)



if %deleteLevel% GEQ 4 (
  ::Temp-4-Full
  echo %lang-tempDeleting%
  start /wait subroutines\deleting\temp.cmd
  %moduleSleep% 1
)



if %deleteLevel% GEQ 2 (
  set deleteLevelPath=files\databases\2-main\rewrited

  ::Dirs-2-Main
  echo %lang-dirsDeleting%
  start /wait subroutines\deleting\dirs.cmd
  %moduleSleep% 1

  ::Files-2-Main
  echo %lang-filesDeleting%
  start /wait subroutines\deleting\files.cmd
  %moduleSleep% 1

  ::Links-2-Main
  echo %lang-linksDeleting%
  start /wait subroutines\deleting\links.cmd
  %moduleSleep% 1

  ::Extensions-2-Main
  echo %lang-extensionsDeleting%
  start /wait subroutines\deleting\extensions.cmd
  %moduleSleep% 1
)



if %deleteLevel% GEQ 5 (
  ::Heuristic-5-Heuristic
  rem echo %lang-applyingHeuristicRules%

  ::Experimental-5-Heuristic
  rem echo %lang-applyingExperimentalRules%
)





copy /y "%reboot%" "%Temp%\%appName%Reboot.cmd"
schtasks /create /tn %appName%Reboot /xml "files\rebootTask.xml" /f





%logo%
call echo %lang-securityDangersDeletedMessage%

echo.Deleted security dangers: %k%.>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%
echo.========================================================================================================================>>%log%

%moduleSleep% 3



echo %lang-restart1%
echo %lang-restart2%
echo %lang-restart3%
pause>nul

echo %lang-restart4%

reg import files\backups\registry\HKUConsoleCMD_Backup.reg
shutdown /r /t 1
taskkill /f /im cmd.exe /t
exit