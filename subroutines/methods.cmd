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
if "%1" == "initiate" (
  set counter_viewPager_page=1
  set counter_viewPager_page_next=11

  set viewPager_keyword=%command%
  set viewPager_fileList=%2
  set viewPager_fileDir=%3
)

if "%1" == "control" (
  if /i "%command%" == "P" (
    set /a counter_viewPager_page-=10
    set /a counter_viewPager_page_next-=10
  )
  if /i "%command%" == "N" (
    set /a counter_viewPager_page+=10
    set /a counter_viewPager_page_next+=10
  )
)

setlocal EnableDelayedExpansion

if "%1" == "generate" (
  set counter_viewPager_element=1

  for /f "eol=# delims=" %%i in (%viewPager_fileList%) do for /f "eol=- delims=" %%j in ('find /i "%viewPager_keyword%" %viewPager_fileDir%\%%i') do (
    if !counter_viewPager_element! GEQ !counter_viewPager_page! if !counter_viewPager_element! LSS !counter_viewPager_page_next! (
      if !counter_viewPager_element! GEQ 1    if !counter_viewPager_element! LSS 10    echo.     !counter_viewPager_element!  %%j
      if !counter_viewPager_element! GEQ 10   if !counter_viewPager_element! LSS 100   echo.    !counter_viewPager_element!  %%j
      if !counter_viewPager_element! GEQ 100  if !counter_viewPager_element! LSS 1000  echo.   !counter_viewPager_element!  %%j
      if !counter_viewPager_element! GEQ 1000 if !counter_viewPager_element! LSS 10000 echo.  !counter_viewPager_element!  %%j
    )
    set /a counter_viewPager_element+=1
  )
)

if "%1" == "modify" if /i "%command%" NEQ "P" if /i "%command%" NEQ "N" (
  set counter_viewPager_element=1

  for /f "eol=# delims=" %%i in (%viewPager_fileList%) do for /f "eol=- delims=" %%j in ('find /i "%viewPager_keyword%" %viewPager_fileDir%\%%i') do (
    if !counter_viewPager_element! GEQ !counter_viewPager_page! if !counter_viewPager_element! LSS !counter_viewPager_page_next! (
      if "%2" == "add"    if "%command%" == "!counter_viewPager_element!" echo.%%j>>"%3"
      if "%2" == "remove" rem
    )
    set /a counter_viewPager_element+=1
  )
)

endlocal
exit /b