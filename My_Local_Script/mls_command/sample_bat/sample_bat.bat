@echo off
setlocal
pushd "%~dp0"

rem 共通help出力
if "%1"=="--help" (
 type .\help\%~n0.overview
 echo.
 echo.
 type .\help\%~n0.detail
 echo.
 exit /b 0
)
rem 内部用コマンドのラッパーを実行する
if "%1"=="" (
 echo 引数の確認用です
 echo 引数をエコーします
 
 echo --call サブルーチンのテスト
 
 exit /b 1
 
 
)

if "%1"=="--help" ( 
 call %common_help% %~n0 --help
 exit /b 0
)

if "%1"=="--call" (
 call :Test1
 echo 終わり
 exit /b 1
)


echo 全引数
echo %*
echo %1
echo %2
echo %3
echo %4
echo %5
echo %6


:Test1
echo test1
call :Test2
exit /b 0

:Test2
echo test2
call :Test3
exit /b 0

:Test3
echo test3
exit /b 0