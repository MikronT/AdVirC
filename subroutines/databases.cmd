@%logo%
echo.%language_databases_updating%
echo.

%log_append_place% : [Databases]

for /f "tokens=1,2,* delims=- " %%i in ("%*") do (
  if "%%i" NEQ "" set %%i
  if "%%j" NEQ "" set %%j
)

if exist temp\return_update_databases_available del /q temp\return_update_databases_available







if "%key_import%" == "true" (
  set key_import=false
  copy /y "%location_desktop%\%program_name%Databases-%setting_update_channel%.zip" %update_databases_output%>>%log_debug%
  %loadingUpdate% 25
  goto :unzip
)







%loadingUpdate% 10
echo.%language_databases_downloading%

setlocal EnableDelayedExpansion
%module_wget% "!update_databases_url_%setting_update_channel%!" --output-document=%update_databases_output%
endlocal

for %%i in (%update_databases_output%) do if "%%~zi" == "0" ( call :error %language_module_wget_error% & exit /b 4417 )

echo.%language_databases_downloading_success%
echo.
%loadingUpdate% 15







:unzip
echo.%language_databases_unpacking%

rd /s /q %dataDir%\databases>nul 2>>%log_debug%

%module_sleep% 1
%loadingUpdate% 4

md %dataDir%\databases\original>nul 2>>%log_debug%
%module_unZip% -o %update_databases_output% -d %dataDir%\databases\original

if not exist %dataDir%\databases\original\license.txt ( call :error %language_module_unZip_error% & exit /b )

%loadingUpdate% 4

del /q %update_databases_output%

echo.%language_databases_unpacking_success%
echo.
%loadingUpdate% 2







echo.%language_databases_rewriting%

for /f "delims=" %%i in ('dir /a:d /b %dataDir%\databases\original') do md %dataDir%\databases\rewrited\%%i>nul 2>>%log_debug%

(for /f "eol=# delims=" %%i in (%dataDir%\databases\original\fileList.db) do for /f "eol=# delims=" %%j in (%dataDir%\databases\original\%%i) do call echo.%%j>>%dataDir%\databases\rewrited\%%i)>>%log_debug%
%loadingUpdate% 2



for /f "delims=" %%i in ('dir "%systemDrive%\Users" /a:d /b') do if exist "%systemDrive%\Users\%%i" echo.%systemDrive%\Users\%%i>>%dataDir%\databases\rewrited\dirs\userProfile.db
%loadingUpdate% 1

for /f "eol=# delims=" %%i in (%dataDir%\databases\rewrited\dirs\userProfile.db) do for %%j in (Local LocalLow Roaming) do if exist "%%i\AppData\%%j" echo.%%i\AppData\%%j>>%dataDir%\databases\rewrited\dirs\appData.db
%loadingUpdate% 1

for /f "eol=# delims=" %%i in (%dataDir%\databases\rewrited\dirs\userProfile.db) do if exist "%%i\Desktop" echo.%%i\Desktop>>%dataDir%\databases\rewrited\dirs\browsersShortcuts.db
%loadingUpdate% 1

for /f "eol=# delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar>>%dataDir%\databases\rewrited\dirs\browsersShortcuts.db
%loadingUpdate% 1

for /f "eol=# delims=" %%i in (%dataDir%\databases\rewrited\dirs\appData.db) do (
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch" echo.%%i\Microsoft\Internet Explorer\Quick Launch>>%dataDir%\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\Start Menu" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\Start Menu>>%dataDir%\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu>>%dataDir%\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" echo.%%i\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar>>%dataDir%\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Windows\SendTo" echo.%%i\Microsoft\Windows\SendTo>>%dataDir%\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Windows\Start Menu" echo.%%i\Microsoft\Windows\Start Menu>>%dataDir%\databases\rewrited\dirs\shortcuts.db
  if exist "%%i\Microsoft\Windows\Start Menu\Programs" echo.%%i\Microsoft\Windows\Start Menu\Programs>>%dataDir%\databases\rewrited\dirs\shortcuts.db
)
%loadingUpdate% 3

if exist "%appData%\Mozilla\Firefox\Profiles" for /f "delims=" %%i in ('dir "%appData%\Mozilla\Firefox\Profiles" /a:d /b') do (
  for /f "eol=# delims=" %%j in (%dataDir%\databases\original\files\appData-firefoxUserProfile.db)   do echo.Mozilla\Firefox\Profiles\%%i\%%j>>%dataDir%\databases\rewrited\files\appData.db
  for /f "eol=# delims=" %%j in (%dataDir%\databases\original\folders\appData-firefoxUserProfile.db) do echo.Mozilla\Firefox\Profiles\%%i\%%j>>%dataDir%\databases\rewrited\folders\appData.db
)
%loadingUpdate% 2

setlocal EnableDelayedExpansion
for /f "delims=" %%i in ('reg query HKU') do (
  set errorLevel=
  reg query %%i\Software\Classes>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i\Software\Classes>>%dataDir%\databases\rewrited\dirs\classes.db

  set errorLevel=
  reg query %%i\Software\Classes\Software\Classes>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i\Software\Classes\Software\Classes>>%dataDir%\databases\rewrited\dirs\classes.db

  set errorLevel=
  reg query %%i\Software\Software\Classes>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i\Software\Software\Classes>>%dataDir%\databases\rewrited\dirs\classes.db

  %loadingUpdate% 2

  set errorLevel=
  reg query %%i>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i>>%dataDir%\databases\rewrited\dirs\keys.db

  set errorLevel=
  reg query %%i\Software>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i\Software>>%dataDir%\databases\rewrited\dirs\keys.db

  set errorLevel=
  reg query %%i\Software\Classes>nul 2>>%log_debug%
  if "!errorLevel!" == "0" echo.%%i\Software\Classes>>%dataDir%\databases\rewrited\dirs\keys.db
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