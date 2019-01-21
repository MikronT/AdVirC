call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[File System]>>%log%
echo.   [AppData Extensions]>>%log%

for /f "delims=" %%i in (files\databases\rewrited\dirs\appData.db) do (
  for /f "delims=" %%j in (files\databases\rewrited\folders\extensions.db) do (
    if exist "%%i\%%j" (
      echo.[Extension] %%i\%%j>>%deleteScript%
      echo.    - %%i\%%j>>%log%
      echo.[Extension] %%i\%%j
      set /a foundObjects+=1
    ) else (
      echo.Extension not found - %%i\%%j>>%debugLog%
    )
    echo.!foundObjects!>temp\foundObjects
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
        echo.[Extension] %%i\%%j\%%k>>%deleteScript%
        echo.    - %%i\%%j\%%k>>%log%
        echo.[Extension] %%i\%%j\%%k
        set /a foundObjects+=1
      ) else (
        echo.Extension not found - %%i\%%j\%%k>>%debugLog%
      )
      echo.!foundObjects!>temp\foundObjects
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
      echo.[Extension] %%i\%%j>>%deleteScript%
      echo.    - %%i\%%j>>%log%
      echo.[Extension] %%i\%%j
      set /a foundObjects+=1
    ) else (
      echo.Extension not found - %%i\%%j>>%debugLog%
    )
    echo.!foundObjects!>temp\foundObjects
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
        echo.[Extension] %%i\%%j\%%k>>%deleteScript%
        echo.    - %%i\%%j\%%k>>%log%
        echo.[Extension] %%i\%%j\%%k
        set /a foundObjects+=1
      ) else (
        echo.Extension not found - %%i\%%j\%%k>>%debugLog%
      )
      echo.!foundObjects!>temp\foundObjects
    )
  )
)

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module-sleep% 3
exit