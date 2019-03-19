call %*
exit /b







:input
if "%windowsVersionID%" == "1809" (
  set /p command=%inputBS%  %language_input%
) else set /p command=%inputBS%   %language_input%
exit /b







:loadingUpdate
if "%1" == "reset" (
  set counter_loading=0
) else (
  if "%1" == "stop" (
    set counter_loading=stop
  ) else set /a counter_loading+=%1
)

echo.%counter_loading%>temp\counter_loading
exit /b







:log_append_line
for /l %%z in (%2,-1,1) do echo.======================================================================================================================>>%1
exit /b







:log_append_place
if "%setting_logging%" == "true" (
  echo.[%*]>>%log%
  if "%setting_debug%" == "true" echo.[%*]>>%log_debug%
)
exit /b







:log_append_delimiter
for /l %%z in (7,-1,1) do echo.>>%1
for /l %%z in (3,-1,1) do echo.::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::>>%1
for /l %%z in (7,-1,1) do echo.>>%1
exit /b