@echo off
setlocal

rem $mls %command_name% &command_option...&
rem args
rem command
rem options...(for %command%)


rem 引数チェック
if "%1"=="" (
 echo コマンド名を指定してください
 exit /b 1
)


set "command=%1"









