@echo off

rem MY_LOCAL_SCRIPT_PROP�ɒl���Z�b�g

set "MY_LOCAL_SCRIPT_PROP=%~1"

if not "%errorlevel%"=="0" (
 exit /b 1
) else (
 exit /b 0
)
