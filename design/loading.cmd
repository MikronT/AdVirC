@echo off
color 0b
chcp 65001
mode con:cols=62 lines=7
set percents=0





:loadingCycle
set /a percents=%counter-loading%*2
title %appName% ^| Loading: %percents%%%...
cls
echo.
                           echo.   ╔══════════════════════════════════════════════════════╗
                           echo.   ║                                                      ║
if %counter-loading% == 0  echo.   ║                                                      ║
if %counter-loading% == 1  echo.   ║  █                                                   ║
if %counter-loading% == 2  echo.   ║  ██                                                  ║
if %counter-loading% == 3  echo.   ║  ███                                                 ║
if %counter-loading% == 4  echo.   ║  ████                                                ║
if %counter-loading% == 5  echo.   ║  █████                                               ║
if %counter-loading% == 6  echo.   ║  ██████                                              ║
if %counter-loading% == 7  echo.   ║  ███████                                             ║
if %counter-loading% == 8  echo.   ║  ████████                                            ║
if %counter-loading% == 9  echo.   ║  █████████                                           ║
if %counter-loading% == 10 echo.   ║  ██████████                                          ║
if %counter-loading% == 11 echo.   ║  ███████████                                         ║
if %counter-loading% == 12 echo.   ║  ████████████                                        ║
if %counter-loading% == 13 echo.   ║  █████████████                                       ║
if %counter-loading% == 14 echo.   ║  ██████████████                                      ║
if %counter-loading% == 15 echo.   ║  ███████████████                                     ║
if %counter-loading% == 16 echo.   ║  ████████████████                                    ║
if %counter-loading% == 17 echo.   ║  █████████████████                                   ║
if %counter-loading% == 18 echo.   ║  ██████████████████                                  ║
if %counter-loading% == 19 echo.   ║  ███████████████████                                 ║
if %counter-loading% == 20 echo.   ║  ████████████████████                                ║
if %counter-loading% == 21 echo.   ║  █████████████████████                               ║
if %counter-loading% == 22 echo.   ║  ██████████████████████                              ║
if %counter-loading% == 23 echo.   ║  ███████████████████████                             ║
if %counter-loading% == 24 echo.   ║  ████████████████████████                            ║
if %counter-loading% == 25 echo.   ║  █████████████████████████                           ║
if %counter-loading% == 26 echo.   ║  ██████████████████████████                          ║
if %counter-loading% == 27 echo.   ║  ███████████████████████████                         ║
if %counter-loading% == 28 echo.   ║  ████████████████████████████                        ║
if %counter-loading% == 29 echo.   ║  █████████████████████████████                       ║
if %counter-loading% == 30 echo.   ║  ██████████████████████████████                      ║
if %counter-loading% == 31 echo.   ║  ███████████████████████████████                     ║
if %counter-loading% == 32 echo.   ║  ████████████████████████████████                    ║
if %counter-loading% == 33 echo.   ║  █████████████████████████████████                   ║
if %counter-loading% == 34 echo.   ║  ██████████████████████████████████                  ║
if %counter-loading% == 35 echo.   ║  ███████████████████████████████████                 ║
if %counter-loading% == 36 echo.   ║  ████████████████████████████████████                ║
if %counter-loading% == 37 echo.   ║  █████████████████████████████████████               ║
if %counter-loading% == 38 echo.   ║  ██████████████████████████████████████              ║
if %counter-loading% == 39 echo.   ║  ███████████████████████████████████████             ║
if %counter-loading% == 40 echo.   ║  ████████████████████████████████████████            ║
if %counter-loading% == 41 echo.   ║  █████████████████████████████████████████           ║
if %counter-loading% == 42 echo.   ║  ██████████████████████████████████████████          ║
if %counter-loading% == 43 echo.   ║  ███████████████████████████████████████████         ║
if %counter-loading% == 44 echo.   ║  ████████████████████████████████████████████        ║
if %counter-loading% == 45 echo.   ║  █████████████████████████████████████████████       ║
if %counter-loading% == 46 echo.   ║  ██████████████████████████████████████████████      ║
if %counter-loading% == 47 echo.   ║  ███████████████████████████████████████████████     ║
if %counter-loading% == 48 echo.   ║  ████████████████████████████████████████████████    ║
if %counter-loading% == 49 echo.   ║  █████████████████████████████████████████████████   ║
if %counter-loading% == 50 echo.   ║  ██████████████████████████████████████████████████  ║
                           echo.   ║                                                      ║
                           echo.   ╚══════════════════════════════════════════════════════╝

if %counter-loading% == 50 %loadingUpdate% reset
set lastLoadingNumber=%counter-loading%
goto :checkLoadingProgress





:checkLoadingProgress
%module-sleep% -m 250
for /f "tokens=1,2* delims=" %%n in (temp\counter-loading) do set counter-loading=%%n
if "%counter-loading%" == "stop" exit
if "%lastLoadingNumber%" NEQ "%counter-loading%" goto :loadingCycle
goto :checkLoadingProgress