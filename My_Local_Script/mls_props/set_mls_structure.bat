rem mls�Ŏg�p�������ϐ��ł��B
rem �ق��̕ϐ����g�p����ꍇ�́A���̕ϐ����������㑤�ɒ�`����Ă���K�v������܂�

rem �f�B���N�g���\���ł��B�f�B���N�g���\����ύX����ꍇ�͂�����ς���Ηǂ��͂�
set current_path=C:\develop\my_script\My_Local_Script
rem current_path����
set mls_props=%current_path%\mls_props
set mls_temp=%current_path%\mls_temp
set mls_command=%current_path%\mls_command
set mls_function=%current_path%\mls_function



set command_help=%mls_props%\command.help



rem hello �y�[�W
set start_page=%mls_command%\hello_mls\hello_mls.bat

rem ���ʃG���[�n���h�����O
set "error_h=%mls_function%\error\error_handling.bat"

rem ����help�o��
set "common_help=%mls_function%\help\common_help.bat"
