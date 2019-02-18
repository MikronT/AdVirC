call design\logLogo.cmd
setlocal EnableDelayedExpansion

for %%i in (%log% %log_debug%) do (
  echo.[File System]>>%%i
  echo.   [AppData Files]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\files\appData.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_files%
      echo.    - %%i\%%j>>%log%
      echo.[File] %%i\%%j
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
)

for %%i in (%log% %log_debug%) do (
  echo.[File System]>>%%i
  echo.   [Program Files]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\files\programFiles.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_files%
      echo.    - %%i\%%j>>%log%
      echo.[File] %%i\%%j
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
)

for %%i in (%log% %log_debug%) do (
  echo.[File System]>>%%i
  echo.   [System Drive Files]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\files\systemDrive.db) do (
  if exist "%systemDrive%\%%i" (
    echo.%systemDrive%\%%i>>%cleaning_files%
    echo.    - %systemDrive%\%%i>>%log%
    echo.[File] %systemDrive%\%%i
    set /a counter_foundObjects+=1
  ) else (
    echo.Not Found - %systemDrive%\%%i>>%log_debug%
  )
  echo.!counter_foundObjects!>temp\counter_foundObjects
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
)

for %%i in (%log% %log_debug%) do (
  echo.[File System]>>%%i
  echo.   [Windows Directory Files]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\files\winDir.db) do (
  if exist "%winDir%\%%i" (
    echo.%winDir%\%%i>>%cleaning_files%
    echo.    - %winDir%\%%i>>%log%
    echo.[File] %winDir%\%%i
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