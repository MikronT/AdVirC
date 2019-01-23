@echo off
for /f "skip=1 tokens=1,2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do (
  del /q "%%k\AdVirC.lnk">nul 2>nul
  call "%~dp0\subroutines\modules\shortcut.exe" /a:c /f:"%%k\AdVirC.lnk" /t:"%~dp0\starter.cmd" /i:"%~dp0\design\icon.ico"
)