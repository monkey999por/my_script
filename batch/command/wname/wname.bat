@echo off
@pushd "%~dp0"
setlocal

rem ���ϐ�path�ɂ���pathext�̊g���q�̃t�@�C���i�����O�����Ŏ��s�\�ȃt�@�C���j�̈ꗗ���쐬���܂�
rem ���͂����񗧂ăt�@�C��������
rem ���Ƃ�path��pathext�̓t�@�C�����`���ēǂݍ��ނ悤�ɂ���

rem �����o���� default %userprofile%\Downloads\result_wname.txt

if "%1"=="--help" (
 echo.
 echo ���ϐ�path�ɂ���pathext�̊g���q�̃t�@�C���i�����O�����Ŏ��s�\�ȃt�@�C���j�̈ꗗ���쐬���܂�
 echo �o�͐�F%cd%\output\temp_wname.txt
 exit /b 0
)

setlocal  ENABLEDELAYEDEXPANSION
for /f "delims=" %%f in (.\input\my_path.txt) do (
 set "my_path=%%f"
 for /f "delims=" %%g in (.\input\my_pathext.txt) do (
  set "my_pathext=%%g"
  
  rem �������Č��ʂ��e�L�X�g�ɏ����o��
  
  @dir /b "!my_path!\*!my_pathext!" >> .\output\temp_wname.txt 2>nul
 )
)

rem �p�X���o��悤�ɐ��`
for /f "delims=" %%f in (.\output\temp_wname.txt) do (
 echo ������ %%f
 @where %%f >> .\output\wname.txt
)
del .\output\temp_wname.txt

popd

