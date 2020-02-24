@echo off
@pushd "%~dp0"
setlocal

rem 環境変数pathにあるpathextの拡張子のファイル（＝名前だけで実行可能なファイル）の一覧を作成します
rem 今はおぜん立てファイルがある
rem あとでpathとpathextはファイル整形して読み込むようにする

rem 書き出し先 default %userprofile%\Downloads\result_wname.txt

if "%1"=="--help" (
 echo.
 echo 環境変数pathにあるpathextの拡張子のファイル（＝名前だけで実行可能なファイル）の一覧を作成します
 echo 出力先：%cd%\output\temp_wname.txt
 exit /b 0
)

setlocal  ENABLEDELAYEDEXPANSION
for /f "delims=" %%f in (.\input\my_path.txt) do (
 set "my_path=%%f"
 for /f "delims=" %%g in (.\input\my_pathext.txt) do (
  set "my_pathext=%%g"
  
  rem 検索して結果をテキストに書き出し
  
  @dir /b "!my_path!\*!my_pathext!" >> .\output\temp_wname.txt 2>nul
 )
)

rem パスが出るように整形
for /f "delims=" %%f in (.\output\temp_wname.txt) do (
 echo 検索中 %%f
 @where %%f >> .\output\wname.txt
)
del .\output\temp_wname.txt

popd

