function seconds_to_str(argument0) {
	// seconds_to_str(s)
	c = argument0
	if (language != 1) {
		if (c < 60) {
			str = string(c) + localize_ko(" second") + condstr(language = 0 && c != 1, "s") + localize_ko(" ago")
		} else if (c < 60 * 60) {
			c = floor(c / 60)
			str = string(c) + localize_ko(" minute") + condstr(language = 0 && c != 1, "s") + localize_ko(" ago")
		} else if (c < 60 * 60 * 24) {
			c = floor(c / (60 * 60))
			str = string(c) + localize_ko(" hour") + condstr(language = 0 && c != 1, "s") + localize_ko(" ago")
		} else if (c < 60 * 60 * 24 * 7) {
			c = floor(c / (60 * 60 * 24))
			str = string(c) + localize_ko(" day") + condstr(language = 0 && c != 1, "s") + localize_ko(" ago")
		} else if (c < 60 * 60 * 24 * 31) {
			c = floor(c / (60 * 60 * 24 * 7))
			str = string(c) + localize_ko(" week") + condstr(language = 0 && c != 1, "s") + localize_ko(" ago")
		} else if (c < 60 * 60 * 24 * 31 * 12) {
			c = floor(c / (60 * 60 * 24 * 31))
			str = string(c) + localize_ko(" month") + condstr(language = 0 && c != 1, "s") + localize_ko(" ago")
		} else {
			c = floor(c / (60 * 60 * 24 * 31 * 12))
			str = string(c) + localize_ko(" year") + condstr(language = 0 && c != 1, "s") + localize_ko(" ago")
		}
	} else {
		if (c < 60) {
			str = string(c) + " 秒前"
		} else if (c < 60 * 60) {
			c = floor(c / 60)
			str = string(c) + " 分钟前"
		} else if (c < 60 * 60 * 24) {
			c = floor(c / (60 * 60))
			str = string(c) + " 小时前"
		} else if (c < 60 * 60 * 24 * 7) {
			c = floor(c / (60 * 60 * 24))
			str = string(c) + " 天前"
		} else if (c < 60 * 60 * 24 * 31) {
			c = floor(c / (60 * 60 * 24 * 7))
			str = string(c) + " 星期前"
		} else if (c < 60 * 60 * 24 * 31 * 12) {
			c = floor(c / (60 * 60 * 24 * 31))
			str = string(c) + " 月前"
		} else {
			c = floor(c / (60 * 60 * 24 * 31 * 12))
			str = string(c) + " 年前"
		}
	}

	return str



}
