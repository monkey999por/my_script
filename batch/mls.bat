@echo off
rem カレントディレクトリ
set "this=%cd%"

echo %this%
pushd "%~dp0" 
rem 環境変数(主にパス系)設定

call .\props\env_path_set.bat


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
 cd %this%
 exit /b 1
)


setlocal
rem コマンド存在チェック
set "my_temp=%temp%\temp_mls.txt"
dir /b %command_path% > %my_temp%
	
setlocal ENABLEDELAYEDEXPANSION
for /f %%i in (%my_temp%) do (
 if "%1"=="%%i" (
  set "is_exist_command=true"
  call :Run %*
  endlocal & endlocal & cd %this%
  exit /b 0
 ) 
)

echo コマンドが存在しません
endlocal & endlocal & cd %this%
exit /b 1

:Run
rem カスタムコマンド実行
for /f "tokens=1*" %%i in ("%*") do (
 if "%is_exist_command%"=="true" (
  call %command_path%\%%i\%%i.bat %%j  
 )
)



endlocal & endlocal & cd %this%