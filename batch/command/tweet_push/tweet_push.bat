@echo off
setlocal ENABLEDELAYEDEXPANSION

rem git push + �c�C�b�^�[�ɓ��e����
rem �O��Fgit.exe�Ƀp�X��ʂ��Acmd.exe����{�o�b�`���N��

rem �c�C�[�g���e 
rem url(remote_repository)
rem branch
rem �c�C�[�g���e

rem ������git repository�ł����H
git fetch
if not "%errorlevel%"=="0" (
 echo git���|�W�g���Ŏ��s���Ă�������
 exit /b 1
)

rem temp�t�@�C��
set "temp_file_name=%temp%\tweet_push.txt"

rem url(remote_repository)�擾
rem �Ƃ肠���� origin�����E�E�E
git config --get remote.origin.url > %temp_file_name%

for /f %%f in (%temp_file_name%) do (
 set remote_url=%%f
)

rem �u�����`���擾
rem ���[�J���u�����`�ƃ����[�g�u�����`�̖��O�͍��킹�Ă�O��

git branch --all > %temp_file_name%

for /f "tokens=1,2" %%f in (%temp_file_name%) do (
 if "%%f"=="*" (
  set branch=%%g
 )
)

if not "%temp_file_name%"=="" (
 del %temp_file_name%
)


rem �c�C�[�g���e�擾
set /p tweet_status=�c�C�[�g���e�F�@

rem �m�F���b�Z�[�W
:IsTweetAndGitPushLabel
cls
echo ���̓��e�Ńc�C�[�g���܂��B��낵���ł����H(y/n)
echo remote: %remote_url%
echo branch: %branch%
echo tweet: %tweet_status%

set /p is_tweet_and_git_push=

if "%is_tweet_and_git_push%"=="n" (
 echo.
 echo $git push�ƃc�C�[�g�𒆒f���܂���
 exit /b 0
)else if "%is_tweet_and_git_push%"=="y" (
 goto Git
)else (
 goto IsTweetAndGitPushLabel
) 


:Git
git push

if "%errorlevel%"=="0" (
 set tweet_message=[remote: %remote_url% ] [branch: %branch%] [comment: %tweet_status%]
 echo !tweet_message!
 twurl -r 'status=!tweet_message!' /1.1/statuses/update.json
)
