@echo off

rem args[1] : errorlevel

if not "%1"=="0" (
 echo エラーが発生しました。
 exit /b 1
 
)

exit /b 0