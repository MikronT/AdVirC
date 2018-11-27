%logo%
if not exist files\databases\5-heuristic\rewrited (
  echo %lang-updateVirusDataBasesMessage%
  >nul timeout /nobreak /t 3
  exit /b
)

if %deleteLevel% GTR 1 goto :skipSuperficial



::Dirs-1-Superficial
set deleteLevelPath=files\databases\1-superficial\rewrited
echo %lang-dirsDeleting%
start /wait subroutines\deleting\dirs.cmd
>nul timeout /nobreak /t 1

::Files-1-Superficial
echo %lang-filesDeleting%
start /wait subroutines\deleting\files.cmd
>nul timeout /nobreak /t 1
goto end



:skipSuperficial
if %deleteLevel% LSS 4 goto :skipFull



::Services-4-Full
echo %lang-servicesDeleting%
start /wait subroutines\deleting\services.cmd
>nul timeout /nobreak /t 1

::Processes-4-Full
echo %lang-processesDeleting%
start /wait subroutines\deleting\processes.cmd
>nul timeout /nobreak /t 1



:skipFull



::Dirs-2-Main
set deleteLevelPath=files\databases\2-main\rewrited
echo %lang-dirsDeleting%
start /wait subroutines\deleting\dirs.cmd
>nul timeout /nobreak /t 1

::Files-2-Main
echo %lang-filesDeleting%
start /wait subroutines\deleting\files.cmd
>nul timeout /nobreak /t 1


::Links-2-Main
echo %lang-linksDeleting%
start /wait subroutines\deleting\links.cmd
>nul timeout /nobreak /t 1

::Extensions-2-Main
echo %lang-extensionsDeleting%
start /wait subroutines\deleting\extensions.cmd
>nul timeout /nobreak /t 1



if %deleteLevel% LSS 3 goto :skipDeep



::Registry-3-Deep
echo %lang-registryDeleting%
start /wait subroutines\deleting\registry.cmd
>nul timeout /nobreak /t 1



:skipDeep
if %deleteLevel% LSS 4 goto :skipFull2



::Tasks-4-Full
echo %lang-tasksDeleting%
start /wait subroutines\deleting\tasks.cmd
>nul timeout /nobreak /t 1

::Temp-4-Full
echo %lang-tempDeleting%
start /wait subroutines\deleting\temp.cmd
>nul timeout /nobreak /t 1



:skipFull2
if %deleteLevel% LSS 5 goto :end



::Heuristic-5-Heuristic

::Experimental-5-Heuristic



:end
%logo%
call echo %lang-securityDangersDeletedMessage%
echo.Deleted security dangers: %k%.>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%
echo.========================================================================================================================>>%log%
>nul timeout /nobreak /t 3


echo %lang-restart1%
echo %lang-restart2%
echo %lang-restart3%
pause>nul

echo %lang-restart4%
reg import files\backups\registry\HKUConsoleCMD_Backup.reg
shutdown /l
start /wait "" %reboot%
shutdown /r /t 0
exit