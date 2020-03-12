rem mlsで使用される環境変数です。
rem ほかの変数を使用する場合は、その変数が自分より上側に定義されている必要があります

rem ディレクトリ構成です。ディレクトリ構成を変更する場合はここを変えれば良いはず
set current_path=C:\develop\my_script\My_Local_Script
rem current_path直下
set mls_props=%current_path%\mls_props
set mls_temp=%current_path%\mls_temp
set mls_command=%current_path%\mls_command
set mls_function=%current_path%\mls_function
set mls_base=%current_path%\mls_base


rem hello ページ
set start_page=%mls_command%\hello_mls\hello_mls.bat

rem ビルド用ルート
set build_root=%userprofile%\Downloads\My_Local_Script