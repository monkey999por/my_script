rem mlsで使用される環境変数です。
rem ほかの変数を使用する場合は、その変数が自分より上側に定義されている必要があります

rem ディレクトリ構成です。ディレクトリ構成を変更する場合はここを変えれば良いはず
set current_path=C:\develop\my_script\My_Local_Script
set mls_batch=%current_path%\mls_batch
set mls_temp=%current_path%\mls_temp




set internal_path=%current_path%\internal_command

set command_help=%current_path%\props\command.help

rem hello ページ
set start_page=%current_path%\command\hello_mls\hello_mls.bat

rem 共通エラーハンドリング
set "error_h=%internal_path%\error\error_handling.bat"

rem 共通help出力
set "common_help=%internal_path%\help\common_help.bat"
