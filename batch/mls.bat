@echo off
pushd "%~dp0"
rem 環境変数(主にパス系)設定

for /f "delims=" %%s in (.\props\env_path.sete) do (
 %%s
 echo %%s
)

echo %start_page%
exit /b 0

setlocal



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



