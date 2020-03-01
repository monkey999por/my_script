@echo off
setlocal
pushd "%~dp0"

rem ã§í helpèoóÕ
if "%1"=="--help" (
 call %common_help% %~n0 --help
 exit /b 0
)




