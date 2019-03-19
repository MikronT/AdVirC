@call %*
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

mode con:cols=124 lines=36
color 0b

title %program_version_name%
cls

echo.
echo.
call :%1
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







:logo_log
@echo off
chcp 65001>nul

mode con:cols=70 lines=36
color 0b

title %program_name% ^| Log
cls

echo.
call :%1
echo.
echo.
exit /b



:log1
echo.   ШШ         ШШ ШШ      ШШ ШШШШШ   ШШШШ      ШШШШШШ   ШШШШШШ 
echo.     ШШ      ШШШШ ШШ    ШШ ШШ        ШШ      ШШ    ШШ ШШ      
echo.       ШШ   ШШ  ШШ ШШ  ШШ ШШ         ШШ      ШШ    ШШ ШШ  ШШШШ
echo.     ШШ    ШШШШШШШШ ШШШШ ШШ          ШШ    Ш ШШ    ШШ ШШ    ШШ
echo.   ШШ     ШШШ    ШШШ ШШ ШШШШШ       ШШШШШШШШ  ШШШШШШ   ШШШШШШ 
exit /b



:log2
echo.   ■■         ■■ ■■      ■■  ■■■■■   ■■■■      ■■■■■■   ■■■■■■ 
echo.     ■■      ■■■■ ■■    ■■ ■■         ■■      ■■    ■■ ■■      
echo.       ■■   ■■  ■■ ■■  ■■ ■■          ■■      ■■    ■■ ■■  ■■■■
echo.     ■■    ■■■■■■■■ ■■■■ ■■           ■■    ■ ■■    ■■ ■■    ■■
echo.   ■■     ■■■    ■■■ ■■ ■■■■■        ■■■■■■■■  ■■■■■■   ■■■■■■ 
exit /b



:log3
echo.   ██         ██ ██      ██ █████   ████      ██████   ██████ 
echo.     ██      ████ ██    ██ ██        ██      ██    ██ ██      
echo.       ██   ██  ██ ██  ██ ██         ██      ██    ██ ██  ████
echo.     ██    ████████ ████ ██          ██    █ ██    ██ ██    ██
echo.   ██     ███    ███ ██ █████       ████████  ██████   ██████ 
exit /b



:log4
echo.   □□         □□ □□      □□ □□□□□   □□□□      □□□□□□   □□□□□□ 
echo.     □□      □□□□ □□    □□ □□        □□      □□    □□ □□      
echo.       □□   □□  □□ □□  □□ □□         □□      □□    □□ □□  □□□□
echo.     □□    □□□□□□□□ □□□□ □□          □□    □ □□    □□ □□    □□
echo.   □□     □□□    □□□ □□ □□□□□       □□□□□□□□  □□□□□□   □□□□□□ 
exit /b



:main5
echo.   ●●         ●● ●●      ●● ●●●●●   ●●●●      ●●●●●●   ●●●●●● 
echo.     ●●      ●●●● ●●    ●● ●●        ●●      ●●    ●● ●●      
echo.       ●●   ●●  ●● ●●  ●● ●●         ●●      ●●    ●● ●●  ●●●●
echo.     ●●    ●●●●●●●● ●●●● ●●          ●●    ● ●●    ●● ●●    ●●
echo.   ●●     ●●●    ●●● ●● ●●●●●       ●●●●●●●●  ●●●●●●   ●●●●●● 
exit /b