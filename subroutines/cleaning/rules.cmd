@%logo_log%
%log_append_place% : [Rules]
setlocal EnableDelayedExpansion



%log_append_place% :   [Experimental]



call %dataDir%\databases\original\rules\experimental.cmd



%log_append_place% :   Script Completed
%loadingUpdate% 1

%log_append_place% :   [Heuristic]



call %dataDir%\databases\original\rules\heuristic.cmd



%log_append_place% :   Script Completed
%loadingUpdate% 1




endlocal
%module_sleep% 3
exit