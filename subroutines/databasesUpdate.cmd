%logo%
echo.Updating virus databases>>%log%
echo.%lang-updatingDataBases%





if "%importReturnCode%" == "1" (
  set importReturnCode=0
  copy /y "%SystemDrive%:\avcDatabases.zip" temp>>%debugLog%
  %loadingUpdate% 25
  goto :unzip
)





%loadingUpdate% 10

%moduleWget% --no-check-certificate --quiet --tries=1 --output-document=temp\avcDatabases.zip "https://drive.google.com/uc?export=download&id=1Q_cNXPk-PjybPLDTBpAylvjP_C_UbX_x"
if not exist temp\avcDatabases.zip goto :error wgetDownloadError

%moduleSleep% 1
%loadingUpdate% 15





:unzip
%loadingUpdate% 4

rd /s /q files\databases>nul 2>>%debugLog%

%moduleSleep% 1
%loadingUpdate% 4

%moduleUnZip% -qq -o temp\avcDatabases.zip -d files
if not exist files\databases goto :error

%loadingUpdate% 4
%moduleSleep% 1

del /q temp\avcDatabases.zip

%loadingUpdate% 4





for /f "delims=" %%i in (files\databases\dbFolderList.db) do md files\databases\%%i\rewrited
%loadingUpdate% 1
(for /f "delims=" %%x in (files\databases\dbFolderList.db) do for /f "delims=" %%y in (files\databases\dbFileList.db) do if exist files\databases\%%x\%%y for /f "delims=" %%z in (files\databases\%%x\%%y) do call echo.%%z>>files\databases\%%x\rewrited\%%y)>>%debugLog%
%loadingUpdate% 3





%loadingUpdate% 5
echo.%lang-dataBasesUpdated%
%moduleSleep% 3
exit /b





:error
echo.%lang-dataBasesUpdateError%
%moduleSleep% 3
exit /b