@echo off
@setlocal
pushd "%~dp0"

rem args[1]:コマンド名
rem args[2]:"-help"
rem command.helpの説明を表示する

setlocal ENABLEDELAYEDEXPANSION
for /f "tokens=1,2 delims==" %%a in (%command_help%) do (
 if not "%1"=="--help" (
  if "%1"=="%%a" (
   echo [%%a]  %%b
   echo.
   exit /b 0
  )
 ) else if "%1"=="--help" (
  echo 実行可能コマンド一覧
  echo 詳細はmls $command --helpで確認してください
  echo.
  for /f "tokens=1,2 delims==" %%a in (%command_help%) do (
   echo [%%a]  %%b
   echo.
  )
  endlocal
  exit /b 0
 )
)
endlocal
exit /b 0