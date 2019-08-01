@echo off
set program_name=AdVirC

for /f "skip=1 tokens=1,2,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do (
  del /q "%%k\%program_name%.lnk">nul 2>nul
  call "%~dp0subroutines\modules\shortcut.exe" /a:c /f:"%%k\%program_name%.lnk" /t:"%~dp0starter.cmd" /i:"%~dp0files\icon.ico">nul 2>nul
)