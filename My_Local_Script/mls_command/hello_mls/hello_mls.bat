@echo off
setlocal
pushd "%~dp0"

rem 共通help出力
if "%1"=="--help" (
 type .\help\%~n0.overview
 echo.
 echo.
 type .\help\%~n0.detail
 echo.
 exit /b 0
)

echo ==Hello My Local Script=============Hello My Local Script=============Hello
echo.
echo ===============Hello My Local Script=========Hello My Local Script=========
echo.
echo　　　　　　　,.　-――‐-　._
echo　　　　 ,.　'´ /⌒ヽ　/⌒ヽ ｀ヽ
@echo　　　 /　 　 !　　ｏ l_!ｏ　　 !　　 ヽ
echo..　　/　 ,. ‐へ＿,ノ-ヽ＿_ノ‐､　　ﾍ
echo　　,'　/ ｀`'''ｰ-　 ﾞ､_,ﾉ　 -‐''" ヽ　 ',
echo　　!　^l　￣￣_　　　^|　　 _￣￣　^l　 ^|   Hello My Local Script
echo　　^l　^l　‐弋´　　　｜　　 ｀~ﾌｰ　!　^l
echo　　', ',　 　 ＞-､_　^|　_,. -'"　　 / /
echo　　　VV　 {　　 ） ￣　　　　　 / /
echo　　　 ヽ／ ｀ー'＿＿＿＿＿,/／
echo　　　 /　　　 /--/⌒ヽ----┘、
echo　　　 ^l 　 　 /　　ﾋΤﾌ　　ヽ　　＼
echo.
echo ==Hello My Local Script=============Hello My Local Script=============Hello
echo.
echo ===============Hello My Local Script=========Hello My Local Script=========
echo.