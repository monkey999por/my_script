@echo off
@setlocal
pushd "%~dp0"

rem args[1]:�R�}���h��
rem args[2]:"-help"
rem command.help�̐�����\������

setlocal ENABLEDELAYEDEXPANSION
for /f "tokens=1,2 delims==" %%a in (%command_help%) do (
 if not "%1"=="--help" (
  if "%1"=="%%a" (
   echo [%%a]  %%b
   echo.
   exit /b 0
  )
 ) else if "%1"=="--help" (
  echo ���s�\�R�}���h�ꗗ
  echo �ڍׂ�mls $command --help�Ŋm�F���Ă�������
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