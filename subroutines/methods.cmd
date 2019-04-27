@call %*
exit /b







:input
if "%windowsVersionID%" == "1809" (
  set /p command=%input_backspace%  %language_input%
) else set /p command=%input_backspace%   %language_input%
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
color 0b

if "%3" == "onlyLogo" ( call :logo_%1%2 & exit /b )

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
call :logo_%1%2
echo.
echo.
echo.
exit /b



:logo_main1
echo.                        ШШ              ШШШШ  ШШШШ               ШШШШШШ 
echo.   ШШ                  ШШШШ     ШШШШШ    ШШ    ШШ ШШШШ ШШШШ     ШШ    ШШ
echo.     ШШ               ШШ  ШШ    ШШ  ШШ    ШШ  ШШ   ШШ  ШШ  ШШ   ШШ      
echo.       ШШ            ШШШШШШШШ   ШШ  ШШ     ШШШШ    ШШ  ШШ  ШШ   ШШ      
echo.     ШШ             ШШШ    ШШШ  ШШ  ШШ      ШШ     ШШ  ШШШШШ    ШШ    ШШ
echo.   ШШ     ¬¬¬¬¬¬¬  ШШШШШ  ШШШШШ ШШШШ       ШШШШ   ШШШШ ШШ  ШШ    ШШШШШШ 
exit /b



:logo_main2
echo.                        ■■              ■■■■  ■■■■               ■■■■■■ 
echo.   ■■                  ■■■■     ■■■■■    ■■    ■■ ■■■■ ■■■■     ■■    ■■
echo.     ■■               ■■  ■■    ■■  ■■    ■■  ■■   ■■  ■■  ■■   ■■      
echo.       ■■            ■■■■■■■■   ■■  ■■     ■■■■    ■■  ■■  ■■   ■■      
echo.     ■■             ■■■    ■■■  ■■  ■■      ■■     ■■  ■■■■■    ■■    ■■
echo.   ■■     ¬¬¬¬¬¬¬  ■■■■■  ■■■■■ ■■■■       ■■■■   ■■■■ ■■  ■■    ■■■■■■ 
exit /b



:logo_main3
echo.                        ██              ████  ████               ██████ 
echo.   ██                  ████     █████    ██    ██ ████ ████     ██    ██
echo.     ██               ██  ██    ██  ██    ██  ██   ██  ██  ██   ██      
echo.       ██            ████████   ██  ██     ████    ██  ██  ██   ██      
echo.     ██             ███    ███  ██  ██      ██     ██  █████    ██    ██
echo.   ██     ¬¬¬¬¬¬¬  █████  █████ ████       ████   ████ ██  ██    ██████ 
exit /b



:logo_main4
echo.                        □□              □□□□  □□□□               □□□□□□ 
echo.   □□                  □□□□     □□□□□    □□    □□ □□□□ □□□□     □□    □□
echo.     □□               □□  □□    □□  □□    □□  □□   □□  □□  □□   □□      
echo.       □□            □□□□□□□□   □□  □□     □□□□    □□  □□  □□   □□      
echo.     □□             □□□    □□□  □□  □□      □□     □□  □□□□□    □□    □□
echo.   □□     ¬¬¬¬¬¬¬  □□□□□  □□□□□ □□□□       □□□□   □□□□ □□  □□    □□□□□□ 
exit /b



:logo_main5
echo.                        ●●              ●●●●  ●●●●               ●●●●●● 
echo.   ●●                  ●●●●     ●●●●●    ●●    ●● ●●●● ●●●●     ●●    ●●
echo.     ●●               ●●  ●●    ●●  ●●    ●●  ●●   ●●  ●●  ●●   ●●      
echo.       ●●            ●●●●●●●●   ●●  ●●     ●●●●    ●●  ●●  ●●   ●●      
echo.     ●●             ●●●    ●●●  ●●  ●●      ●●     ●●  ●●●●●    ●●    ●●
echo.   ●●     ¬¬¬¬¬¬¬  ●●●●●  ●●●●● ●●●●       ●●●●   ●●●● ●●  ●●    ●●●●●● 
exit /b



