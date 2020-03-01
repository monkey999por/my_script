@echo off
rem �J�����g�f�B���N�g��
@set "this=%cd%"
pushd "%~dp0" 

rem ���ϐ�(��Ƀp�X�n)�ݒ�
call .\props\env_path_set.bat

rem $mls %command_name% &command_option...&
rem args
rem command
rem options...(for %command%)

rem �����`�F�b�N
if "%1"=="" (
 call %start_page%
 echo �R�}���h�����w�肵�Ă�������
 cd %this%
 exit /b 1
)

rem help�\��
if "%1"=="--help" ( %common_help% %1 )

rem �J���p�B�w�肵���R�}���h���łЂȌ`���쐬����
if "%1"=="--new" (
 if "%2"=="" (
  echo �R�}���h�����w�肵�Ă��������B
  exit /b 1
 )
 
 setlocal ENABLEDELAYEDEXPANSION
 for /f %%c in ('dir /b %command_path%') do (
  if "%2"=="%%c" (
   echo ���łɓ����R�}���h�����݂��܂��B�ʂ̖��O���w�肵�Ă��������B
   exit /b 1
  )
 )
 endlocal
 
 echo �J���p�ł��B
 echo "�ЂȌ`���쐬���܂��F%2"
 
 rem �t�H���_���쐬����
 mkdir %command_path%\%2
 if not errorlevel 0 ( echo �ُ�I�����܂��� & exit /b 1 )
 
 rem �t�@�C����z�u����
 copy %current_path%\�ЂȌ`.bat %command_path%\%2\%2.bat
 if not errorlevel 0 ( echo �ُ�I�����܂��� & exit /b 1 )
 
 copy %current_path%\�ЂȌ`.bat %command_path%\%2\%2_test.bat
 if not errorlevel 0 ( echo �ُ�I�����܂��� & exit /b 1 )
 
 echo call %command_path%\%2\%2.bat >> %command_path%\%2\%2_test.bat
 if not errorlevel 0 ( echo �ُ�I�����܂��� & exit /b 1 )
 
 rem command.help��help��ǉ�����
 rem ���e��"command.help�ɐ����������Ă���܂���"
 echo %2=command.help�ɐ����������Ă���܂��� >> %command_help%
 if not errorlevel 0 ( echo �ُ�I�����܂��� & exit /b 1 )
 
 
 echo ����I�����܂���
 exit /b 0
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
rem ��������x�t�@�C���ɏ����o���āA�����for�X�e�[�g�����g�ɓn��
rem �˂������Ȃ���for���̈����̊֌W�Ń_�u���N�H�[�e�[�V�����t�����������܂��F������Ȃ�
del %temp%\mls_run.txt
echo %* > %temp%\mls_run.txt

for /f "tokens=1* delims= " %%i in (%temp%\mls_run.txt) do (
 if "%is_exist_command%"=="true" (
  call %command_path%\%%i\%%i.bat %%j  
 )
)

endlocal & endlocal & cd %this%