@echo off
setlocal

rem ローディングの画面です
rem レイアウトは開発者の端末に合わせて表示していますので、設定値が異なるとうまく表示されません、、、
rem そもそもこれ使う予定ないん


rem 最大表示文字列長 66

set max===================================================================

setlocal ENABLEDELAYEDEXPANSION

for /L %%a in (1,1,1000) do (
 rem echoする文字を作成
 set str=%max:~1,%%a%
 echo !str!
 rem %1:echoする文字 %2:ループ回数
 rem call :LoopEcho !str! 100
 
 
)
 
:LoopEcho
for /L %%c in (1,1,%2) do (
 echo %1
)
endlocal



