%logo%
for %%i in (%log% %log_debug%) do echo.[Databases]>>%%i
echo.%language_databases_updating%
echo.

for /f "tokens=1,* delims=- " %%i in ("%*") do set %%i







if "%key_import%" == "true" (
  set key_import=false
  copy /y "%location_desktop%\%appName%Databases v2.0.zip" temp>>%log_debug%
  %loadingUpdate% 25
  goto :unzip
)







%loadingUpdate% 10
echo.%language_databases_downloading%

%module_wget% "%update_databases_url%" --output-document=%update_databases_output%

for /f "skip=6 tokens=1,3,* delims= " %%i in ('dir %update_databases_output%') do if "%%i" == "1" set databases_lenghtReturn=%%j
if "%databases_lenghtReturn%" == "0" ( call :error %language_module_wget_error% & exit /b )

echo.%language_databases_downloading_success%
echo.
%module_sleep% 1
%loadingUpdate% 15







:unzip
%loadingUpdate% 4
echo.%language_databases_unpacking%

rd /s /q files\databases>nul 2>>%log_debug%

%module_sleep% 1
%loadingUpdate% 4

md files\databases\original>nul 2>>%log_debug%
%module_unZip% -o %update_databases_output% -d files\databases\original
if not exist files\databases\original\license.txt ( call :error %language_module_unZip_error% & exit /b )

%loadingUpdate% 4
%module_sleep% 1

del /q %update_databases_output%

echo.%language_databases_unpacking_success%
echo.
%loadingUpdate% 4







echo.%language_databases_rewriting%

for /f "delims=" %%i in ('dir /a:d /b files\databases\original') do md files\databases\rewrited\%%i>nul 2>>%log_debug%

(for /f "eol=# delims=" %%i in (files\databases\original\fileList.db) do for /f "delims=" %%j in (files\databases\original\%%i) do call echo.%%j>>files\databases\rewrited\%%i)>>%log_debug%
%loadingUpdate% 1



for /f "delims=" %%i in ('dir "%systemDrive%\Users" /a:d /b') do if exist "%systemDrive%\Users\%%i" echo.%systemDrive%\Users\%%i>>files\databases\rewrited\dirs\userProfile.db
%loadingUpdate% 1

for /f "delims=" %%i in (files\databases\rewrited\dirs\userProfile.db) do for %%j in (Local LocalLow Roaming) do if exist "%%i\AppData\%%j" echo.%%i\AppData\%%j>>files\databases\rewrited\dirs\appData.db
%loadingUpdate% 1

for /f "delims=" %%i in (files\databases\rewrited\dirs\userProfile.db) do if exist "%%i\Desktop" echo.%%i\Desktop>>files\databases\rewrited\dirs\browsersShortcuts.db
%loadingUpdate% 1

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar>>files\databases\rewrited\dirs\browsersShortcuts.db
%loadingUpdate% 1

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do (
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch" echo.%%i\Microsoft\Internet Explorer\Quick Launch>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\Start Menu" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\Start Menu>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Windows\SendTo" echo.%%i\Microsoft\Windows\SendTo>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Windows\Start Menu" echo.%%i\Microsoft\Windows\Start Menu>>files\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Windows\Start Menu\Programs" echo.%%i\Microsoft\Windows\Start Menu\Programs>>files\databases\rewrited\dirs\shortcuts.db
)
%loadingUpdate% 2

setlocal EnableDelayedExpansion
for /f "delims=" %%i in ('reg query HKU') do (
  set errorLevel=
  reg query %%i\Software\Classes>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i\Software\Classes>>files\databases\rewrited\dirs\classes.db

  set errorLevel=
  reg query %%i\Software\Classes\Software\Classes>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i\Software\Classes\Software\Classes>>files\databases\rewrited\dirs\classes.db

  set errorLevel=
  reg query %%i\Software\Software\Classes>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i\Software\Software\Classes>>files\databases\rewrited\dirs\classes.db


  set errorLevel=
  reg query %%i>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i>>files\databases\rewrited\dirs\keys.db

  set errorLevel=
  reg query %%i\Software>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i\Software>>files\databases\rewrited\dirs\keys.db

  set errorLevel=
  reg query %%i\Software\Classes>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i\Software\Classes>>files\databases\rewrited\dirs\keys.db
)
endlocal

echo.%language_databases_rewriting_success%
echo.
%loadingUpdate% 2







echo.%language_databases_updating_success%
%module_sleep% 1
exit /b







:error
echo.
echo.%language_databases_update_error%
echo.  %*
%module_sleep% 3
exit /b