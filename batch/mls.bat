@echo off
rem �J�����g�f�B���N�g��
set "this=%cd%"

echo %this%
pushd "%~dp0" 
rem ���ϐ�(��Ƀp�X�n)�ݒ�

call .\props\env_path_set.bat


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
 cd %this%
 exit /b 1
)


setlocal
rem �R�}���h���݃`�F�b�N
set "my_temp=%temp%\temp_mls.txt"
dir /b %command_path% > %my_temp%
	
setlocal ENABLEDELAYEDEXPANSION
for /f %%i in (%my_temp%) do (
 if "%1"=="%%i" (
  set "is_exist_command=true"
  call :Run %*
  endlocal & endlocal & cd %this%
  exit /b 0
 ) 
)

echo �R�}���h�����݂��܂���
endlocal & endlocal & cd %this%
exit /b 1

:Run
rem �J�X�^���R�}���h���s
for /f "tokens=1*" %%i in ("%*") do (
 if "%is_exist_command%"=="true" (
  call %command_path%\%%i\%%i.bat %%j  
 )
)



endlocal & endlocal & cd %this%