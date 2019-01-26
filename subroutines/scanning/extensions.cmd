call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[File System]>>%log%
echo.   [AppData Extensions]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\folders\extensions.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_extensions%
      echo.    - %%i\%%j>>%log%
      echo.[Extension] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      echo.Extension not found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.[File System]>>%log%
echo.   [AppData Browsers Extensions]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\dirs\extensions.db) do (
    for /f "delims=" %%k in (files\databases\rewrited\folders\extensions.db) do (
      if exist "%%i\%%j\%%k" (
        echo.%%i\%%j\%%k>>%cleaning_extensions%
        echo.    - %%i\%%j\%%k>>%log%
        echo.[Extension] %%i\%%j\%%k
        set /a counter_foundObjects+=1
      ) else (
        echo.Extension not found - %%i\%%j\%%k>>%log_debug%
      )
      echo.!counter_foundObjects!>temp\counter_foundObjects
    )
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.[File System]>>%log%
echo.   [Program Files Extensions]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\folders\extensions.db) do (
    if exist "%%i\%%j" (
      echo.%%i\%%j>>%cleaning_extensions%
      echo.    - %%i\%%j>>%log%
      echo.[Extension] %%i\%%j
      set /a counter_foundObjects+=1
    ) else (
      echo.Extension not found - %%i\%%j>>%log_debug%
    )
    echo.!counter_foundObjects!>temp\counter_foundObjects
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

echo.[File System]>>%log%
echo.   [Program Files Browsers Extensions]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\programFiles.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\dirs\extensions.db) do (
    for /f "delims=" %%k in (files\databases\rewrited\folders\extensions.db) do (
      if exist "%%i\%%j\%%k" (
        echo.%%i\%%j\%%k>>%cleaning_extensions%
        echo.    - %%i\%%j\%%k>>%log%
        echo.[Extension] %%i\%%j\%%k
        set /a counter_foundObjects+=1
      ) else (
        echo.Extension not found - %%i\%%j\%%k>>%log_debug%
      )
      echo.!counter_foundObjects!>temp\counter_foundObjects
    )
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module_sleep% 3
exit