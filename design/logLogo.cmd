@echo off
chcp 65001>nul

mode con:cols=70 lines=36
color 0b

title %program_name% ^| Log
cls

echo.
call design\logos.cmd log1
echo.
echo.

exit /b