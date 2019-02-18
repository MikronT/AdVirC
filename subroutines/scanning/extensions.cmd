call design\logLogo.cmd
setlocal EnableDelayedExpansion

for %%i in (%log% %log_debug%) do (
  echo.[File System]>>%%i
  echo.   [AppData Extensions]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\folders\extensions.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_extensions%
      echo.    - %%i\%%j>>%log%
      echo.[Extension] %%i\%%j
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
  echo.   [AppData Browsers Extensions]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\dirs\extensions.db) do (
    for /f "delims=" %%k in (files\databases\rewrited\folders\extensions.db) do (
      if exist "%%i\%%j\%%k" (
        echo.%%i\%%j\%%k>>%cleaning_extensions%
        echo.    - %%i\%%j\%%k>>%log%
        echo.[Extension] %%i\%%j\%%k
        set /a counter_foundObjects+=1
      ) else (
        echo.Not Found - %%i\%%j\%%k>>%log_debug%
      )
      echo.!counter_foundObjects!>temp\counter_foundObjects
    )
  )
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
  echo.[File System]>>%%i
  echo.   [Program Files Extensions]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\folders\extensions.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_extensions%
      echo.    - %%i\%%j>>%log%
      echo.[Extension] %%i\%%j
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
  echo.   [Program Files Browsers Extensions]>>%%i
)

for /f "delims=" %%i in (files\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\dirs\extensions.db) do (
    for /f "delims=" %%k in (files\databases\rewrited\folders\extensions.db) do (
      if exist "%%i\%%j\%%k" (
        echo.%%i\%%j\%%k>>%cleaning_extensions%
        echo.    - %%i\%%j\%%k>>%log%
        echo.[Extension] %%i\%%j\%%k
        set /a counter_foundObjects+=1
      ) else (
        echo.Not Found - %%i\%%j\%%k>>%log_debug%
      )
      echo.!counter_foundObjects!>temp\counter_foundObjects
    )
  )
)

for %%i in (%log% %log_debug%) do (
  echo.Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
)

endlocal
%module_sleep% 3
exit