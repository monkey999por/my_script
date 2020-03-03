@echo off
setlocal
pushd "%~dp0"


if "%1"=="--help" (
 call %common_help% %~n0 --help
 exit /b 0
) else if not "%1"=="" (
 echo このコマンドは--helpオプションのみサポートしています
 exit /b 1
)


rem "変数"
set "my_temp1=.\my_temp\my_temp1.txt"
set "my_temp2=.\my_temp\my_temp2.txt"
set "result=.\result\result.html"

rem "本処理 サブルーチン呼び出し"
echo helpファイルを作成します
call :PreProc
call :Overview
call :EndProc
popd
exit /b 0

:PreProc
rem "初期処理"
@rmdir /s /q my_temp 2>nul
@del %result% 2>nul
@mkdir my_temp 2>nul
@mkdir result 2>nul

rem "コマンド名と説明をtemp書き出し"
setlocal ENABLEDELAYEDEXPANSION
for /f "tokens=1* delims= " %%f in ('help') do (
 echo 検索中 %%f
 
 rem DISKPARTコマンドは管理者実行プロンプトが表示されるので飛ばします
 rem ちょっと変だけど、、、
 if not "%%f"=="DISKPART" (
  echo %%f | findstr /b "[A-Z]" >> %my_temp1%
 ) else (
  echo DISKPARTコマンドは管理者実行プロンプトが表示されるので飛ばします
 )
)
endlocal

rem "結果にDOCTYPE追加"
echo ^<^!DOCTYPE html^> > %result%
rem "js読み込み追加"
echo ^<script type="text/javascript" src="whelp.js"^>^</script^> >> %result%
exit /b 0


:Overview
rem "コマンドの概要を書き出し"
setlocal ENABLEDELAYEDEXPANSION
for /f %%f in (%my_temp1%) do (
 set "command_name=%%f"
 if "!command_name!"=="" (
  exit /b 0
 )
 
 rem "概要書き出し"
 for /f "tokens=1* delims= " %%a in ('help') do (
  if "!command_name!"=="%%a" (
   echo "書き出し中 -> !command_name!"
   echo ^<div^> >> %result%
   echo ^<div^>^<strong id=_%%a^>%%a^</strong^> >> %result%
   echo ^<span id=overview_%%a%%^>^&emsp;^&emsp;[%%b] >> %result%
   echo ^</span^> >> %result%
   call :Details %%a
   echo ^</div^> >> %result%
   echo ^</div^> >> %result%
  )
 )
)
endlocal
exit /b 0

:Details
rem "コマンドの詳細を書き出し"
setlocal ENABLEDELAYEDEXPANSION
if not "%1"=="" (
 echo ^<div id=%1 class=detail^> >> %result%
 echo ^&emsp;^&emsp;--------------------------------------------------------^<br^> >> %result%
 for /f "delims=" %%f in ('help %1') do (
  echo ^&emsp;^&emsp;%%f^<br^> >> %my_temp2%
 )
 type %my_temp2% >> %result%
 echo ^&emsp;^&emsp;--------------------------------------------------------^<br^> >> %result%
 echo ^</div^> >> %result%
 echo. >> %result%
)
endlocal
del %my_temp2% 2>nul
exit /b 0

:EndProc
rmdir /s /q %userprofile%\Downloads\result 2>nul
echo d | xcopy result %userprofile%\Downloads\result /Q /H >nul 2>&1

rem "後処理"
rmdir /s /q my_temp 2>nul
del %result% 2>nul

echo helpの書き出しが終了しました。
echo 書き出し先 -^> %userprofile%\Downloads\result\result.html

exit /b 0

