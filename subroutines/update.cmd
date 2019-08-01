@echo off
chcp 65001>nul

if "%key_target%" NEQ "" if "%key_target%" NEQ "4417" goto :program_update

for /f "tokens=1 delims=- " %%i in ("%*") do if "%%i" NEQ "" set key_%%i

%log_append_place% : [Update]







setlocal EnableDelayedExpansion
if "%key_check%" == "program" (
  %module_wget% "%update_program_version_url%" --output-document=%update_program_version_output%

  for /f "tokens=1-3 delims= " %%i in (%update_program_version_output%) do (
    if /i "%%i" == "%setting_update_channel%" (
      for /f "tokens=1-7 delims=." %%l in ("%%j") do (
        if "%%r" NEQ "" ( set update_program_version_number=%%l%%m%%n%%o%%p%%q%%r
        ) else set update_program_version_number=%%l%%m%%n%%o%%p%%q000

        for /f "delims=" %%z in ('%isLarger% !update_program_version_number! %program_version_number%') do if "%%z" == "true" echo.>temp\return_update_program_available
      )
    )
  )
)

if "%key_update%" == "program" if exist temp\return_update_program_available (
  if exist "%temp%\%program_name%-Update" rd /s /q "%temp%\%program_name%-Update"
  md "%temp%\%program_name%-Update\update"

  %module_wget% "!update_program_url_%setting_update_channel%!" --output-document=%update_program_output%

  copy /y "%~dpnx0"               "%temp%\%program_name%-Update">nul
  copy /y %update_program_output% "%temp%\%program_name%-Update\update.zip">nul

  echo.>temp\return_update
)







if "%key_check%" == "databases" (
  %module_wget% "%update_databases_version_url%" --output-document=%update_databases_version_output%

  for /f "tokens=1-3 delims= " %%i in (%update_databases_version_output%) do (
    if /i "%%i" == "%setting_update_channel%" (
      for /f "tokens=1-8 delims=." %%l in ("%%j") do (
        if "%%s" NEQ "" ( set update_databases_version_number=%%l%%m%%n%%o%%p%%q%%r%%s
        ) else set update_databases_version_number=%%l%%m%%n%%o%%p%%q%%r000

        for /f "delims=" %%z in ('%isLarger% !update_databases_version_number! %databases_version_number%') do if "%%z" == "true" echo.>temp\return_update_databases_available
      )
    )
  )
)
endlocal

if "%key_update%" == "databases" if exist temp\return_update_databases_available call subroutines\main.cmd :databases_update

set key_check=
set key_update=
exit







:program_update
pushd "%key_target%"
%module_unZip% -o "%~dp0update.zip" -d "%~dp0update"

pushd "%~dp0"
for /f "delims=" %%i in ('dir /a:d /b update') do if exist "%key_target%\%%i" rd /s /q "%key_target%\%%i"
for /f "delims=" %%i in ('dir /a:-d /b update') do if exist "%key_target%\%%i" del /q "%key_target%\%%i"

xcopy /t /e /y "update" "%key_target%"
for /f "eol=# delims=" %%i in (update\files\fileList.db) do copy /y "update\%%i" "%key_target%\%%i"

pushd "%key_target%"
set key_target=4417
start /wait cmd /c setupEnd.cmd
start starter.cmd --wait=1
exit