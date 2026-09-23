/// @description  control_end()
/// @function  control_end
function control_end() {

	korean_fonts_free()
	confirm(1)
	save_settings()
	if (!isplayer) backup_delete_own_instance()


}
