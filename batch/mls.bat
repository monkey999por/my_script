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
rem call %start_page%

rem 引数チェック
if "%1"=="" (
 call %start_page%
 echo コマンド名を指定してください
 popd
 exit /b 1
)

rem コマンド存在チェック
for /f %%i in ('dir /b %command_path%') do (
 if "%1"=="%%i" (
  set "is_exist_command=true"
  call :Run %*
 ) else (
  exit /b 1
 )
 
)

:Run
rem カスタムコマンド実行
setlocal ENABLEDELAYEDEXPANSION
for /f "tokens=1*" %%i in ("%*") do (
 if "%is_exist_command%"=="true" (
  call %command_path%\%%i\%%i.bat %%j
 )
 
)

popd



