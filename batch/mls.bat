@echo off
pushd "%~dp0"
rem ���ϐ�(��Ƀp�X�n)�ݒ�

call .\props\env_path_set.bat

setlocal



rem $mls %command_name% &command_option...&
rem args
rem command
rem options...(for %command%)

rem �X�^�[�g�y�[�W
rem call %start_page%

rem �����`�F�b�N
if "%1"=="" (
 call %start_page%
 echo �R�}���h�����w�肵�Ă�������
 popd
 exit /b 1
)

rem �R�}���h���݃`�F�b�N
for /f %%i in ('dir /b %command_path%') do (
 if "%1"=="%%i" (
  set "is_exist_command=true"
  call :Run %*
 ) else (
  exit /b 1
 )
 
)

:Run
rem �J�X�^���R�}���h���s
setlocal ENABLEDELAYEDEXPANSION
for /f "tokens=1*" %%i in ("%*") do (
 if "%is_exist_command%"=="true" (
  call %command_path%\%%i\%%i.bat %%j
 )
 
)

popd



