@echo off
pushd "%~dp0"
rem 環境変数(主にパス系)設定

call .\props\env_path_set.bat

setlocal



rem $mls %command_name% &command_option...&
rem args
rem command
rem options...(for %command%)

rem スタートページ
call %start_page%

rem 引数チェック
if "%1"=="" (
 echo コマンド名を指定してください
 popd
 exit /b 1
)


set "command=%1"





popd



