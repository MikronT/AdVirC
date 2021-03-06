@call %*
exit /b







:input
if "%windowsVersionID%" NEQ "" (
  if %windowsVersionID% GEQ 1809 (
    set /p command=%input_backspace%  %language_input%
  ) else set /p command=%input_backspace%   %language_input%
) else set /p command=%input_backspace%   %language_input%
exit /b







:isLarger
set number1=%1
set number2=%2

setlocal EnableExtensions EnableDelayedExpansion

for /l %%a in (0,1,9) do (
  set number1=!number1:%%a=%%a !
  set number2=!number2:%%a=%%a !
)

for %%a in (!number1!) do set /a number1counter+=1 & set !number1counter!number1=%%a
for %%a in (!number2!) do set /a number2counter+=1 & set !number2counter!number2=%%a

if %number1counter% NEQ %number2counter% if %number1counter% GTR %number2counter% (
  echo.true
  exit /b
) else (
  echo.false
  exit /b
)

for /l %%a in (1,1,%number1counter%) do (
  if !%%anumber1! NEQ !%%anumber2! if !%%anumber1! GTR !%%anumber2! (
    echo.true
    exit /b
  ) else (
    echo.false
    exit /b
  )
)

echo.equal

endlocal
exit /b







:loadingUpdate
if "%1" == "reset" (
  set counter_loading=0
) else if "%1" == "stop" (
  set counter_loading=stop
) else if "%2" == "force" (
  (for /f "delims=" %%i in (temp\counter_loading) do set counter_loading=%%i)>nul 2>nul
  set /a counter_loading+=%1
) else set /a counter_loading+=%1

if not exist temp md temp
echo.%counter_loading%>temp\counter_loading
exit /b







:log_append_delimiter
for /l %%z in (7,-1,1) do echo.>>%1
for /l %%z in (3,-1,1) do echo.::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::>>%1
for /l %%z in (7,-1,1) do echo.>>%1
exit /b







:log_append_line
for /l %%z in (%2,-1,1) do echo.======================================================================================================================>>%1
exit /b







:log_append_place
set log_append_place_string=%*
set log_append_place_string=%log_append_place_string:~2%

if "%setting_logging%" == "true" (
  echo.%log_append_place_string%>>%log%
  if "%setting_debug%" == "true" echo.%log_append_place_string%>>%log_debug%
)
exit /b







:logo
@echo off
chcp 65001>nul
color %setting_appearance_theme%

if "%2" == "onlyLogo" ( call :logo_%1 & exit /b )

if "%1" == "main" (
  mode con:cols=124 lines=36
  title %program_version_name%
) else if "%1" == "log" (
  mode con:cols=70 lines=36
  title %program_name% ^| Log
)

cls

echo.
echo.
call :logo_%1
echo.
echo.
echo.
exit /b



:logo_main
echo.                        %setting_appearance_logo%%setting_appearance_logo%              %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%               %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% 
echo.   %setting_appearance_logo%%setting_appearance_logo%                  %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%     %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%     %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%
echo.     %setting_appearance_logo%%setting_appearance_logo%               %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%   %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%   %setting_appearance_logo%%setting_appearance_logo%      
echo.       %setting_appearance_logo%%setting_appearance_logo%            %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%   %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%     %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%   %setting_appearance_logo%%setting_appearance_logo%      
echo.     %setting_appearance_logo%%setting_appearance_logo%             %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%      %setting_appearance_logo%%setting_appearance_logo%     %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%
echo.   %setting_appearance_logo%%setting_appearance_logo%     ¬¬¬¬¬¬¬  %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%       %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%   %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% 
exit /b



:logo_log
echo.   %setting_appearance_logo%%setting_appearance_logo%         %setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%      %setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%   %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%      %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%   %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% 
echo.     %setting_appearance_logo%%setting_appearance_logo%      %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%      %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%      
echo.       %setting_appearance_logo%%setting_appearance_logo%   %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%         %setting_appearance_logo%%setting_appearance_logo%      %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%
echo.     %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%      %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%
echo.   %setting_appearance_logo%%setting_appearance_logo%     %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%    %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo% %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%       %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%  %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%   %setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo%%setting_appearance_logo% 
exit /b







:viewPager
call :viewPager_%*
exit /b



:viewPager_initiate
set counter_viewPager_page=1
set counter_viewPager_page_next=11

set viewPager_keyword=%command%
set viewPager_output=%1
set viewPager_fileList=%2
set viewPager_fileDir=%3