:logo_log1
echo.   ШШ         ШШ ШШ      ШШ ШШШШШ   ШШШШ      ШШШШШШ   ШШШШШШ 
echo.     ШШ      ШШШШ ШШ    ШШ ШШ  ШШ    ШШ      ШШ    ШШ ШШ      
echo.       ШШ   ШШ  ШШ ШШ  ШШ ШШ         ШШ      ШШ    ШШ ШШ  ШШШШ
echo.     ШШ    ШШШШШШШШ ШШШШ ШШ  ШШ      ШШ    Ш ШШ    ШШ ШШ    ШШ
echo.   ШШ     ШШШ    ШШШ ШШ ШШШШШ       ШШШШШШШШ  ШШШШШШ   ШШШШШШ 
exit /b



:logo_log2
echo.   ■■         ■■ ■■      ■■  ■■■■■   ■■■■      ■■■■■■   ■■■■■■ 
echo.     ■■      ■■■■ ■■    ■■ ■■   ■■    ■■      ■■    ■■ ■■      
echo.       ■■   ■■  ■■ ■■  ■■ ■■          ■■      ■■    ■■ ■■  ■■■■
echo.     ■■    ■■■■■■■■ ■■■■ ■■  ■■       ■■    ■ ■■    ■■ ■■    ■■
echo.   ■■     ■■■    ■■■ ■■ ■■■■■        ■■■■■■■■  ■■■■■■   ■■■■■■ 
exit /b



:logo_log3
echo.   ██         ██ ██      ██ █████   ████      ██████   ██████ 
echo.     ██      ████ ██    ██ ██  ██    ██      ██    ██ ██      
echo.       ██   ██  ██ ██  ██ ██         ██      ██    ██ ██  ████
echo.     ██    ████████ ████ ██  ██      ██    █ ██    ██ ██    ██
echo.   ██     ███    ███ ██ █████       ████████  ██████   ██████ 
exit /b



:logo_log4
echo.   □□         □□ □□      □□ □□□□□   □□□□      □□□□□□   □□□□□□ 
echo.     □□      □□□□ □□    □□ □□  □□    □□      □□    □□ □□      
echo.       □□   □□  □□ □□  □□ □□         □□      □□    □□ □□  □□□□
echo.     □□    □□□□□□□□ □□□□ □□  □□      □□    □ □□    □□ □□    □□
echo.   □□     □□□    □□□ □□ □□□□□       □□□□□□□□  □□□□□□   □□□□□□ 
exit /b



:logo_main5
echo.   ●●         ●● ●●      ●● ●●●●●   ●●●●      ●●●●●●   ●●●●●● 
echo.     ●●      ●●●● ●●    ●● ●●  ●●    ●●      ●●    ●● ●●      
echo.       ●●   ●●  ●● ●●  ●● ●●         ●●      ●●    ●● ●●  ●●●●
echo.     ●●    ●●●●●●●● ●●●● ●●  ●●      ●●    ● ●●    ●● ●●    ●●
echo.   ●●     ●●●    ●●● ●● ●●●●●       ●●●●●●●●  ●●●●●●   ●●●●●● 
exit /b







:viewPager
call :viewPager_%*
exit /b



:viewPager_initiate
set counter_viewPager_page=1
set counter_viewPager_page_next=11

set viewPager_keyword=%command%
set viewPager_fileList=%1
set viewPager_fileDir=%2

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

echo.!counter_viewPager_element!>  temp\counter_viewPager_element
echo.!counter_viewPager_k!>        temp\counter_viewPager_k
echo.!counter_viewPager_page!>     temp\counter_viewPager_page
echo.!counter_viewPager_page_next!>temp\counter_viewPager_page_next

endlocal
exit /b



:viewPager_control
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

setlocal EnableDelayedExpansion
set counter_viewPager_element=0

for /f "eol=# delims=" %%i in (%viewPager_fileList%) do %viewPager_generate_addition% (
  set /a counter_viewPager_element+=1
  if !counter_viewPager_element! GEQ !counter_viewPager_page! if !counter_viewPager_element! LSS !counter_viewPager_page_next! if "%command%" == "!counter_viewPager_element!" (
    if "%1" == "add"    echo.%viewPager_element%>>%2
    if "%1" == "remove" (
      set counter_viewPager_element_remove=0
      copy /y %2 %2.old>>%log_debug%
      del /q %2

      for /f "delims=" %%j in (%2.old) do (
        set /a counter_viewPager_element_remove+=1
        if "!counter_viewPager_element!" NEQ "!counter_viewPager_element_remove!" echo.%%j>>%2
      )

      copy /y %2.old temp\>>%log_debug%
      del /q %2.old
    )
  )
)

endlocal
exit /b