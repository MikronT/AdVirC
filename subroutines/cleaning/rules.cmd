@%logo_log%
for %%i in (%log% %log_debug%) do echo.[Rules]>>%%i
setlocal EnableDelayedExpansion



for %%i in (%log% %log_debug%) do (
  echo.  [Experimental]>>%%i
)



call files\databases\original\other\experimental.cmd



for %%i in (%log% %log_debug%) do (
  echo.  Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
  echo.  [Heuristic]>>%%i
)



call files\databases\original\other\heuristic.cmd



for %%i in (%log% %log_debug%) do (
  echo.  Script Completed>>%%i
  for /l %%z in (3,-1,1) do echo.>>%%i
)



endlocal
%module_sleep% 3
exit