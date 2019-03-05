for %%i in (%log% %log_debug%) do echo.[Update]>>%%i

for /f "tokens=1,2,* delims=- " %%i in ("%*") do (
  set %%i
  set %%j
)







if "%key_check%" == "true" (
  set key_check=false
)







if "%key_update%" == "true" (
  set key_update=false
)
exit /b
