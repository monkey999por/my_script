@echo off
setlocal

echo %*

endlocal
call ..\set_value_from_properties.bat %1 %2
setlocal

echo %MY_LOCAL_SCRIPT_PROP%

endlocal