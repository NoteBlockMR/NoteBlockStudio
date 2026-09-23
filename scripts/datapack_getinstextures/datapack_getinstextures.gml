function datapack_getinstextures() {
	//datapack_getinstextures()
	//allows the user to save the resource pack containing note block textures corresponding to the default instruments.

	var fn, src
	if (language != 1) fn = string(get_save_filename_ext(localize_ko("Resource pack (*.zip)|*.zip"), localize_ko("Note Block Textures"), "", localize_ko("Replaces instrument blocks with note block textures.")))
	else fn = string(get_save_filename_ext(localize_ko("Resource pack (*.zip)|*.zip"), "音符盒纹理", "", "用自定义纹理替换音色方块"))
	if (fn = "") return 0

	src = data_directory + "instrumenttextures.zip"

	if file_exists(src) {
		file_copy(src, fn)
		if (language != 1) message(localize_ko("Resource pack saved successfully!"), localize_ko("Saved"))
		else message("资源包保存成功！", "保存")
	}
	else {
		if (language != 1) message(localize_ko("File not found!"),localize_ko("Error"))
		else message("找不到文件！","错误")
	}


}