if "%viewPager_fileDir%" == "" (
  set viewPager_generate_addition=
  set viewPager_element=%%i
) else (
  set viewPager_generate_addition=for /f "eol=- delims=" %%j in ^('find /i "%viewPager_keyword%" %viewPager_fileDir%\%%i'^) do
  set viewPager_element=%%j
)
exit /b



:viewPager_generate
setlocal EnableDelayedExpansion
set counter_viewPager_element=0

for /f "eol=# delims=" %%i in (%viewPager_fileList%) do %viewPager_generate_addition% (
  set /a counter_viewPager_element+=1
  if !counter_viewPager_element! GEQ !counter_viewPager_page! if !counter_viewPager_element! LSS !counter_viewPager_page_next! (
    if !counter_viewPager_element! GEQ 1    if !counter_viewPager_element! LSS 10    echo.     !counter_viewPager_element!  %viewPager_element%
    if !counter_viewPager_element! GEQ 10   if !counter_viewPager_element! LSS 100   echo.    !counter_viewPager_element!  %viewPager_element%
    if !counter_viewPager_element! GEQ 100  if !counter_viewPager_element! LSS 1000  echo.   !counter_viewPager_element!  %viewPager_element%
    if !counter_viewPager_element! GEQ 1000 if !counter_viewPager_element! LSS 10000 echo.  !counter_viewPager_element!  %viewPager_element%
  )
)

if %counter_viewPager_element% LSS %counter_viewPager_page% exit /b 4417

set /a counter_viewPager_k=%counter_viewPager_element%-%counter_viewPager_page%

echo.
       if %counter_viewPager_element% LSS 11 ( rem
) else if %counter_viewPager_page%    ==   1 ( echo.%language_viewPager_control_next%
) else if %counter_viewPager_k%       LSS 10 ( echo.%language_viewPager_control_previous%
) else echo.%language_viewPager_control_previous% %language_viewPager_control_next%

if exist %viewPager_output%.old echo.%language_viewPager_control_undo%

echo.!counter_viewPager_element!>  temp\counter_viewPager_element
echo.!counter_viewPager_k!>        temp\counter_viewPager_k
echo.!counter_viewPager_page!>     temp\counter_viewPager_page
echo.!counter_viewPager_page_next!>temp\counter_viewPager_page_next

endlocal
exit /b



:viewPager_control
if "%command%" == "" exit /b

for %%i in (counter_viewPager_element counter_viewPager_k counter_viewPager_page counter_viewPager_page_next) do for /f "delims=" %%j in (temp\%%i) do set %%i=%%j

if %counter_viewPager_element% LSS 11 ( rem
) else if %counter_viewPager_page% == 1 (
  if /i "%command%" == "N" (
    set /a counter_viewPager_page+=10
    set /a counter_viewPager_page_next+=10
    exit /b
  )
) else if %counter_viewPager_k% LSS 10 (
  if /i "%command%" == "P" (
    set /a counter_viewPager_page-=10
    set /a counter_viewPager_page_next-=10
    exit /b
  )
) else (
  if /i "%command%" == "P" (
    set /a counter_viewPager_page-=10
    set /a counter_viewPager_page_next-=10
    exit /b
  )
  if /i "%command%" == "N" (
    set /a counter_viewPager_page+=10
    set /a counter_viewPager_page_next+=10
    exit /b
  )
)

if /i "%command%" == "U" if exist %viewPager_output%.old (
  copy /y %viewPager_output%.old %viewPager_output%>>%log_debug%
  del /q %viewPager_output%.old
  exit /b
)

setlocal EnableDelayedExpansion
set counter_viewPager_element=0

for /f "eol=# delims=" %%i in (%viewPager_fileList%) do %viewPager_generate_addition% (
  set /a counter_viewPager_element+=1
  if !counter_viewPager_element! GEQ !counter_viewPager_page! if !counter_viewPager_element! LSS !counter_viewPager_page_next! if "%command%" == "!counter_viewPager_element!" (
    if "%1" == "add"    (
      copy /y %viewPager_output% %viewPager_output%.old>>%log_debug%

      echo.%viewPager_element%>>%viewPager_output%
    )
    if "%1" == "remove" (
      set counter_viewPager_element_remove=0
      copy /y %viewPager_output% %viewPager_output%.old>>%log_debug%
      del /q %viewPager_output%

      for /f "delims=" %%j in (%viewPager_output%.old) do (
        set /a counter_viewPager_element_remove+=1
        if "!counter_viewPager_element!" NEQ "!counter_viewPager_element_remove!" echo.%%j>>%viewPager_output%
      )
    )
  )
)

endlocal
exit /b