call design\logLogo.cmd
setlocal EnableDelayedExpansion

echo.[Rules]>>%log%
echo.   [Experimental]>>%log%

call files\databases\original\other\experimental.cmd

echo.Script Completed>>%log%
echo.>>%log%
echo.>>%log%
echo.>>%log%

endlocal
%module_sleep% 3
exit