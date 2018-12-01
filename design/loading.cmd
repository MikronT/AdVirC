@echo off
color 0b
chcp 65001
mode con:cols=62 lines=7
set percents=0





:loadingCycle
set /a percents=%loadingNumber%*2
title %appName% ^| Loading: %percents%%%...
cls
echo.
                         echo.   ╔══════════════════════════════════════════════════════╗
                         echo.   ║                                                      ║
if %loadingNumber% == 0  echo.   ║                                                      ║
if %loadingNumber% == 1  echo.   ║  █                                                   ║
if %loadingNumber% == 2  echo.   ║  ██                                                  ║
if %loadingNumber% == 3  echo.   ║  ███                                                 ║
if %loadingNumber% == 4  echo.   ║  ████                                                ║
if %loadingNumber% == 5  echo.   ║  █████                                               ║
if %loadingNumber% == 6  echo.   ║  ██████                                              ║
if %loadingNumber% == 7  echo.   ║  ███████                                             ║
if %loadingNumber% == 8  echo.   ║  ████████                                            ║
if %loadingNumber% == 9  echo.   ║  █████████                                           ║
if %loadingNumber% == 10 echo.   ║  ██████████                                          ║
if %loadingNumber% == 11 echo.   ║  ███████████                                         ║
if %loadingNumber% == 12 echo.   ║  ████████████                                        ║
if %loadingNumber% == 13 echo.   ║  █████████████                                       ║
if %loadingNumber% == 14 echo.   ║  ██████████████                                      ║
if %loadingNumber% == 15 echo.   ║  ███████████████                                     ║
if %loadingNumber% == 16 echo.   ║  ████████████████                                    ║
if %loadingNumber% == 17 echo.   ║  █████████████████                                   ║
if %loadingNumber% == 18 echo.   ║  ██████████████████                                  ║
if %loadingNumber% == 19 echo.   ║  ███████████████████                                 ║
if %loadingNumber% == 20 echo.   ║  ████████████████████                                ║
if %loadingNumber% == 21 echo.   ║  █████████████████████                               ║
if %loadingNumber% == 22 echo.   ║  ██████████████████████                              ║
if %loadingNumber% == 23 echo.   ║  ███████████████████████                             ║
if %loadingNumber% == 24 echo.   ║  ████████████████████████                            ║
if %loadingNumber% == 25 echo.   ║  █████████████████████████                           ║
if %loadingNumber% == 26 echo.   ║  ██████████████████████████                          ║
if %loadingNumber% == 27 echo.   ║  ███████████████████████████                         ║
if %loadingNumber% == 28 echo.   ║  ████████████████████████████                        ║
if %loadingNumber% == 29 echo.   ║  █████████████████████████████                       ║
if %loadingNumber% == 30 echo.   ║  ██████████████████████████████                      ║
if %loadingNumber% == 31 echo.   ║  ███████████████████████████████                     ║
if %loadingNumber% == 32 echo.   ║  ████████████████████████████████                    ║
if %loadingNumber% == 33 echo.   ║  █████████████████████████████████                   ║
if %loadingNumber% == 34 echo.   ║  ██████████████████████████████████                  ║
if %loadingNumber% == 35 echo.   ║  ███████████████████████████████████                 ║
if %loadingNumber% == 36 echo.   ║  ████████████████████████████████████                ║
if %loadingNumber% == 37 echo.   ║  █████████████████████████████████████               ║
if %loadingNumber% == 38 echo.   ║  ██████████████████████████████████████              ║
if %loadingNumber% == 39 echo.   ║  ███████████████████████████████████████             ║
if %loadingNumber% == 40 echo.   ║  ████████████████████████████████████████            ║
if %loadingNumber% == 41 echo.   ║  █████████████████████████████████████████           ║
if %loadingNumber% == 42 echo.   ║  ██████████████████████████████████████████          ║
if %loadingNumber% == 43 echo.   ║  ███████████████████████████████████████████         ║
if %loadingNumber% == 44 echo.   ║  ████████████████████████████████████████████        ║
if %loadingNumber% == 45 echo.   ║  █████████████████████████████████████████████       ║
if %loadingNumber% == 46 echo.   ║  ██████████████████████████████████████████████      ║
if %loadingNumber% == 47 echo.   ║  ███████████████████████████████████████████████     ║
if %loadingNumber% == 48 echo.   ║  ████████████████████████████████████████████████    ║
if %loadingNumber% == 49 echo.   ║  █████████████████████████████████████████████████   ║
if %loadingNumber% == 50 echo.   ║  ██████████████████████████████████████████████████  ║
                         echo.   ║                                                      ║
                         echo.   ╚══════════════════════════════════════════════════════╝

if %loadingNumber% == 50 echo.0>temp\loadingProgress
set lastLoadingNumber=%loadingNumber%
goto :checkLoadingProgress





:checkLoadingProgress
%moduleSleep% -m 250
for /f "tokens=1,2* delims=" %%n in (temp\loadingProgress) do set /a loadingNumber=%%n
if "%lastLoadingNumber%" NEQ "%loadingNumber%" goto :loadingCycle
goto :checkLoadingProgress