@%logo_log%
%log_append_place% : [Rules]
setlocal EnableDelayedExpansion



if "%setting_cleaningRule_experimental%" == "true" (
  %log_append_place% :   [Experimental]
  echo.%language_cleaning_rules_experimental%
  call %dataDir%\databases\original\rules\experimental.cmd
  %log_append_place% :   Script Completed
)
%loadingUpdate% 1



if "%setting_cleaningRule_heuristic%" == "true" (
  %log_append_place% :   [Heuristic]
  echo.%language_cleaning_rules_heuristic%
  call %dataDir%\databases\original\rules\heuristic.cmd
  %log_append_place% :   Script Completed
)
%loadingUpdate% 1




endlocal
%module_sleep% 5
exit