@echo off
setlocal
pushd "%~dp0"

rem ����help�o��
if "%1"=="--help" (
 call %common_help% %~n0 --help
 exit /b 0
)




