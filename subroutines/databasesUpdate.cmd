%logo%
echo.Updating virus databases>>%log%
echo.%lang-updatingDataBases%







if "%importReturnCode%" == "1" (
  set importReturnCode=0
  copy /y "%desktopLocation%\adVirCDatabases.zip" temp>>%debugLog%
  %loadingUpdate% 25
  goto :unzip
)







%loadingUpdate% 10

%module-wget% --quiet --show-progress --progress=bar:force:noscroll --no-check-certificate --tries=1 "https://drive.google.com/uc?export=download&id=1Q_cNXPk-PjybPLDTBpAylvjP_C_UbX_x" --output-document=temp\adVirCDatabases.zip
if not exist temp\adVirCDatabases.zip goto :error %lang-wgetError%

%module-sleep% 1
%loadingUpdate% 15







:unzip
%loadingUpdate% 4

rd /s /q files\databases>nul 2>>%debugLog%

%module-sleep% 1
%loadingUpdate% 4

md files\databases\original>nul 2>>%debugLog%
%module-unZip% -qq -o temp\adVirCDatabases.zip -d files\databases\original
if not exist files\databases\original\license.txt goto :error %lang-unZipError%

%loadingUpdate% 4
%module-sleep% 1

del /q temp\adVirCDatabases.zip

%loadingUpdate% 4







for /f "delims=" %%i in ('dir /a:d /b files\databases\original') do md files\databases\rewrited\%%i>nul 2>>%debugLog%
%loadingUpdate% 1

(for /f "delims=" %%x in (files\databases\original\fileList.db) do for /f "delims=" %%y in (files\databases\original\%%x) do call echo.%%y>>files\databases\rewrited\%%x)>>%debugLog%
%loadingUpdate% 3







%loadingUpdate% 5
echo.%lang-dataBasesUpdated%
%module-sleep% 3
exit /b







:error
echo.%lang-dataBasesUpdateError%
echo.%*
%module-sleep% 3
exit /b