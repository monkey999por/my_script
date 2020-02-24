@echo off
setlocal

rem 引数で指定された区切り文字で一行のテキストファイルをリストに変換します。
rem args[1] 区切り文字　例： ";"  ","  "."   ※区切り文字はダブルクォーテーションでくくってください
rem args[2] 一行のテキストファイル

set "sdlims_out=%userprofile%\Downloads\sdlims_out.txt"

rem ヘルプを表示
if "%~1"=="--help" (
 echo 引数で指定された区切り文字で一行のテキストファイルをリストに変換します。
 echo args[1] 区切り文字　例： ";"  ","  "."   ※区切り文字はダブルクォーテーションでくくってください
 echo args[2] 一行のテキストファイル
 echo 出力先： %sdlims_out%
 exit /b 0
)

rem 引数チェック
if "%2"=="" (
 echo 引数の数が一致しません。詳細は$sdlims --helpで確認してください
 exit /b 1
)

if not exist %2 (
 echo インプットファイルが存在しません。詳細は$sdlims --helpで確認してください
 exit /b 1
)

rem 初期処理
@del %sdlims_out% 2>nul

rem 引数を取得
setlocal
set "delimiter=%~1"
set "infile=%~2"

setlocal ENABLEDELAYEDEXPANSION
call :Start !delimiter! !infile!

:Start
echo %*
echo 1かいし
for /f "tokens=1* delims=%1" %%f in (%2) do (
 echo 開始
 echo %%f
 echo %%g
 pause
 set my_data1=%%f
 set my_data2=%%g
 echo %sdlims_out%
 echo my_data1 >> %sdlims_out%
)

if not "!my_data2!"=="" (
 call :Start !delimiter! !my_data2!
) else (
 call :End
 exit /b 0
)

:End
echo 処理が正常に終了しました。
echo 書き出し先: %sdlims_out%
set /p "is_echo=結果をコンソールに表示しますか？(y/n)"
if "%is_echo%"=="y" (
 @type %sdlims_out% 2>nul
)
