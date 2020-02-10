@echo off
setlocal ENABLEDELAYEDEXPANSION

rem git push + ツイッターに投稿する
rem 前提：git.exeにパスを通す、cmd.exeから本バッチを起動

rem ツイート内容 
rem url(remote_repository)
rem branch
rem ツイート内容

rem ここはgit repositoryですか？
git fetch
if not "%errorlevel%"=="0" (
 echo gitリポジトリで実行してください
 exit /b 1
)

rem tempファイル
set "temp_file_name=%temp%\tweet_push.txt"

rem url(remote_repository)取得
rem とりあえず originだけ・・・
git config --get remote.origin.url > %temp_file_name%

for /f %%f in (%temp_file_name%) do (
 set remote_url=%%f
)

rem ブランチ名取得
rem ローカルブランチとリモートブランチの名前は合わせてる前提

git branch --all > %temp_file_name%

for /f "tokens=1,2" %%f in (%temp_file_name%) do (
 if "%%f"=="*" (
  set branch=%%g
 )
)

if not "%temp_file_name%"=="" (
 del %temp_file_name%
)


rem ツイート内容取得
set /p tweet_status=ツイート内容：　

rem 確認メッセージ
:IsTweetAndGitPushLabel
cls
echo この内容でツイートします。よろしいですか？(y/n)
echo remote: %remote_url%
echo branch: %branch%
echo tweet: %tweet_status%

set /p is_tweet_and_git_push=

if "%is_tweet_and_git_push%"=="n" (
 echo.
 echo $git pushとツイートを中断しました
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
