@echo off
chcp 65001>nul





:cycle
mode con:cols=62 lines=7

set /a counter_percents=%counter_loading%*2
title %program_name% ^| Loading: %counter_percents%%%...

cls
echo.
                           echo.   ╔══════════════════════════════════════════════════════╗
                           echo.   ║                                                      ║
if %counter_loading% == 0  echo.   ║                                                      ║
if %counter_loading% == 1  echo.   ║  █                                                   ║
if %counter_loading% == 2  echo.   ║  ██                                                  ║
if %counter_loading% == 3  echo.   ║  ███                                                 ║
if %counter_loading% == 4  echo.   ║  ████                                                ║
if %counter_loading% == 5  echo.   ║  █████                                               ║
if %counter_loading% == 6  echo.   ║  ██████                                              ║
if %counter_loading% == 7  echo.   ║  ███████                                             ║
if %counter_loading% == 8  echo.   ║  ████████                                            ║
if %counter_loading% == 9  echo.   ║  █████████                                           ║
if %counter_loading% == 10 echo.   ║  ██████████                                          ║
if %counter_loading% == 11 echo.   ║  ███████████                                         ║
if %counter_loading% == 12 echo.   ║  ████████████                                        ║
if %counter_loading% == 13 echo.   ║  █████████████                                       ║
if %counter_loading% == 14 echo.   ║  ██████████████                                      ║
if %counter_loading% == 15 echo.   ║  ███████████████                                     ║
if %counter_loading% == 16 echo.   ║  ████████████████                                    ║
if %counter_loading% == 17 echo.   ║  █████████████████                                   ║
if %counter_loading% == 18 echo.   ║  ██████████████████                                  ║
if %counter_loading% == 19 echo.   ║  ███████████████████                                 ║
if %counter_loading% == 20 echo.   ║  ████████████████████                                ║
if %counter_loading% == 21 echo.   ║  █████████████████████                               ║
if %counter_loading% == 22 echo.   ║  ██████████████████████                              ║
if %counter_loading% == 23 echo.   ║  ███████████████████████                             ║
if %counter_loading% == 24 echo.   ║  ████████████████████████                            ║
if %counter_loading% == 25 echo.   ║  █████████████████████████                           ║
if %counter_loading% == 26 echo.   ║  ██████████████████████████                          ║
if %counter_loading% == 27 echo.   ║  ███████████████████████████                         ║
if %counter_loading% == 28 echo.   ║  ████████████████████████████                        ║
if %counter_loading% == 29 echo.   ║  █████████████████████████████                       ║
if %counter_loading% == 30 echo.   ║  ██████████████████████████████                      ║
if %counter_loading% == 31 echo.   ║  ███████████████████████████████                     ║
if %counter_loading% == 32 echo.   ║  ████████████████████████████████                    ║
if %counter_loading% == 33 echo.   ║  █████████████████████████████████                   ║
if %counter_loading% == 34 echo.   ║  ██████████████████████████████████                  ║
if %counter_loading% == 35 echo.   ║  ███████████████████████████████████                 ║
if %counter_loading% == 36 echo.   ║  ████████████████████████████████████                ║
if %counter_loading% == 37 echo.   ║  █████████████████████████████████████               ║
if %counter_loading% == 38 echo.   ║  ██████████████████████████████████████              ║
if %counter_loading% == 39 echo.   ║  ███████████████████████████████████████             ║
if %counter_loading% == 40 echo.   ║  ████████████████████████████████████████            ║
if %counter_loading% == 41 echo.   ║  █████████████████████████████████████████           ║
if %counter_loading% == 42 echo.   ║  ██████████████████████████████████████████          ║
if %counter_loading% == 43 echo.   ║  ███████████████████████████████████████████         ║
if %counter_loading% == 44 echo.   ║  ████████████████████████████████████████████        ║
if %counter_loading% == 45 echo.   ║  █████████████████████████████████████████████       ║
if %counter_loading% == 46 echo.   ║  ██████████████████████████████████████████████      ║
if %counter_loading% == 47 echo.   ║  ███████████████████████████████████████████████     ║
if %counter_loading% == 48 echo.   ║  ████████████████████████████████████████████████    ║
if %counter_loading% == 49 echo.   ║  █████████████████████████████████████████████████   ║
if %counter_loading% == 50 echo.   ║  ██████████████████████████████████████████████████  ║
                           echo.   ║                                                      ║
                           echo.   ╚══════════════════════════════════════════════════════╝

set counter_loading_last=%counter_loading%
goto :checkEngine





:checkEngine
%module_sleep% -m 250

if exist temp (
  (for /f "delims=" %%i in (temp\counter_loading) do set counter_loading=%%i)>nul 2>nul
  (color %setting_theme%)
) else color c

if "%counter_loading%" == "stop" exit
if "%counter_loading%" NEQ "%counter_loading_last%" goto :cycle
goto :checkEngine