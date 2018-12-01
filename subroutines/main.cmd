%logo%
echo.%lang-initialization%
%loadingUpdate% 3



set debugLog=nul
set importBasesBoolean=0
set importError=0
set k=0
set lang=lang
set loadingReset=call design\loadingReset.cmd
set log=nul
set moduleShortcut=subroutines\modules\shortcut.exe
set moduleUnZip=subroutines\modules\unzip.exe
set moduleWget=subroutines\modules\wget.exe
set reboot=temp\reboot.cmd



for /f "tokens=1,2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do set desktopLocation=%%k
for /f "tokens=1,2,* delims=." %%i in ("%date%") do set logDate=%%k.%%j.%%i



md files\logs>nul 2>nul
md files\reports\shortcuts>nul 2>nul
md preferences>nul 2>nul
%loadingUpdate% 5



for /f "delims=" %%i in (files\fileList.db) do if not exist "%%i" call echo.%%i>>files\reports\corruptedFilesList.db
for /f "delims=" %%i in (files\fileList.db) do if not exist "%%i" goto :corrupted
%loadingUpdate% 2



if not exist preferences\debugLogging echo.true>preferences\debugLogging
if not exist preferences\logging echo.true>preferences\logging



for /f "delims=" %%i in (preferences\debugLogging) do if "%%i" == "true" set debugLog="files\logs\AdVirC_debugLog_%logDate%.log"
for /f "delims=" %%i in (preferences\logging) do if "%%i" == "true" set log="files\logs\AdVirC_log_%logDate%.log"
%loadingUpdate% 4



if exist %log% (
  echo.======================================================================================================================>>%log%
  echo.======================================================================================================================>>%log%
  echo.======================================================================================================================>>%log%
)
echo.Log ^| %versionName% ^| %logDate%>>%log%
echo.>>%log%
echo.======================================================================================================================>>%log%



if exist %debugLog% (
  echo.======================================================================================================================>>%debugLog%
  echo.======================================================================================================================>>%debugLog%
  echo.======================================================================================================================>>%debugLog%
)
echo.Debug Log ^| %versionName% ^| %logDate%>>%debugLog%
echo.>>%debugLog%
echo.Operating System: %OS%>>%debugLog%
echo.Current Directory: %cd%>>%debugLog%
echo.Current File Directory: %~dp0>>%debugLog%
echo.User Profile Directory: %userProfile%>>%debugLog%
echo.Desktop Location: %desktopLocation%>>%debugLog%
echo.Processor Architecture: %PROCESSOR_ARCHITECTURE%>>%debugLog%
echo.>>%debugLog%
echo.======================================================================================================================>>%debugLog%
echo.Running tasks:>>%debugLog%
echo.>>%debugLog%
tasklist>>%debugLog%
echo.>>%debugLog%
echo.======================================================================================================================>>%debugLog%



echo.@echo off>%reboot%
echo.chcp 65001>>%reboot%



%logo%
%loadingUpdate% 12



:language
if exist preferences\language (
  for /f "delims=" %%i in (preferences\language) do (
    if "%%i" == "english" ( set lang=0 ) else (
      if "%%i" == "russian" ( set lang=1 ) else (
        if "%%i" == "ukrainian" ( set lang=2 ) else call :languageMenu
      )
    )
    call :languageImport
  )
)
%loadingUpdate% 1





%logo%
echo.^(i^) %versionName%
echo.%lang-selectedLanguage%
echo.%lang-initializationRun%
%loadingUpdate% 1



if not exist files\reports\systemInfo.rpt systeminfo>files\reports\systemInfo.rpt
%loadingUpdate% 2



if not exist preferences\firstRun echo.true>preferences\firstRun
for /f "delims=" %%i in (preferences\firstRun) do if "%%i" == "true" (
  if exist "%AppData%\Mozilla\Firefox\Profiles" (
    echo.%%mozillaFirefoxUserProfile%%>temp\tempMozillaFirefoxUserProfile
    for /d %%x in (%AppData%\Mozilla\Firefox\Profiles\*) do for /f "tokens=1,2,3,4,5,6,7,8,9* delims=\" %%i in ("%%x") do call set mozillaFirefoxUserProfile=%%q
    for /f "delims=" %%i in (temp\tempMozillaFirefoxUserProfile) do call echo.%%i>files\reports\mozillaFirefoxUserProfile.rpt
    call echo.%lang-mozillaFirefoxUserProfile%
  )
  %loadingUpdate% 2

  echo.%lang-creatingRegistryBackup%
  REM reg export HKLM files\backups\registry\HKLM.reg>>%debug_log%
  %loadingUpdate% 3
  REM reg export HKCU files\backups\registry\HKCU.reg>>%debug_log%
  %loadingUpdate% 3
  REM reg export HKCR files\backups\registry\HKCR.reg>>%debug_log%
  %loadingUpdate% 3
  REM reg export HKU  files\backups\registry\HKU.reg >>%debug_log%
  %loadingUpdate% 3
  REM reg export HKCC files\backups\registry\HKCC.reg>>%debug_log%
  %loadingUpdate% 3
  echo.%lang-registryBackupCreated%

  echo.false>preferences\firstRun
) else (
  for /f "delims=" %%i in (files\reports\mozillaFirefoxUserProfile.rpt) do set mozillaFirefoxUserProfile=%%i
  %loadingUpdate% 17
)



