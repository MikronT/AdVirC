%logo%
if not exist files\databases (
  echo %lang-noVirusDataBasesError%
  %moduleSleep% 3
  exit /b
)
set k=0





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

  ::Tasks-4-Full
  echo %lang-tasksDeleting%
  start /wait subroutines\deleting\tasks.cmd
  %moduleSleep% 1

  ::Processes-4-Full
  echo %lang-processesDeleting%
  start /wait subroutines\deleting\processes.cmd
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





for /f "delims=" %%i in (%filesToDelete%) do %moduleMoveFile% /accepteula "%%i" ""

rem copy /y "%reboot%" "%Temp%\%appName%Reboot.cmd"
rem schtasks /create /tn %appName%Reboot /xml "files\rebootTask.xml" /f





%logo%
call echo %lang-securityDangersDeletedMessage%

echo.Deleted security dangers: %k%.>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%
echo.========================================================================================================================>>%log%

%moduleSleep% 3



echo %lang-restartMessage01%
echo %lang-restartMessage02%
echo %lang-restartMessage03%
pause>nul

echo %lang-restartMessage04%
%moduleSleep% 5
echo.>temp\rebootNow
exit /b