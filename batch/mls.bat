@echo off
setlocal

pushd "%~dp0"

rem $mls %command_name% &command_option...&
rem args
rem command
rem options...(for %command%)

rem スタートページ
.\help\hello_mls.bat




rem 引数チェック
if "%1"=="" (
 echo コマンド名を指定してください
 exit /b 1
)

set "command=%1"





popd



