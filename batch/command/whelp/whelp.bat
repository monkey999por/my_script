@echo off
setlocal
pushd "%~dp0"


if "%1"=="--help" (
 call %common_help% %~n0 --help
 exit /b 0
) else if not "%1"=="" (
 echo ���̃R�}���h��--help�I�v�V�����̂݃T�|�[�g���Ă��܂�
 exit /b 1
)


rem "�ϐ�"
set "my_temp1=.\my_temp\my_temp1.txt"
set "my_temp2=.\my_temp\my_temp2.txt"
set "result=.\result\result.html"

rem "�{���� �T�u���[�`���Ăяo��"
echo help�t�@�C�����쐬���܂�
call :PreProc
call :Overview
call :EndProc
popd
exit /b 0

:PreProc
rem "��������"
@rmdir /s /q my_temp 2>nul
@del %result% 2>nul
@mkdir my_temp 2>nul
@mkdir result 2>nul

rem "�R�}���h���Ɛ�����temp�����o��"
setlocal ENABLEDELAYEDEXPANSION
for /f "tokens=1* delims= " %%f in ('help') do (
 echo ������ %%f
 
 rem DISKPART�R�}���h�͊Ǘ��Ҏ��s�v�����v�g���\�������̂Ŕ�΂��܂�
 rem ������ƕς����ǁA�A�A
 if not "%%f"=="DISKPART" (
  echo %%f | findstr /b "[A-Z]" >> %my_temp1%
 ) else (
  echo DISKPART�R�}���h�͊Ǘ��Ҏ��s�v�����v�g���\�������̂Ŕ�΂��܂�
 )
)
endlocal

rem "���ʂ�DOCTYPE�ǉ�"
echo ^<^!DOCTYPE html^> > %result%
rem "js�ǂݍ��ݒǉ�"
echo ^<script type="text/javascript" src="whelp.js"^>^</script^> >> %result%
exit /b 0


:Overview
rem "�R�}���h�̊T�v�������o��"
setlocal ENABLEDELAYEDEXPANSION
for /f %%f in (%my_temp1%) do (
 set "command_name=%%f"
 if "!command_name!"=="" (
  exit /b 0
 )
 
 rem "�T�v�����o��"
 for /f "tokens=1* delims= " %%a in ('help') do (
  if "!command_name!"=="%%a" (
   echo "�����o���� -> !command_name!"
   echo ^<div^> >> %result%
   echo ^<div^>^<strong id=_%%a^>%%a^</strong^> >> %result%
   echo ^<span id=overview_%%a%%^>^&emsp;^&emsp;[%%b] >> %result%
   echo ^</span^> >> %result%
   call :Details %%a
   echo ^</div^> >> %result%
   echo ^</div^> >> %result%
  )
 )
)
endlocal
exit /b 0

:Details
rem "�R�}���h�̏ڍׂ������o��"
setlocal ENABLEDELAYEDEXPANSION
if not "%1"=="" (
 echo ^<div id=%1 class=detail^> >> %result%
 echo ^&emsp;^&emsp;--------------------------------------------------------^<br^> >> %result%
 for /f "delims=" %%f in ('help %1') do (
  echo ^&emsp;^&emsp;%%f^<br^> >> %my_temp2%
 )
 type %my_temp2% >> %result%
 echo ^&emsp;^&emsp;--------------------------------------------------------^<br^> >> %result%
 echo ^</div^> >> %result%
 echo. >> %result%
)
endlocal
del %my_temp2% 2>nul
exit /b 0

:EndProc
rmdir /s /q %userprofile%\Downloads\result 2>nul
echo d | xcopy result %userprofile%\Downloads\result /Q /H >nul 2>&1

rem "�㏈��"
rmdir /s /q my_temp 2>nul
del %result% 2>nul

echo help�̏����o�����I�����܂����B
echo �����o���� -^> %userprofile%\Downloads\result\result.html

exit /b 0

