rem mls�Ŏg�p�������ϐ��ł��B
rem �ق��̕ϐ����g�p����ꍇ�́A���̕ϐ����������㑤�ɒ�`����Ă���K�v������܂�

set current_path=C:\develop\my_script\My_Local_Script
set internal_path=%current_path%\internal_command
set command_path=%current_path%\command
set command_help=%current_path%\props\command.help

rem �ꎞ�t�@�C���̃p�X�B��{�I�ɂ��ׂĂ̈ꎞ�t�@�C���͂����ɏo��
set "mls_temp=%current_path%\mls_temp"

rem hello �y�[�W
set start_page=%current_path%\command\hello_mls\hello_mls.bat

rem ���ʃG���[�n���h�����O
set "error_h=%internal_path%\error\error_handling.bat"

rem ����help�o��
set "common_help=%internal_path%\help\common_help.bat"
