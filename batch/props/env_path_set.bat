rem mlsで使用される環境変数です。
rem ほかの変数を使用する場合は、その変数が自分より上側に定義されている必要があります

set current_path=C:\develop\my_script\batch
set internal_path=C:\develop\my_script\batch\internal_command
set command_path=%current_path%\command
set start_page=%current_path%\command\hello_mls\hello_mls.bat

rem 共通エラーハンドリング
set "error_h=%internal_path%\error\error_handling.bat"
