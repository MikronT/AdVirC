@%logo_log%
%log_append_place% : [Rules]
setlocal EnableDelayedExpansion



%log_append_place% :   [Experimental]>>%%i



call %dataDir%\databases\original\rules\experimental.cmd



%log_append_place% :   Script Completed>>%%i
%log_append_place% :   [Heuristic]>>%%i



call %dataDir%\databases\original\rules\heuristic.cmd



%log_append_place% :   Script Completed>>%%i



endlocal
%module_sleep% 3
exit