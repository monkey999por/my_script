@echo off
setlocal

pushd "%~dp0"

rem $mls %command_name% &command_option...&
rem args
rem command
rem options...(for %command%)

rem �X�^�[�g�y�[�W
.\help\hello_mls.bat




rem �����`�F�b�N
if "%1"=="" (
 echo �R�}���h�����w�肵�Ă�������
 exit /b 1
)

set "command=%1"





popd


