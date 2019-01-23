%logo%
echo.Updating virus databases>>%log%
echo.%lang-updatingDataBases%







if "%1" == "import" (
  copy /y "%desktopLocation%\adVirCDatabases.zip" temp>>%debugLog%
  %loadingUpdate% 25
  goto :unzip
)







%loadingUpdate% 10

%module-wget% "https://drive.google.com/uc?export=download&id=1Q_cNXPk-PjybPLDTBpAylvjP_C_UbX_x" --output-document=temp\adVirCDatabases.zip
if not exist temp\adVirCDatabases.zip goto :error %lang-wgetError%

%module-sleep% 1
%loadingUpdate% 15







:unzip
%loadingUpdate% 4

rd /s /q files\databases>nul 2>>%debugLog%

%module-sleep% 1
%loadingUpdate% 4

md files\databases\original>nul 2>>%debugLog%
%module-unZip% -o temp\adVirCDatabases.zip -d files\databases\original
if not exist files\databases\original\license.txt goto :error %lang-unZipError%

%loadingUpdate% 4
%module-sleep% 1

del /q temp\adVirCDatabases.zip

%loadingUpdate% 4







for /f "delims=" %%i in ('dir /a:d /b files\databases\original') do md files\databases\rewrited\%%i>nul 2>>%debugLog%

(for /f "eol=# delims=" %%i in (files\databases\original\fileList.db) do for /f "delims=" %%j in (files\databases\original\%%i) do call echo.%%j>>files\databases\rewrited\%%i)>>%debugLog%
%loadingUpdate% 1



for /f "delims=" %%i in ('dir "%systemDrive%\Users" /a:d /b') do if exist "%systemDrive%\Users\%%i" echo.%systemDrive%\Users\%%i>>files\databases\rewrited\dirs\userProfile.db

for /f "delims=" %%i in (files\databases\rewrited\dirs\userProfile.db) do for %%j in (Local LocalLow Roaming) do if exist "%%i\AppData\%%j" echo.%%i\AppData\%%j>>files\databases\rewrited\dirs\appData.db

for /f "delims=" %%i in (files\databases\rewrited\dirs\userProfile.db) do if exist "%%i\Desktop" echo.%%i\Desktop>>files\databases\rewrited\dirs\browsersShortcuts.db

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar>>files\databases\rewrited\dirs\browsersShortcuts.db

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do (
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch" echo.%%i\Microsoft\Internet Explorer\Quick Launch>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\Start Menu" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\Start Menu>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Windows\SendTo" echo.%%i\Microsoft\Windows\SendTo>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Windows\Start Menu" echo.%%i\Microsoft\Windows\Start Menu>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Windows\Start Menu\Programs" echo.%%i\Microsoft\Windows\Start Menu\Programs>>files\databases\rewrited\dirs\shortcuts.db
)

setlocal EnableDelayedExpansion
for /f "delims=" %%i in ('reg query HKU') do (
  set errorLevel=
  reg query HKU\%%i\Software\Classes>%debugLog%
  if "!errorLevel!" == "0" echo.HKU\%%i\Software\Classes>>files\databases\rewrited\dirs\classes.db
  set errorLevel=
  reg query HKU\%%i>%debugLog%
  if "!errorLevel!" == "0" echo.HKU\%%i>>files\databases\rewrited\dirs\keys.db
)
endlocal
%loadingUpdate% 5







%loadingUpdate% 3
echo.%lang-dataBasesUpdated%
%module-sleep% 3
exit /b







:error
echo.%lang-dataBasesUpdateError%
echo.%*
%module-sleep% 3
exit /b