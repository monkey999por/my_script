@echo off
setlocal
pushd "%~dp0"

rem ã§í helpèoóÕ
if "%1"=="--help" (
 type .\help\%~n0.overview
 echo.
 echo.
 type .\help\%~n0.detail
 echo.
 exit /b 0
)
