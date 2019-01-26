call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Rules]>>%log%
echo.   [Heuristic]>>%log%

call files\databases\original\other\heuristic.cmd

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module_sleep% 3
exit