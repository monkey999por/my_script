@echo off
setlocal

echo %*
echo start
call ..\set_value.bat %1
echo end

endlocal
echo %MY_LOCAL_SCRIPT_PROP%
