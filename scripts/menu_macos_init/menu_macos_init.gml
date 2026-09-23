function menu_macos_init(){
	var str, a, b, c;
	if (os_type = os_macosx) {
		macos_menu_clear()
		var current_song = songs[song]
		var text_editing = (text_focus != -1)
		var edit_undo_inactive = (text_editing || current_song.historypos = current_song.historylen)
		var edit_redo_inactive = (text_editing || current_song.historypos = 0)
		var edit_copy_inactive = (!text_editing && current_song.selected = 0)
		var edit_cut_inactive = ((text_editing && text_focus_readonly) || (!text_editing && current_song.selected = 0))
		var edit_paste_inactive = ((text_editing && text_focus_readonly) || (!text_editing && selection_copied = ""))
		var edit_delete_inactive = ((text_editing && text_focus_readonly) || (!text_editing && current_song.selected = 0))
		var edit_select_all_inactive = (!text_editing && current_song.totalblocks = 0)
		if (language != 1) {
			macos_create_menu_ext(localize_ko("Help"), "help", icon_menubar(icons.HELP) + localize_ko("Tutorial videos|\\|Part 1: Composing note block music|Part 2: Opening MIDI files|Part 3: Importing songs into Minecraft|Part 4: Editing songs made in Minecraft     |-|F1$View all|/|-|") + icon_menubar(icons.INTERNET) + localize_ko("Website...|GitHub...|Discord server...|Report a bug...|Donate...|-|Changelist...|About..."))
			str = ""
			customstr = ""
			insmenu = 1
			for (a = 0; a < ds_list_size(current_song.instrument_list); a++) {
				var ins = current_song.instrument_list[| a];
				if (ins.user)
				    customstr += check(current_song.instrument = ins) + clean(ins.name) + "|"
				else{
					if(a < 9){
							str += check(current_song.instrument = ins) + get_hotkey_menubar("ins_ctrl") + string((a + 1) % 10) + "$" + clean(ins.name) + "|"
					}else if (a < 19){
						str += check(current_song.instrument = ins) + get_hotkey_menubar("ins_ctrl_shift") + string((a + 2) % 10) + "$" + clean(ins.name) + "|"
					} else {
							str += check(current_song.instrument = ins) + clean(ins.name) + "|"
						}
				}
				if (a % 25 == 0 && a > 1 && a < ds_list_size(current_song.instrument_list) - 1) {
					customstr += localize_ko("-|More...|\\|")
					insmenu++
				}
			}
			if (!isplayer) macos_create_menu_ext(localize_ko("Settings"), "settings", localize_ko("Instrument|\\|") + str + condstr(customstr != "", "-|") + customstr + string_repeat("/|", insmenu) +
				                icon_menubar(icons.INSTRUMENTS)+localize_ko("Instrument settings...|Import sounds from Minecraft...|/|-|") + icon_menubar(icons.INFORMATION) + localize_ko("Song info...|") + icon_menubar(icons.PROPERTIES) + localize_ko("Song properties...|Song stats...|-|") + icon_menubar(icons.MIDI_INPUT) + localize_ko("MIDI device manager"))
			else macos_create_menu_ext(localize_ko("Settings"), "settingsp", icon_menubar(icons.INFORMATION) + localize_ko("Song info...|") + localize_ko("Song stats..."))
			if (!isplayer) {
				str = ""
				customstr = ""
				insmenu = 1
				for (a = 0; a < ds_list_size(current_song.instrument_list); a += 1) {
				    var ins = current_song.instrument_list[| a];
				    if (ins.user)
				        customstr += localize_ko("...to ") + clean(ins.name) + "|"
				    else
				        str += localize_ko("...to ") + clean(ins.name) + "|"
					if (a % 25 == 0 && a > 1 && a < ds_list_size(current_song.instrument_list) - 1) {
						customstr += localize_ko("-|More...|\\|")
						insmenu++
					}
				}
				// title is "Edit" + no_wide_space, otherwise fails
				macos_create_menu_ext(localize_ko("Edit​"), "edit", inactive(edit_undo_inactive) + icon_menubar(icons.UNDO - edit_undo_inactive) + get_hotkey_menubar("undo") + localize_ko("$Undo|")+
				                            inactive(edit_redo_inactive) + icon_menubar(icons.REDO - edit_redo_inactive) + get_hotkey_menubar("redo") + localize_ko("$Redo|-|")+
				                            inactive(edit_copy_inactive) + icon_menubar(icons.COPY - edit_copy_inactive) + get_hotkey_menubar("copy") + localize_ko("$Copy|")+
				                            inactive(edit_cut_inactive) + icon_menubar(icons.CUT - edit_cut_inactive) + get_hotkey_menubar("cut") + localize_ko("$Cut|")+
				                            inactive(edit_paste_inactive) + icon_menubar(icons.PASTE - edit_paste_inactive) + get_hotkey_menubar("paste") + localize_ko("$Paste|")+
				                            inactive(edit_delete_inactive) + icon_menubar(icons.DELETE - edit_delete_inactive) + get_hotkey_menubar("delete") + localize_ko("$Delete|-|")+
				                            inactive(edit_select_all_inactive) + get_hotkey_menubar("select_all") + localize_ko("$Select all|")+
				                            inactive(current_song.selected = 0) + localize_ko("Deselect all|")+
				                            inactive(current_song.selected = 0 && current_song.totalblocks = 0) + get_hotkey_menubar("invert_selection") + localize_ko("$Invert selection|-|")+
				                            inactive(current_song.instrument.num_blocks = 0) + localize_ko("Select all ") + clean(current_song.instrument.name) + "|"+
				                            inactive(current_song.instrument.num_blocks = current_song.totalblocks) + localize_ko("Select all but ") + clean(current_song.instrument.name) + "|-|"+
				                            inactive(current_song.selected = 0) + get_hotkey_menubar("action_1") + "$" + get_mode_actions(1) + "|"+
				                            inactive(current_song.selected = 0) + get_hotkey_menubar("action_2") + "$" + get_mode_actions(2) + "|"+
				                            inactive(current_song.selected = 0) + get_hotkey_menubar("action_3") + "$" + get_mode_actions(3) + "|"+
				                            inactive(current_song.selected = 0) + get_hotkey_menubar("action_4") + "$" + get_mode_actions(4) + "|"+
													condstr((editmode != m_key), inactive(current_song.selected = 0) + get_hotkey_menubar("action_5") + "$" + get_mode_actions(5) + "|") +
													condstr((editmode != m_key), inactive(current_song.selected = 0) + get_hotkey_menubar("action_6") + "$" + get_mode_actions(6) + "|") +
				                            inactive(current_song.selected = 0) + localize_ko("Change instrument...|\\|") + str + condstr(customstr != "", "-|") + customstr + string_repeat("/|", insmenu) + "-|" +
				                            inactive(current_song.selected = 0 || current_song.selection_l = 0) + localize_ko("Expand selection|")+
				                            inactive(current_song.selected = 0 || current_song.selection_l = 0) + localize_ko("Compress selection|")+
				                            inactive(current_song.selected = 0 || current_song.selection_l = 0) + localize_ko("Macros...|\\||")+ 
											get_hotkey_menubar("tremolo") + localize_ko("$Tremolo...|")+
											get_hotkey_menubar("stereo") + localize_ko("$Stereo...|")+
											get_hotkey_menubar("arpeggio") + localize_ko("$Arpeggio...|")+
											get_hotkey_menubar("portamento") + localize_ko("$Portamento...|")+
											get_hotkey_menubar("vibrato") + localize_ko("$Vibrato|")+
											get_hotkey_menubar("stagger") + localize_ko("$Stagger...|")+
											get_hotkey_menubar("chorus") + localize_ko("$Chorus|")+
											get_hotkey_menubar("volume_lfo") + localize_ko("$Volume LFO|")+
											get_hotkey_menubar("fade_in") + localize_ko("$Fade in|")+
											get_hotkey_menubar("fade_out") + localize_ko("$Fade out|")+
											get_hotkey_menubar("replace_key") + localize_ko("$Replace key|")+
											get_hotkey_menubar("set_velocity") + localize_ko("$Set velocity...|")+
											get_hotkey_menubar("set_panning") + localize_ko("$Set panning...|")+
											get_hotkey_menubar("set_pitch") + localize_ko("$Set pitch...|")+
											get_hotkey_menubar("reset_properties") + localize_ko("$Reset all properties|")+
											"/|-|"+
				                            inactive(current_song.selected = 0) + localize_ko("Transpose notes outside octave range"))
			}
			str = ""
			for (b = 0; b < 11; b += 1) {
				if (recent_song[b] = "") break
				c = floor(date_second_span(recent_song_time[b], date_current_datetime()))
				str += string_truncate(clean(filename_name(recent_song[b])), 310) + "|"
			}
			if (!isplayer) macos_create_menu_ext(localize_ko("File"), "file", icon_menubar(icons.NEW)+get_hotkey_menubar("new_song") + localize_ko("$New song|")+
				                        icon_menubar(icons.OPEN)+get_hotkey_menubar("open_song") + localize_ko("$Open song...|Recent songs...|\\|") + str + condstr(recent_song[0] != "", localize_ko("-|Clear recent songs")) + condstr(recent_song[0] = "", localize_ko("^!No recent songs")) + "|/|-|"+
				                        icon_menubar(icons.SAVE)+get_hotkey_menubar("save_song") + localize_ko("$Save song|")+
				                        icon_menubar(icons.SAVE_AS)+localize_ko("Save song as a new file...|")+
										localize_ko("Save options...|Restore unsaved files...|-|")+
										localize_ko("Import...|\\|") + 
										inactive(current_song.selected != 0)+localize_ko("Pattern...|")+
										"MIDI...|"+
										localize_ko("Reference audio...|Background image...|/|")+
										localize_ko("Export...|\\|") +
										inactive(current_song.totalblocks = 0 || ds_list_size(current_song.instrument_list) <= first_custom_index) + icon_menubar(icons.INSTRUMENTS) + localize_ko("Song with custom sounds...|") +
										inactive(current_song.selected = 0)+localize_ko("Pattern...|") +
										inactive(current_song.totalblocks = 0) + localize_ko("Audio track...|")+
										inactive(current_song.totalblocks = 0) + localize_ko("Schematic...|")+
										inactive(current_song.totalblocks = 0) + localize_ko("Track schematic...|")+
										inactive(current_song.totalblocks = 0) + localize_ko("Data pack..."))
			else macos_create_menu_ext(localize_ko("File"), "filep", icon_menubar(icons.OPEN)+get_hotkey_menubar("open_song") + localize_ko("$Open song...|Recent songs...|\\|") + str + condstr(recent_song[0] != "", localize_ko("-|Clear recent songs")) + condstr(recent_song[0] = "", localize_ko("^!No recent songs")) + "|/|-|"+localize_ko("Import from MIDI...|Import from schematic...|Import background image...|-|") + get_hotkey_menubar("exit") + localize_ko("$Exit"))
					
		} else {
			macos_create_menu_ext("帮助", "help", icon_menubar(icons.HELP) + "教程视频|\\|第 1 集：编写音符盒乐曲|第 2 集：打开 MIDI 文件|第 3 集：将乐曲导入进 Minecraft|第 4 集：编辑在 Minecraft 中创作的乐曲     |-|F1$观看所有|/|-|" + icon_menubar(icons.INTERNET) + "官方网站......|GitHub......|Discord 服务器......|反馈 bug......|QQ 群......|捐赠......|-|更新历史......|关于......")
			str = ""
			customstr = ""
			insmenu = 1
			for (a = 0; a < ds_list_size(current_song.instrument_list); a++) {
				var ins = current_song.instrument_list[| a];
				if (ins.user)
				    customstr += check(current_song.instrument = ins) + clean(ins.name) + "|"
				else{
					if(a < 9){
							str += check(current_song.instrument = ins) + get_hotkey_menubar("ins_ctrl") + string((a + 1) % 10) + "$" + clean(ins.name) + "|"
					}else if (a < 19){
						str += check(current_song.instrument = ins) + get_hotkey_menubar("ins_ctrl_shift") + string((a + 1) % 10) + "$" + clean(ins.name) + "|"
					} else {
							str += check(current_song.instrument = ins) + clean(ins.name) + "|"
						}
				}
				if (a % 25 == 0 && a > 1 && a < ds_list_size(current_song.instrument_list) - 1) {
					customstr += "-|更多......|\\|"
					insmenu++
				}
			}
			if (!isplayer) macos_create_menu_ext("设置", "settings", "音色|\\|" + str + condstr(customstr != "", "-|") + customstr + string_repeat("/|", insmenu) +
				                icon_menubar(icons.INSTRUMENTS)+"音色设置......|从 Minecraft 游戏文件中获取音效......|/|-|" + icon_menubar(icons.INFORMATION) + "歌曲信息......|" + icon_menubar(icons.PROPERTIES) + "歌曲属性......|歌曲数据......|-|" + icon_menubar(icons.MIDI_INPUT) + "MIDI 设备管理器")
			else macos_create_menu_ext("设置", "settingsp", icon_menubar(icons.INFORMATION) + "歌曲信息......|" + "歌曲数据......")		
			if (!isplayer) {
				str = ""
				customstr = ""
				insmenu = 1
				for (a = 0; a < ds_list_size(current_song.instrument_list); a += 1) {
				    var ins = current_song.instrument_list[| a];
				    if (ins.user)
				        customstr += "...为 " + clean(ins.name) + "|"
				    else
				        str += "...为 " + clean(ins.name) + "|"
					if (a % 25 == 0 && a > 1 && a < ds_list_size(current_song.instrument_list) - 1) {
						customstr += "-|更多......|\\|"
						insmenu++
					}
				}
				macos_create_menu_ext("编辑", "edit", inactive(edit_undo_inactive) + icon_menubar(icons.UNDO - edit_undo_inactive) + get_hotkey_menubar("undo") + "$撤销|"+
				                            inactive(edit_redo_inactive) + icon_menubar(icons.REDO - edit_redo_inactive) + get_hotkey_menubar("redo") + "$重做|-|"+
				                            inactive(edit_copy_inactive) + icon_menubar(icons.COPY - edit_copy_inactive) + get_hotkey_menubar("copy") + "$复制|"+
				                            inactive(edit_cut_inactive) + icon_menubar(icons.CUT - edit_cut_inactive) + get_hotkey_menubar("cut") + "$剪切|"+
				                            inactive(edit_paste_inactive) + icon_menubar(icons.PASTE - edit_paste_inactive) + get_hotkey_menubar("paste") + "$粘贴|"+
				                            inactive(edit_delete_inactive) + icon_menubar(icons.DELETE - edit_delete_inactive) + get_hotkey_menubar("delete") + "$删除|-|"+
				                            inactive(edit_select_all_inactive) + get_hotkey_menubar("select_all") + "$全选|"+
				                            inactive(current_song.selected = 0) + "全不选|"+
				                            inactive(current_song.selected = 0 && current_song.totalblocks = 0) + get_hotkey_menubar("invert_selection") + "$选择反转|-|"+
				                            inactive(current_song.instrument.num_blocks = 0) + "选择所有 " + clean(current_song.instrument.name) + "|"+
				                            inactive(current_song.instrument.num_blocks = current_song.totalblocks) + "选择所有除了 " + clean(current_song.instrument.name) + "|-|"+
				                            inactive(current_song.selected = 0) + get_hotkey_menubar("action_1") + "$" + get_mode_actions(1) + "|"+
				                            inactive(current_song.selected = 0) + get_hotkey_menubar("action_2") + "$" + get_mode_actions(2) + "|"+
				                            inactive(current_song.selected = 0) + get_hotkey_menubar("action_3") + "$" + get_mode_actions(3) + "|"+
				                            inactive(current_song.selected = 0) + get_hotkey_menubar("action_4") + "$" + get_mode_actions(4) + "|"+
													condstr((editmode != m_key), inactive(current_song.selected = 0) + get_hotkey_menubar("action_5") + "$" + get_mode_actions(5) + "|") +
													condstr((editmode != m_key), inactive(current_song.selected = 0) + get_hotkey_menubar("action_6") + "$" + get_mode_actions(6) + "|") +
				                            inactive(current_song.selected = 0) + "更改音色......|\\|" + str + condstr(customstr != "", "-|") + customstr + string_repeat("/|", insmenu) + "-|" +
				                            inactive(current_song.selected = 0 || current_song.selection_l = 0) + "扩展选区|"+
				                            inactive(current_song.selected = 0 || current_song.selection_l = 0) + "压缩选区|"+
				                            inactive(current_song.selected = 0 || current_song.selection_l = 0) + "快捷键......|\\||"+ 
											get_hotkey_menubar("tremolo") + localize_ko("$Tremolo...|")+
											get_hotkey_menubar("stereo") + localize_ko("$Stereo...|")+
											get_hotkey_menubar("arpeggio") + localize_ko("$Arpeggio...|")+
											get_hotkey_menubar("portamento") + localize_ko("$Portamento...|")+
											get_hotkey_menubar("vibrato") + localize_ko("$Vibrato|")+
											get_hotkey_menubar("stagger") + localize_ko("$Stagger...|")+
											get_hotkey_menubar("chorus") + localize_ko("$Chorus|")+
											get_hotkey_menubar("volume_lfo") + localize_ko("$Volume LFO|")+
											get_hotkey_menubar("fade_in") + "$淡入|"+
											get_hotkey_menubar("fade_out") + "$淡出|"+
											get_hotkey_menubar("replace_key") + "$替换音|"+
											get_hotkey_menubar("set_velocity") + "$设定音量......|"+
											get_hotkey_menubar("set_panning") + "$设定声道......|"+
											get_hotkey_menubar("set_pitch") + "$设定音高......|"+
											get_hotkey_menubar("reset_properties") + "$重置所有属性|"+
											"/|-|"+
				                            inactive(current_song.selected = 0) + "转换所有超出八度范围的音符")
			}
			str = ""
			for (b = 0; b < 11; b += 1) {
				if (recent_song[b] = "") break
				c = floor(date_second_span(recent_song_time[b], date_current_datetime()))
				str += string_truncate(clean(filename_name(recent_song[b])), 310) + "|"
			}
			if (!isplayer) macos_create_menu_ext("文件", "file", icon_menubar(icons.NEW)+get_hotkey_menubar("new_song") + "$新文件|"+
				                        icon_menubar(icons.OPEN)+get_hotkey_menubar("open_song") + "$打开歌曲......|最近歌曲......|\\|" + str + condstr(recent_song[0] != "", "-|清除最近歌曲") + condstr(recent_song[0] = "", "^!无最近歌曲") + "|/|-|"+
				                        icon_menubar(icons.SAVE)+get_hotkey_menubar("save_song") + "$保存歌曲|"+
				                        icon_menubar(icons.SAVE_AS)+"另存为|"+
										"保存选项......|恢复未保存的歌曲......|-|" +
										"导入......|\\|"+
										inactive(current_song.selected != 0)+"片段......|"+
										"MIDI 文件......|"+
										"参考音频......|背景图片......|/|"+
										"导出......|\\|"+
										inactive(current_song.totalblocks = 0 || ds_list_size(current_song.instrument_list) <= first_custom_index) + icon_menubar(icons.INSTRUMENTS) + "带自定义音色的歌曲......|"+
										inactive(current_song.selected = 0)+"片段......|"+
										inactive(current_song.totalblocks = 0) + "音频文件......|"+
										inactive(current_song.totalblocks = 0) + "结构......|"+
										inactive(current_song.totalblocks = 0) + "直轨结构......|"+
										inactive(current_song.totalblocks = 0) + "数据包......")
			else macos_create_menu_ext("文件", "filep", icon_menubar(icons.OPEN)+get_hotkey_menubar("open_song") + "$打开歌曲......|最近歌曲......|\\|" + str + condstr(recent_song[0] != "", "-|清除最近歌曲") + condstr(recent_song[0] = "", "^!无最近歌曲") + "|/|-|"+"从 MIDI 文件导入......|从 Schematic 文件导入......|导入背景图片......|-|" + get_hotkey_menubar("exit") + "$退出")
				
		}
	}
}
