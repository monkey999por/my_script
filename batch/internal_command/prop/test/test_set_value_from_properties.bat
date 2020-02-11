@echo off
setlocal

echo %*
call test_set_value_from_properties_routine.bat %1 %2


echo %MY_LOCAL_SCRIPT_PROP%
