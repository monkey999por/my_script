@echo off

set "MY_LOCAL_SCRIPT_PROP="

setlocal

rem プロパティファイルを読み込み、該当するグループ、キーの値をアプリケーションで使用する変数（MY_LOCAL_SCRIPT_PROP）に設定する。
rem 引数
rem %1: group
rem %2: key(prop)

set "main_properties_path=.\..\..\props\main.properties"
set "group=%1"
set "key=%2"


if "%group%"=="" (
 echo グループ名（$group）が指定されていません。
 exit /b 1
)
if "%key%"=="" (
 echo キー（prop）が指定されていません。
 exit /b 1
)
setlocal ENABLEDELAYEDEXPANSION
rem プロパティの読み込み
for /f "tokens=1,2 delims==" %%f in (%main_properties_path%) do (
 rem 初期化
 set "prop=%%f"
 set "value=%%g"
 if "!prop:~0,1!"=="$" (
  set "group_name=!prop:$=!"
 )
 
 if "%group%"=="!group_name!" (
  set "read_flg=0"
 )else (
  set "read_flg=1"
 )

 if "!read_flg!"=="0" (
  if not "!prop:~0,1!"=="$" if not "!prop:~0,1!"=="#" (
   if "%key%"=="!prop!" (
    set "MY_LOCAL_SCRIPT_PROP=!value!"
    goto :SetProp 
   )
  )
 )
)

:SetProp
endlocal && endlocal && set "MY_LOCAL_SCRIPT_PROP=%MY_LOCAL_SCRIPT_PROP%"
exit /b %errorlevel%


