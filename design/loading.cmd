@echo off
color 0b
chcp 65001>nul
mode con:cols=62 lines=7
set percents=0





:loadingCycle
set /a percents=%loadingCounter%*2
title %appName% ^| Loading: %percents%%%...
cls
echo.
                          echo.   ╔══════════════════════════════════════════════════════╗
                          echo.   ║                                                      ║
if %loadingCounter% == 0  echo.   ║                                                      ║
if %loadingCounter% == 1  echo.   ║  █                                                   ║
if %loadingCounter% == 2  echo.   ║  ██                                                  ║
if %loadingCounter% == 3  echo.   ║  ███                                                 ║
if %loadingCounter% == 4  echo.   ║  ████                                                ║
if %loadingCounter% == 5  echo.   ║  █████                                               ║
if %loadingCounter% == 6  echo.   ║  ██████                                              ║
if %loadingCounter% == 7  echo.   ║  ███████                                             ║
if %loadingCounter% == 8  echo.   ║  ████████                                            ║
if %loadingCounter% == 9  echo.   ║  █████████                                           ║
if %loadingCounter% == 10 echo.   ║  ██████████                                          ║
if %loadingCounter% == 11 echo.   ║  ███████████                                         ║
if %loadingCounter% == 12 echo.   ║  ████████████                                        ║
if %loadingCounter% == 13 echo.   ║  █████████████                                       ║
if %loadingCounter% == 14 echo.   ║  ██████████████                                      ║
if %loadingCounter% == 15 echo.   ║  ███████████████                                     ║
if %loadingCounter% == 16 echo.   ║  ████████████████                                    ║
if %loadingCounter% == 17 echo.   ║  █████████████████                                   ║
if %loadingCounter% == 18 echo.   ║  ██████████████████                                  ║
if %loadingCounter% == 19 echo.   ║  ███████████████████                                 ║
if %loadingCounter% == 20 echo.   ║  ████████████████████                                ║
if %loadingCounter% == 21 echo.   ║  █████████████████████                               ║
if %loadingCounter% == 22 echo.   ║  ██████████████████████                              ║
if %loadingCounter% == 23 echo.   ║  ███████████████████████                             ║
if %loadingCounter% == 24 echo.   ║  ████████████████████████                            ║
if %loadingCounter% == 25 echo.   ║  █████████████████████████                           ║
if %loadingCounter% == 26 echo.   ║  ██████████████████████████                          ║
if %loadingCounter% == 27 echo.   ║  ███████████████████████████                         ║
if %loadingCounter% == 28 echo.   ║  ████████████████████████████                        ║
if %loadingCounter% == 29 echo.   ║  █████████████████████████████                       ║
if %loadingCounter% == 30 echo.   ║  ██████████████████████████████                      ║
if %loadingCounter% == 31 echo.   ║  ███████████████████████████████                     ║
if %loadingCounter% == 32 echo.   ║  ████████████████████████████████                    ║
if %loadingCounter% == 33 echo.   ║  █████████████████████████████████                   ║
if %loadingCounter% == 34 echo.   ║  ██████████████████████████████████                  ║
if %loadingCounter% == 35 echo.   ║  ███████████████████████████████████                 ║
if %loadingCounter% == 36 echo.   ║  ████████████████████████████████████                ║
if %loadingCounter% == 37 echo.   ║  █████████████████████████████████████               ║
if %loadingCounter% == 38 echo.   ║  ██████████████████████████████████████              ║
if %loadingCounter% == 39 echo.   ║  ███████████████████████████████████████             ║
if %loadingCounter% == 40 echo.   ║  ████████████████████████████████████████            ║
if %loadingCounter% == 41 echo.   ║  █████████████████████████████████████████           ║
if %loadingCounter% == 42 echo.   ║  ██████████████████████████████████████████          ║
if %loadingCounter% == 43 echo.   ║  ███████████████████████████████████████████         ║
if %loadingCounter% == 44 echo.   ║  ████████████████████████████████████████████        ║
if %loadingCounter% == 45 echo.   ║  █████████████████████████████████████████████       ║
if %loadingCounter% == 46 echo.   ║  ██████████████████████████████████████████████      ║
if %loadingCounter% == 47 echo.   ║  ███████████████████████████████████████████████     ║
if %loadingCounter% == 48 echo.   ║  ████████████████████████████████████████████████    ║
if %loadingCounter% == 49 echo.   ║  █████████████████████████████████████████████████   ║
if %loadingCounter% == 50 echo.   ║  ██████████████████████████████████████████████████  ║
                          echo.   ║                                                      ║
                          echo.   ╚══════════════════════════════════════════════════════╝

if %loadingCounter% == 50 %loadingUpdate% reset
set lastLoadingNumber=%loadingCounter%
goto :checkLoadingProgress





:checkLoadingProgress
%module-sleep% -m 250
for /f "tokens=1,2* delims=" %%n in (temp\loadingCounter) do set loadingCounter=%%n
if "%loadingCounter%" == "stop" exit
if "%lastLoadingNumber%" NEQ "%loadingCounter%" goto :loadingCycle
goto :checkLoadingProgress