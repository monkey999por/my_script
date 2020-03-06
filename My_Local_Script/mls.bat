@echo off

rem カレントディレクトリ
@set "this=%cd%"
pushd "%~dp0" 

rem 環境変数(主にパス系)設定
call .\mls_props\set_mls_structure.bat

rem 引数チェック
if "%1"=="" (
 call %start_page%
 echo $mls --helpで使用可能なコマンドの一覧が表示されます
 cd %this%
 exit /b 1
)

rem help表示
if "%1"=="--help" ( 
 setlocal ENABLEDELYEDEXPANSION
 for /f "delims=" %%a in ('dir /b %mls_command%') do (
  echo.
  echo [%%a]
  for /f "delims=" %%h in ('type %mls_command%\%%a\help\%%a.overview') do (
   echo      %%h
  )
  echo.
 )
 endlocal 
 cd %this%
 exit /b 0
)


rem 開発用。指定したコマンド名でひな形を作成する
rem ex. $mls --new [--shell or --batch] command_name
if "%1"=="--new" (
 if "%3"=="" (
  echo コマンド名を指定してください。
  cd %this%
  exit /b 1
 )
 
 setlocal ENABLEDELAYEDEXPANSION
 for /f %%c in ('dir /b %mls_command%') do (
  if "%3"=="%%c" (
   echo すでに同名コマンドが存在します。別の名前を指定してください。
   endlocal & cd %this%
   exit /b 1
  )
 )
 endlocal
 
 rem バッチかシェルか
 if "%2"=="--batch" (
  set "mls_ext=.bat"
 ) else if "%2"=="--shell" (
  set "mls_ext=.ps1"
 ) else (
  echo args[2]が不正です。--batch or --shell を指定してください。
  endlocal & cd %this% 
  exit /b 0
 )
 
 echo "ひな形を作成します：%3%mls_ext%
 
 rem フォルダを作成する
 mkdir %mls_command%\%3
 
 rem ファイルを配置する
 copy %mls_base%\base%mls_ext% %mls_command%\%3\%3%mls_ext%
 copy %mls_base%\base%mls_ext% %mls_command%\%3\%3_test%mls_ext%
 mkdir %mls_command%\%3\help
 break > %mls_command%\%3\help\%3.overview
 break > %mls_command%\%3\help\%3.detail
 
 if "%2"=="--batch" (
  echo call %mls_command%\%3\%3%mls_ext% >> %mls_command%\%3\%3_test%mls_ext%
 ) else if "%2"=="--shell" (
  echo powershell -NoProfile -ExecutionPolicy Unrestricted %mls_command%\%3\%3%mls_ext% > %mls_command%\%3\%3_test%mls_ext%
 )
 
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
 for /f %%c in ('dir /b %mls_command%') do (
  if "%2"=="%%c" (
   call %mls_command%\%2\%2_test.bat
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
dir /b %mls_command% > %my_temp%
	
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
  call %mls_command%\%%i\%%i.bat %%j  
 )
)

endlocal & endlocal & cd %this%