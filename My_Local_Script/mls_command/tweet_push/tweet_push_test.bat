@echo off
setlocal
pushd "%~dp0"

rem ����help�o��
if "%1"=="--help" (
 type .\help\%~n0.overview
 echo.
 echo.
 type .\help\%~n0.detail
 echo.
 exit /b 0
)
call %mls_command%\tweet_push\tweet_push.bat 
