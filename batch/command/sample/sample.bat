@echo off
setlocal

rem サンプル確認用

if "%1"=="" (
 echo 引数の確認用です
 echo 引数をエコーします
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