%logo%
echo %lang-updatingDataBases%
echo.Updating virus databases>>%log%



if %importBasesBoolean% == 1 (
  copy /y "C:\avcDatabases.zip" temp>>%debugLog%
  set importBasesBoolean=0
  %loadingUpdate% 15
  goto :unzip
)



%loadingUpdate% 10
%moduleWget% --no-check-certificate --quiet --tries=1 --output-document=temp\avcDatabases.zip "https://drive.google.com/uc?export=download&id=1Q_cNXPk-PjybPLDTBpAylvjP_C_UbX_x"
>nul timeout /nobreak /t 1
%loadingUpdate% 15



:unzip
%loadingUpdate% 4
rd /s /q files\databases>nul 2>>%debugLog%
>nul timeout /nobreak /t 1
%loadingUpdate% 4
%moduleUnZip% -qq -o temp\avcDatabases.zip -d files
del /q temp\avcDatabases.zip
%loadingUpdate% 4
>nul timeout /nobreak /t 1
%loadingUpdate% 4
if not exist files\databases\5-heuristic goto :error



for /f "delims=" %%i in (files\databases\dbFolderList.db) do md files\databases\%%i\rewrited
(for /f "delims=" %%x in (files\databases\dbFolderList.db) do for /f "delims=" %%y in (files\databases\dbFileList.db) do if exist files\databases\%%x\%%y for /f "delims=" %%z in (files\databases\%%x\%%y) do call echo.%%z>>files\databases\%%x\rewrited\%%y)>>%debugLog%
%loadingUpdate% 4



if not exist files\databases\5-heuristic\rewrited goto :error
%loadingUpdate% 5
echo %lang-dataBasesUpdated%
>nul timeout /nobreak /t 3
exit /b



:error
%loadingReset%
echo %lang-dataBasesUpdateError%
>nul timeout /nobreak /t 3
exit /b