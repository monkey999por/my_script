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
call %start_page%

rem �����`�F�b�N
if "%1"=="" (
 echo �R�}���h�����w�肵�Ă�������
 exit /b 1
)


set "command=%1"





popd



