@echo off
setlocal

rem �T���v���m�F�p

if "%1"=="" (
 echo �����̊m�F�p�ł�
 echo �������G�R�[���܂�
 
 echo --call �T�u���[�`���̃e�X�g
 
 exit /b 1
 
 
)

if "%1"=="--help" ( 
 call %common_help% %~n0 --help
 exit /b 0
)

if "%1"=="--call" (
 call :Test1
 echo �I���
 exit /b 1
)


echo �S����
echo %*
echo %1
echo %2
echo %3
echo %4
echo %5
echo %6


:Test1
echo test1
call :Test2
exit /b 0

:Test2
echo test2
call :Test3
exit /b 0

:Test3
echo test3
exit /b 0