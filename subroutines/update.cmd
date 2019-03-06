for %%i in (%log% %log_debug%) do echo.[Update]>>%%i

for /f "tokens=1,2,* delims=- " %%i in ("%*") do (
  set %%i
  set %%j
)







if "%key_check%" == "true" (
  set key_check=false

  if "%setting_update_databases_auto%" == "true" ( call :checkVersion databases ) else if "%setting_update_databases_remind%" == "true" call :checkVersion databases
  if "%setting_update_program_auto%" == "true"   ( call :checkVersion program   ) else if "%setting_update_program_remind%" == "true"   call :checkVersion program
)







if "%key_update%" == "true" (
  set key_update=false
)
exit /b









:checkVersion
if "%1" == "databases" (
  %module_wget% "%update_databases_versionUrl%" --output-document=%update_databasesVersion_output%
  for /f "delims=" %%i in (%update_databasesVersion_output%) do rem
)
if "%1" == "program" (
  %module_wget% "%update_program_versionUrl%"   --output-document=%update_programVersion_output%
  for /f "delims=" %%i in (%update_programVersion_output%) do rem
)
exit /b