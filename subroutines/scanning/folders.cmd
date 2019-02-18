call design\logLogo.cmd
setlocal EnableDelayedExpansion

for %%i in (%log% %log_debug%) do (
  echo.[File System]>>%%i
  echo.   [AppData Folders]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\folders\appData.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_folders%
      echo.    - %%i\%%j>>%log%
      echo.[Folder] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      echo.Not Found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
  echo.[File System]>>%%i
  echo.   [Program Folders]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\folders\programFiles.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_folders%
      echo.    - %%i\%%j>>%log%
      echo.[Folder] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      echo.Not Found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
  echo.[File System]>>%%i
  echo.   [System Drive Folders]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\folders\systemDrive.db) do (
  if exist "%systemDrive%\%%i" (
    echo.%systemDrive%\%%i>>%cleaning_folders%
    echo.    - %systemDrive%\%%i>>%log%
    echo.[Folder] %systemDrive%\%%i
    set /a counter_foundObjects+=1
  ) else (
    echo.Not Found - %systemDrive%\%%i>>%log_debug%
  )
  echo.!counter_foundObjects!>temp\counter_foundObjects
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
  echo.[File System]>>%%i
  echo.   [User Profile Folders]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\userProfile.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\folders\userProfile.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_folders%
      echo.    - %%i\%%j>>%log%
      echo.[Folder] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      echo.Not Found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
  echo.[File System]>>%%i
  echo.   [Windows Directory Folders]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\folders\winDir.db) do (
  if exist "%winDir%\%%i" (
    echo.%winDir%\%%i>>%cleaning_folders%
    echo.    - %winDir%\%%i>>%log%
    echo.[Folder] %winDir%\%%i
    set /a counter_foundObjects+=1
  ) else (
    echo.Not Found - %winDir%\%%i>>%log_debug%
  )
  echo.!counter_foundObjects!>temp\counter_foundObjects
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
)

endlocal
%module_sleep% 3
exit