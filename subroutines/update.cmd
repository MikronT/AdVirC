@echo off
chcp 65001>nul

%log_append_place% : [Update]

for /f "tokens=1,2,* delims=- " %%i in ("%*") do (
  >nul set %%i
  >nul set %%j
)







if "%key_check%" == "databases" (
  %module_wget% "%update_databases_version_url%" --output-document="%update_databases_version_output%"

  for /f "tokens=1-3 delims= " %%i in (%update_databases_version_output%) do (
    if /i "%%i" == "%setting_update_channel%" (
      for /f "tokens=1-8 delims=." %%l in ("%%j") do (
               if "%%l" NEQ "" if %%l GTR %databases_version_code_level1% ( echo.>temp\return_update_databases_available
        ) else if "%%m" NEQ "" if %%m GTR %databases_version_code_level2% ( echo.>temp\return_update_databases_available
        ) else if "%%n" NEQ "" if %%n GTR %databases_version_code_level3% ( echo.>temp\return_update_databases_available
        ) else if "%%o" NEQ "" if %%o GTR %databases_version_code_level4% ( echo.>temp\return_update_databases_available
        ) else if "%%p" NEQ "" if %%p GTR %databases_version_code_level5% ( echo.>temp\return_update_databases_available
        ) else if "%%q" NEQ "" if %%q GTR %databases_version_code_level6% ( echo.>temp\return_update_databases_available
        ) else if "%%r" NEQ "" if %%r GTR %databases_version_code_level7% ( echo.>temp\return_update_databases_available
        ) else if "%%s" NEQ "" if %%s GTR %databases_version_code_level8% ( echo.>temp\return_update_databases_available
        )
      )
    )
  )
)

if "%key_update%" == "databases" if exist temp\return_update_databases_available call subroutines\databases.cmd







if "%key_check%" == "program" (
  %module_wget% "%update_program_version_url%" --output-document="%update_program_version_output%"

  for /f "tokens=1-3 delims= " %%i in (%update_program_version_output%) do (
    if /i "%%i" == "%setting_update_channel%" (
      for /f "tokens=1-7 delims=." %%l in ("%%j") do (
               if "%%l" NEQ "" if %%l GTR %program_version_code_level1% ( echo.>temp\return_update_program_available
        ) else if "%%m" NEQ "" if %%m GTR %program_version_code_level2% ( echo.>temp\return_update_program_available
        ) else if "%%n" NEQ "" if %%n GTR %program_version_code_level3% ( echo.>temp\return_update_program_available
        ) else if "%%o" NEQ "" if %%o GTR %program_version_code_level4% ( echo.>temp\return_update_program_available
        ) else if "%%p" NEQ "" if %%p GTR %program_version_code_level5% ( echo.>temp\return_update_program_available
        ) else if "%%q" NEQ "" if %%q GTR %program_version_code_level6% ( echo.>temp\return_update_program_available
        ) else if "%%r" NEQ "" if %%r GTR %program_version_code_level7% ( echo.>temp\return_update_program_available
        )
      )
    )
  )
)

if "%key_update%" == "program" if exist temp\return_update_program_available (
  if exist "%temp%\%program_name%-Update" rd /s /q "%temp%\%program_name%-Update"
  md "%temp%\%program_name%-Update\update"

  %module_wget% "%update_program_url%" --output-document="%update_program_output%"

  copy /y "%~dpnx0"                 "%temp%\%program_name%-Update\updater.cmd"
  copy /y "%update_program_output%" "%temp%\%program_name%-Update\update.zip"

  echo.>return_update
) else if exist update.zip (
  %module_unZip% -o update.zip -d update

  for /f "eol=# delims=" %%i in (%key_target%\files\fileList.db) do if exist "%key_target%\%%i" if "%%i" NEQ "files\filelist.db" del /q "%key_target%\%%i"
  del /q "%key_target%\files\filelist.db"

  for /f "delims=" %%i in ('dir /b "update"') do (
    copy /y "update\%%i" "%key_target%"
    rd /s /q "update\%%i">nul
    del /q "update\%%i">nul
  )

  start /wait "" "%key_target%\setupEnd.cmd"
  start "" "%key_target%\starter.cmd" --key_wait=3
  start cmd /c "timeout /nobreak /t 2 >nul && rd /s /q "%cd%""
  exit
)

set key_check=
set key_update=
exit