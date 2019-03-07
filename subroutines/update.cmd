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
  for /f "delims=" %%i in (%update_databases_version_output%) do rem

  if "%key_update%" == "databases" rem
)







if "%key_check%" == "program" (
  %module_wget% "%update_program_version_url%" --output-document=%update_program_version_output%
  for /f "delims=" %%i in (%update_program_version_output%) do rem

  if "%key_update%" == "program" rem
)
pause
exit /b