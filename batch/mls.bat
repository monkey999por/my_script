@echo off
rem カレントディレクトリ
@set "this=%cd%"
pushd "%~dp0" 

rem 環境変数(主にパス系)設定
call .\props\env_path_set.bat

rem $mls %command_name% &command_option...&
rem args
rem command
rem options...(for %command%)

rem 引数チェック
if "%1"=="" (
 call %start_page%
 echo コマンド名を指定してください
 cd %this%
 exit /b 1
)

if "%1"=="--help" (
 echo 実行可能コマンド一覧
 echo 詳細はcommand --helpで確認してください
 echo.
 
 rem dirで検索出来たら出力する
 set "mls_list=%temp%mls_list.txt"
 dir /b %command_path% > %mls_list%

 setlocal ENABLEDELAYEDEXPANSION
 for /f "tokens=1,2 delims==" %%a in (%command_help%) do (
  set "command_name=%%a"
  set "description=%%b"
  findstr /i /x /l	"!command_name!" %mls_list% > nul
  echo エラーレベル%errorlevel%
  if errorlevel 0 (
   echo [!command_name!]   !description!
   echo.
  ) else (
   echo やばい	
  )
   
 )
 endlocal
 del %mls_list%
 exit /b 0
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
rem 引数を一度ファイルに書き出して、それをforステートメントに渡す
rem ⇒こうしないとfor分の引数の関係でダブルクォーテーション付き引数がうまく認識されない
del %temp%\mls_run.txt
echo %* > %temp%\mls_run.txt

for /f "tokens=1* delims= " %%i in (%temp%\mls_run.txt) do (
 if "%is_exist_command%"=="true" (
  call %command_path%\%%i\%%i.bat %%j  
 )
)

endlocal & endlocal & cd %this%