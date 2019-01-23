@echo off
chcp 65001>nul

mode con:cols=70 lines=36
title %appName% ^| Log
color 0b

cls

echo.
echo.
call design\logos.cmd log1
echo.
echo.
echo.
echo.

exit /b