@echo off
chcp 65001>nul

for %%i in (%log% %log_debug%) do echo.[Update]>>%%i

set key_check=
set key_update=

for /f "tokens=1,2,* delims=- " %%i in ("%*") do (
  set %%i
  set %%j
)







if "%key_check%" == "databases" (
  %module_wget% "%update_databases_version_url%" --output-document=%update_databases_version_output%

  for /f "tokens=1-3 delims= " %%i in (%update_databases_version_output%) do (
    if /i "%%i" == "%setting_update_channel%" (
      for /f "tokens=1-8 delims=." %%l in ("%%j") do (
        rem echo.%%l--%%m--%%n--%%o--%%p--%%q--%%r--%%s
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

  if "%key_update%" == "databases" rem
)







if "%key_check%" == "program" (
  %module_wget% "%update_program_version_url%" --output-document=%update_program_version_output%

  for /f "delims=" %%i in (%update_program_version_output%) do (
    if /i "%%i" == "%setting_update_channel%" (
      for /f "tokens=1-7 delims=." %%l in ("%%j") do (
        rem echo.%%l--%%m--%%n--%%o--%%p--%%q--%%r
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

  if "%key_update%" == "program" rem
)
pause
exit