@%logo_log%
%log_append_place% : [Rules]
setlocal EnableDelayedExpansion



if "%setting_cleaningRule_experimental%" == "true" (
  %log_append_place% :   [Experimental]
  call %dataDir%\databases\original\rules\experimental.cmd
  %log_append_place% :   Script Completed
)
%loadingUpdate% 1



if "%setting_cleaningRule_heuristic%" == "true" (
  %log_append_place% :   [Heuristic]
  call %dataDir%\databases\original\rules\heuristic.cmd
  %log_append_place% :   Script Completed
)
%loadingUpdate% 1




endlocal
%module_sleep% 5
exit