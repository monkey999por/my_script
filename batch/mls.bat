@echo off
pushd "%~dp0"
rem ���ϐ�(��Ƀp�X�n)�ݒ�

for /f "delims=" %%s in (.\props\env_path.sete) do (
 %%s
 echo %%s
)

echo %start_page%
exit /b 0

setlocal



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



