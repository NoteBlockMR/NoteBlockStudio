function datapack_getextranotes() {
	//datapack_getextranotes()
	//allows the user to save the resource pack containing extra notes to their location of choice

	var fn, src
	if (language != 1) fn = string(get_save_filename_ext(localize_ko("Resource pack (*.zip)|*.zip"), localize_ko("Extra Note Blocks"), "", localize_ko("Save extra notes for data pack")))
	else fn = string(get_save_filename_ext(localize_ko("Resource pack (*.zip)|*.zip"), "更多音符盒", "", "为数据包保存音符盒资源包"))
	if (fn = "") return 0
	fn = enforce_extension(fn, ".zip")

	src = bundled_data_directory + "extranotes.zip"

	if file_exists(src) {
		file_copy(src, fn)
		if (language != 1) message(localize_ko("Resource pack saved successfully!"), localize_ko("Saved"))
		else message("资源包保存成功！", "保存")
	}
	else {
	}


}
