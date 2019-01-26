@echo off
chcp 65001>nul

mode con:cols=70 lines=36
color 0b

title %appName% ^| Log
cls

echo.
echo.
call design\logos.cmd log1
echo.
echo.
echo.
echo.

exit /b