echo.%%lastLoggedOnUserSID%%>temp\tempLastLoggedOnUserSID
for /f "tokens=2*" %%i in ('reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI /v LastLoggedOnUserSID') do set lastLoggedOnUserSID=%%j
for /f "delims=" %%i in (temp\tempLastLoggedOnUserSID) do call echo.%%i>files\reports\lastLoggedOnUserSID.rpt
call echo.%lang-lastLoggedOnUserSID%



call echo.%lang-processorArchitecture%
%loadingUpdate% 2



echo.>>%log%
echo.>>%log%
echo.>>%log%
%moduleSleep% 2
%loadingUpdate% 1
%moduleSleep% 1
goto :mainMenu







:languageMenu
%logo%
echo.^(!^) Select language:
echo. ║
echo.^(0^) English                                                   ^(1^) Русский
echo. ║                                                             ║
echo.^(2^) Українська                                                 ║
echo. ║                                                             ║
echo. ╠═════════════════════════════════════════════════════════════╝
echo. ║
set /p lang=^(^>^) Language number ^> 
exit /b





:languageImport
if %lang% == 0 (
  echo.english>preferences\language
  for /f "eol=# skip=10 delims=" %%i in (languages\english.lang) do set lang-%%i
  echo.Language: English>>%log%
) else (
  if %lang% == 1 (
    echo.russian>preferences\language
    for /f "eol=# skip=10 delims=" %%i in (languages\russian.lang) do set lang-%%i
    echo.Language: Russian>>%log%
    ) else (
      if %lang% == 2 (
        echo.ukrainian>preferences\language
        for /f "eol=# skip=10 delims=" %%i in (languages\ukrainian.lang) do set lang-%%i
        echo.Language: Ukrainian>>%log%
      ) else goto language
    )
  )
)
exit /b





:mainMenu
%loadingReset%
set command=command
%logo%
echo.%lang-mainMenu1%
echo. ║                                                             ║
echo.%lang-mainMenu2%
echo. ║                                                             ║
echo.%lang-mainMenu3%
echo. ║                                                             ║
echo. ╠═════════════════════════════════════════════════════════════╝
echo. ║
if not exist preferences\firstRunMenuNotification echo.true>preferences\firstRunMenuNotification
for /f "delims=" %%i in (preferences\firstRunMenuNotification) do if "%%i" == "true" (
  echo.%lang-firstRunMenuNotification1%
  echo.%lang-firstRunMenuNotification2%
  echo.%lang-firstRunMenuNotification3%
  echo.%lang-firstRunMenuNotification4%
  echo. ║
  echo. ║
  echo. ║
  echo.false>preferences\firstRunMenuNotification
)
set /p command=%lang-enterCommand% 


%logo%
if "%command%" == "0" call :exit
if "%command%" == "1" call :deleteMenu
if "%command%" == "2" call subroutines\databasesUpdate.cmd
if "%command%" == "3" call :importMenu
if "%command%" == "4" echo.>nul
if "%command%" == "5" call uninstall.cmd
goto :mainMenu





:importMenu
set command=command
%logo%
echo.%lang-importMenu1%
echo. ║
echo.%lang-importMenu2%
echo. ║                                                             ║
echo. ╠═════════════════════════════════════════════════════════════╝
echo. ║
if %importError% == 1 (
  color c
  set importError=0
  echo.%lang-importError%
  echo. ║
  echo. ║
  echo. ║
)
set /p command=%lang-enterCommand% 


%logo%
if "%command%" == "0" exit /b
if "%command%" == "1" goto :importMenuCommand
goto :importMenu


:importMenuCommand
if not exist C:\avcDatabases.zip (
  set importError=1
  goto :importMenu
)
%loadingUpdate% 10
set importBasesBoolean=1
call subroutines\databasesUpdate.cmd
exit /b





:deleteMenu
set command=command
%logo%
echo.%lang-selectDeleteMode%
echo.%lang-deleteMenu01%
echo.%lang-deleteMenu02%
echo.%lang-deleteMenu03%
echo.%lang-deleteMenu04%
echo.%lang-deleteMenu05%
echo.%lang-deleteMenu06%
echo.%lang-deleteMenu07%
echo.%lang-deleteMenu08%
echo.%lang-deleteMenu09%
echo.%lang-deleteMenu10%
echo.%lang-deleteMenu11%
echo.%lang-deleteMenu12%
echo.%lang-deleteMenu13%
echo.%lang-deleteMenu14%
echo.%lang-deleteMenu15%
echo.%lang-deleteMenu16%
echo.%lang-deleteMenu17%
echo.%lang-deleteMenu18%
echo.%lang-deleteMenu19%
echo.%lang-deleteMenu20%
echo.%lang-deleteMenu21%
echo. ║
set /p command=%lang-enterCommand% 


%logo%
if "%command%" == "0" exit /b
if "%command%" == "1" goto :deleteMenuCommand
if "%command%" == "2" goto :deleteMenuCommand
if "%command%" == "3" goto :deleteMenuCommand
if "%command%" == "4" goto :deleteMenuCommand
if "%command%" == "5" goto :deleteMenuCommand
goto :deleteMenu


:deleteMenuCommand
set deleteLevel=%command%
call subroutines\deleteInterface.cmd
exit /b





:corrupted
%logo%
%loadingReset%
echo.Program Corrupted!>>%log%
echo.^(!^) AdVirC Diagnostics: 
echo.   Program Corrupted!
echo.^(!^) Files missing:
for /f "delims=" %%i in (files\reports\corruptedFilesList.db) do echo.    --^> %%i
echo.
echo.^(!^) Reinstall AdVirC!
pause>nul
exit





:exit
reg import files\backups\registry\HKUConsoleCMD_Backup.reg
taskkill /f /im cmd.exe /t
exit