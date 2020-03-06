@echo off

rem �J�����g�f�B���N�g��
@set "this=%cd%"
pushd "%~dp0" 

rem ���ϐ�(��Ƀp�X�n)�ݒ�
call .\mls_props\set_mls_structure.bat

rem �����`�F�b�N
if "%1"=="" (
 echo.
 echo.
 call %start_page%
 echo.
 echo.
 echo �g�p�ł���I�v�V����: �g���� -> $mls --option
 echo  --help : �g�p�\�ȃR�}���h�̈ꗗ���\������܂��B�R�}���h�̏ڍׂ� $mls command --help ���Q�Ƃ��Ă�������
 echo.
 echo  --new --batch comand �܂��� --new --shell command : 
 echo  �V�K�R�}���h���쐬���܂��B.\mls_command�����Ƀf�B���N�g�����쐬����A�K�v�ȃt�@�C���͂��ׂĂ��̔z���ɍ쐬����܂�
 echo.
 echo  --test command : �R�}���h�̃e�X�g���s���܂��B�e�X�g�R�[�h��--new�I�v�V�����g�p���ɁA�R�}���h�i�[�f�B���N�g���Ɠ��K�w�ɍ쐬����܂�
 echo.
 echo.
 cd %this%
 exit /b 1
)

rem help�\��
if "%1"=="--help" ( 
 setlocal ENABLEDELYEDEXPANSION
 for /f "delims=" %%a in ('dir /b %mls_command%') do (
  echo.
  echo [%%a]
  for /f "delims=" %%h in ('type %mls_command%\%%a\help\%%a.overview') do (
   echo      %%h
  )
  echo.
 )
 endlocal 
 cd %this%
 exit /b 0
)


rem �J���p�B�w�肵���R�}���h���łЂȌ`���쐬����
rem ex. $mls --new [--shell or --batch] command_name
if "%1"=="--new" (
 if "%3"=="" (
  echo �R�}���h�����w�肵�Ă��������B
  cd %this%
  exit /b 1
 )
 
 setlocal ENABLEDELAYEDEXPANSION
 for /f %%c in ('dir /b %mls_command%') do (
  if "%3"=="%%c" (
   echo ���łɓ����R�}���h�����݂��܂��B�ʂ̖��O���w�肵�Ă��������B
   endlocal & cd %this%
   exit /b 1
  )
 )
 endlocal
 
 rem �o�b�`���V�F����
 setlocal ENABLEDELAYEDEXPANSION
 if "%2"=="--batch" (
  set "mls_ext=.bat"
 ) else if "%2"=="--shell" (
  set "mls_ext=.ps1"
 ) else (
  echo args[2]���s���ł��B--batch or --shell ���w�肵�Ă��������B
  cd %this% 
  exit /b 0
 )
 
 echo "�ЂȌ`���쐬���܂��F%3!mls_ext!
 
 rem �t�H���_���쐬����
 mkdir %mls_command%\%3
 
 rem �t�@�C����z�u����
 copy %mls_base%\base!mls_ext! %mls_command%\%3\%3!mls_ext!
 copy %mls_base%\base!mls_ext! %mls_command%\%3\%3_test!mls_ext!
 
 echo %mls_base%\base!mls_ext! %mls_command%\%3\%3!mls_ext!
 
 mkdir %mls_command%\%3\help
 break > %mls_command%\%3\help\%3.overview
 break > %mls_command%\%3\help\%3.detail
 
 if "%2"=="--batch" (
  echo call %mls_command%\%3\%3!mls_ext! >> %mls_command%\%3\%3_test!mls_ext!
 ) else if "%2"=="--shell" (
  echo powershell -NoProfile -ExecutionPolicy Unrestricted %mls_command%\%3\%3!mls_ext! > %mls_command%\%3\%3_test!mls_ext!
 )
 endlocal
 echo ����I�����܂���
 cd %this%
 exit /b 0
)

rem �J�X�^���R�}���h�̃e�X�g���s�p
if "%1"=="--test" (
 if "%2"=="" (
  echo �R�}���h�����w�肵�Ă��������B�g�p�ł���R�}���h�� $mls --help �Ŋm�F�ł��܂�
  cd %this%
  exit /b 1
 )

 rem .bat��.ps1�̂ǂ��炩���K�����s���邯�ǁA�ʂɎ��Q�Ȃ����A�A�A
 call %mls_command%\%2\%2_test.bat 2>nul
 call powershell -NoProfile -ExecutionPolicy Unrestricted %mls_command%\%2\%2_test.ps1 2>nul

 cd %this%
 exit /b 0
)


rem ---------------------------------------
rem ��������J�X�^���R�}���h���s�̖{�����ł�
rem ---------------------------------------

rem ��������
rmdir /s /q %mls_temp%
mkdir %mls_temp% 2>nul

rem �R�}���h���݃`�F�b�N
setlocal ENABLEDELAYEDEXPANSION
for /f %%i in ('dir /b %mls_command%') do (
 if "%1"=="%%i" (
  set "is_exist_command=true"
  call :Run %*
  endlocal & cd %this%
  exit /b 0
 ) 
)

echo �R�}���h�����݂��܂���
endlocal & cd %this%
exit /b 1

:Run
rem �J�X�^���R�}���h���s
rem ��������x�t�@�C���ɏ����o���āA�����for�X�e�[�g�����g�ɓn��
rem �˂������Ȃ���for���̈����̊֌W�Ń_�u���N�H�[�e�[�V�����t�����������܂��F������Ȃ�
del %mls_temp%\mls_run.txt 2>nul
echo %* > %mls_temp%\mls_run.txt

for /f "tokens=1* delims= " %%i in (%mls_temp%\mls_run.txt) do (
 if "%is_exist_command%"=="true" (
  call %mls_command%\%%i\%%i.bat %%j 2>nul
  call powershell -NoProfile -ExecutionPolicy Unrestricted %mls_command%\%%i\%%i.ps1 %%j 2>nul
 )
)

endlocal & cd %this%