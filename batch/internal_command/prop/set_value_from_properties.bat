@echo off

set "MY_LOCAL_SCRIPT_PROP="

setlocal

rem �v���p�e�B�t�@�C����ǂݍ��݁A�Y������O���[�v�A�L�[�̒l���A�v���P�[�V�����Ŏg�p����ϐ��iMY_LOCAL_SCRIPT_PROP�j�ɐݒ肷��B
rem ����
rem %1: group
rem %2: key(prop)

set "main_properties_path=.\..\..\props\main.properties"
set "group=%1"
set "key=%2"


if "%group%"=="" (
 echo �O���[�v���i$group�j���w�肳��Ă��܂���B
 exit /b 1
)
if "%key%"=="" (
 echo �L�[�iprop�j���w�肳��Ă��܂���B
 exit /b 1
)
setlocal ENABLEDELAYEDEXPANSION
rem �v���p�e�B�̓ǂݍ���
for /f "tokens=1,2 delims==" %%f in (%main_properties_path%) do (
 rem ������
 set "prop=%%f"
 set "value=%%g"
 if "!prop:~0,1!"=="$" (
  set "group_name=!prop:$=!"
 )
 
 if "%group%"=="!group_name!" (
  set "read_flg=0"
 )else (
  set "read_flg=1"
 )

 if "!read_flg!"=="0" (
  if not "!prop:~0,1!"=="$" if not "!prop:~0,1!"=="#" (
   if "%key%"=="!prop!" (
    set "MY_LOCAL_SCRIPT_PROP=!value!"
    goto :SetProp 
   )
  )
 )
)

:SetProp
endlocal && endlocal && set "MY_LOCAL_SCRIPT_PROP=%MY_LOCAL_SCRIPT_PROP%"
exit /b %errorlevel%


