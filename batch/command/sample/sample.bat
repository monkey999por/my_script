@echo off
setlocal

rem ���[�f�B���O�̉�ʂł�
rem ���C�A�E�g�͊J���҂̒[���ɍ��킹�ĕ\�����Ă��܂��̂ŁA�ݒ�l���قȂ�Ƃ��܂��\������܂���A�A�A
rem ������������g���\��Ȃ���


rem �ő�\�������� 66

set max===================================================================

setlocal ENABLEDELAYEDEXPANSION

for /L %%a in (1,1,1000) do (
 rem echo���镶�����쐬
 set str=%max:~1,%%a%
 echo !str!
 rem %1:echo���镶�� %2:���[�v��
 rem call :LoopEcho !str! 100
 
 
)
 
:LoopEcho
for /L %%c in (1,1,%2) do (
 echo %1
)
endlocal



