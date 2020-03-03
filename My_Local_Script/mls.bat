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

rem help表示
if "%1"=="--help" (
 call %common_help% %1
 cd %this%
 exit /b 0
)

rem 開発用。指定したコマンド名でひな形を作成する
if "%1"=="--new" (
 if "%2"=="" (
  echo コマンド名を指定してください。
  cd %this%
  exit /b 1
 )
 
 setlocal ENABLEDELAYEDEXPANSION
 for /f %%c in ('dir /b %command_path%') do (
  if "%2"=="%%c" (
   echo すでに同名コマンドが存在します。別の名前を指定してください。
   endlocal & cd %this%
   exit /b 1
  )
 )
 endlocal
 
 echo 開発用です。
 echo "ひな形を作成します：%2"
 
 rem フォルダを作成する
 mkdir %command_path%\%2
 
 rem ファイルを配置する
 copy %current_path%\ひな形.bat %command_path%\%2\%2.bat
 
 copy %current_path%\ひな形.bat %command_path%\%2\%2_test.bat
 
 echo call %command_path%\%2\%2.bat >> %command_path%\%2\%2_test.bat
 
 rem command.helpにhelpを追加する
 rem 内容は"command.helpに説明が書いてありません"
 echo %2=command.helpに説明が書いてありません >> %command_help%
 
 echo 正常終了しました
 cd %this%
 exit /b 0
)

rem カスタムコマンドのテスト実行用
if "%1"=="--test" (
 if "%2"=="" (
  echo コマンド名を指定してください。
  cd %this%
  exit /b 1
 )
 
 setlocal ENABLEDELAYEDEXPANSION
 for /f %%c in ('dir /b %command_path%') do (
  if "%2"=="%%c" (
   call %command_path%\%2\%2_test.bat
   endlocal & cd %this%
   exit /b 1
  ) 
 )
 endlocal
 cd %this%
 exit /b 0
)


rem ---------------------------------------
rem ここからカスタムコマンド実行の本処理です
rem ---------------------------------------

rem 初期処理
rmdir /s /q %mls_temp%
mkdir %mls_temp% 2>nul


setlocal
rem コマンド存在チェック
set "my_temp=%mls_temp%\temp_mls.txt"
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
rem ⇒こうしないとfor文の引数の関係でダブルクォーテーション付き引数がうまく認識されない
del %mls_temp%\mls_run.txt 2>nul
echo %* > %mls_temp%\mls_run.txt

for /f "tokens=1* delims= " %%i in (%mls_temp%\mls_run.txt) do (
 if "%is_exist_command%"=="true" (
  call %command_path%\%%i\%%i.bat %%j  
 )
)

endlocal & endlocal & cd %this%