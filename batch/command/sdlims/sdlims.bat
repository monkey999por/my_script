@echo off
setlocal

rem �����Ŏw�肳�ꂽ��؂蕶���ň�s�̃e�L�X�g�t�@�C�������X�g�ɕϊ����܂��B
rem args[1] ��؂蕶���@��F ";"  ","  "."   ����؂蕶���̓_�u���N�H�[�e�[�V�����ł������Ă�������
rem args[2] ��s�̃e�L�X�g�t�@�C��

set "sdlims_out=%userprofile%\Downloads\sdlims_out.txt"

rem �w���v��\��
if "%~1"=="--help" (
 echo �����Ŏw�肳�ꂽ��؂蕶���ň�s�̃e�L�X�g�t�@�C�������X�g�ɕϊ����܂��B
 echo args[1] ��؂蕶���@��F ";"  ","  "."   ����؂蕶���̓_�u���N�H�[�e�[�V�����ł������Ă�������
 echo args[2] ��s�̃e�L�X�g�t�@�C��
 echo �o�͐�F %sdlims_out%
 exit /b 0
)

rem �����`�F�b�N
if "%2"=="" (
 echo �����̐�����v���܂���B�ڍׂ�$sdlims --help�Ŋm�F���Ă�������
 exit /b 1
)

if not exist %2 (
 echo �C���v�b�g�t�@�C�������݂��܂���B�ڍׂ�$sdlims --help�Ŋm�F���Ă�������
 exit /b 1
)

rem ��������
@del %sdlims_out% 2>nul

rem �������擾
setlocal
set "delimiter=%~1"
set "infile=%~2"

setlocal ENABLEDELAYEDEXPANSION
call :Start !delimiter! !infile!

:Start
echo %*
echo 1������
for /f "tokens=1* delims=%1" %%f in (%2) do (
 echo �J�n
 echo %%f
 echo %%g
 pause
 set my_data1=%%f
 set my_data2=%%g
 echo %sdlims_out%
 echo my_data1 >> %sdlims_out%
)

if not "!my_data2!"=="" (
 call :Start !delimiter! !my_data2!
) else (
 call :End
 exit /b 0
)

:End
echo ����������ɏI�����܂����B
echo �����o����: %sdlims_out%
set /p "is_echo=���ʂ��R���\�[���ɕ\�����܂����H(y/n)"
if "%is_echo%"=="y" (
 @type %sdlims_out% 2>nul
)
