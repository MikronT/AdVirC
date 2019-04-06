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
call :%1%2
echo.
echo.
echo.
exit /b



:main1
echo.                        ШШ              ШШШШ  ШШШШ               ШШШШШШ 
echo.   ШШ                  ШШШШ     ШШШШШ    ШШ    ШШ ШШШШ ШШШШ     ШШ    ШШ
echo.     ШШ               ШШ  ШШ    ШШ  ШШ    ШШ  ШШ   ШШ  ШШ  ШШ   ШШ      
echo.       ШШ            ШШШШШШШШ   ШШ  ШШ     ШШШШ    ШШ  ШШ  ШШ   ШШ      
echo.     ШШ             ШШШ    ШШШ  ШШ  ШШ      ШШ     ШШ  ШШШШШ    ШШ    ШШ
echo.   ШШ     ¬¬¬¬¬¬¬  ШШШШШ  ШШШШШ ШШШШ       ШШШШ   ШШШШ ШШ  ШШ    ШШШШШШ 
exit /b



:main2
echo.                        ■■              ■■■■  ■■■■               ■■■■■■ 
echo.   ■■                  ■■■■     ■■■■■    ■■    ■■ ■■■■ ■■■■     ■■    ■■
echo.     ■■               ■■  ■■    ■■  ■■    ■■  ■■   ■■  ■■  ■■   ■■      
echo.       ■■            ■■■■■■■■   ■■  ■■     ■■■■    ■■  ■■  ■■   ■■      
echo.     ■■             ■■■    ■■■  ■■  ■■      ■■     ■■  ■■■■■    ■■    ■■
echo.   ■■     ¬¬¬¬¬¬¬  ■■■■■  ■■■■■ ■■■■       ■■■■   ■■■■ ■■  ■■    ■■■■■■ 
exit /b



:main3
echo.                        ██              ████  ████               ██████ 
echo.   ██                  ████     █████    ██    ██ ████ ████     ██    ██
echo.     ██               ██  ██    ██  ██    ██  ██   ██  ██  ██   ██      
echo.       ██            ████████   ██  ██     ████    ██  ██  ██   ██      
echo.     ██             ███    ███  ██  ██      ██     ██  █████    ██    ██
echo.   ██     ¬¬¬¬¬¬¬  █████  █████ ████       ████   ████ ██  ██    ██████ 
exit /b



:main4
echo.                        □□              □□□□  □□□□               □□□□□□ 
echo.   □□                  □□□□     □□□□□    □□    □□ □□□□ □□□□     □□    □□
echo.     □□               □□  □□    □□  □□    □□  □□   □□  □□  □□   □□      
echo.       □□            □□□□□□□□   □□  □□     □□□□    □□  □□  □□   □□      
echo.     □□             □□□    □□□  □□  □□      □□     □□  □□□□□    □□    □□
echo.   □□     ¬¬¬¬¬¬¬  □□□□□  □□□□□ □□□□       □□□□   □□□□ □□  □□    □□□□□□ 
exit /b



:main5
echo.                        ●●              ●●●●  ●●●●               ●●●●●● 
echo.   ●●                  ●●●●     ●●●●●    ●●    ●● ●●●● ●●●●     ●●    ●●
echo.     ●●               ●●  ●●    ●●  ●●    ●●  ●●   ●●  ●●  ●●   ●●      
echo.       ●●            ●●●●●●●●   ●●  ●●     ●●●●    ●●  ●●  ●●   ●●      
echo.     ●●             ●●●    ●●●  ●●  ●●      ●●     ●●  ●●●●●    ●●    ●●
echo.   ●●     ¬¬¬¬¬¬¬  ●●●●●  ●●●●● ●●●●       ●●●●   ●●●● ●●  ●●    ●●●●●● 
exit /b



:log1
echo.   ШШ         ШШ ШШ      ШШ ШШШШШ   ШШШШ      ШШШШШШ   ШШШШШШ 
echo.     ШШ      ШШШШ ШШ    ШШ ШШ  ШШ    ШШ      ШШ    ШШ ШШ      
echo.       ШШ   ШШ  ШШ ШШ  ШШ ШШ         ШШ      ШШ    ШШ ШШ  ШШШШ
echo.     ШШ    ШШШШШШШШ ШШШШ ШШ  ШШ      ШШ    Ш ШШ    ШШ ШШ    ШШ
echo.   ШШ     ШШШ    ШШШ ШШ ШШШШШ       ШШШШШШШШ  ШШШШШШ   ШШШШШШ 
exit /b



:log2
echo.   ■■         ■■ ■■      ■■  ■■■■■   ■■■■      ■■■■■■   ■■■■■■ 
echo.     ■■      ■■■■ ■■    ■■ ■■   ■■    ■■      ■■    ■■ ■■      
echo.       ■■   ■■  ■■ ■■  ■■ ■■          ■■      ■■    ■■ ■■  ■■■■
echo.     ■■    ■■■■■■■■ ■■■■ ■■  ■■       ■■    ■ ■■    ■■ ■■    ■■
echo.   ■■     ■■■    ■■■ ■■ ■■■■■        ■■■■■■■■  ■■■■■■   ■■■■■■ 
exit /b



:log3
echo.   ██         ██ ██      ██ █████   ████      ██████   ██████ 
echo.     ██      ████ ██    ██ ██  ██    ██      ██    ██ ██      
echo.       ██   ██  ██ ██  ██ ██         ██      ██    ██ ██  ████
echo.     ██    ████████ ████ ██  ██      ██    █ ██    ██ ██    ██
echo.   ██     ███    ███ ██ █████       ████████  ██████   ██████ 
exit /b



:log4
echo.   □□         □□ □□      □□ □□□□□   □□□□      □□□□□□   □□□□□□ 
echo.     □□      □□□□ □□    □□ □□  □□    □□      □□    □□ □□      
echo.       □□   □□  □□ □□  □□ □□         □□      □□    □□ □□  □□□□
echo.     □□    □□□□□□□□ □□□□ □□  □□      □□    □ □□    □□ □□    □□
echo.   □□     □□□    □□□ □□ □□□□□       □□□□□□□□  □□□□□□   □□□□□□ 
exit /b



:main5
echo.   ●●         ●● ●●      ●● ●●●●●   ●●●●      ●●●●●●   ●●●●●● 
echo.     ●●      ●●●● ●●    ●● ●●  ●●    ●●      ●●    ●● ●●      
echo.       ●●   ●●  ●● ●●  ●● ●●         ●●      ●●    ●● ●●  ●●●●
echo.     ●●    ●●●●●●●● ●●●● ●●  ●●      ●●    ● ●●    ●● ●●    ●●
echo.   ●●     ●●●    ●●● ●● ●●●●●       ●●●●●●●●  ●●●●●●   ●●●●●● 
exit /b