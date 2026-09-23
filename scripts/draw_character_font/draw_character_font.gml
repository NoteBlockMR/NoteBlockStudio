/// @description True for modern/compatibility Hangul and Jamo.
function is_korean_codepoint(code) {
    return (code >= $AC00 && code <= $D7A3)
        || (code >= $1100 && code <= $11FF)
        || (code >= $3130 && code <= $318F)
        || (code >= $A960 && code <= $A97F)
        || (code >= $D7B0 && code <= $D7FF);
}

/// @description Use bundled runtime fonts for Hangul, and existing fonts otherwise.
function draw_character_font(type, code, force_lores = false) {
    var o = obj_controller;
    draw_theme_font(type, code > 127, force_lores);
    if (!is_korean_codepoint(code)) return;

    if (!variable_instance_exists(o, "korean_fonts")) o.korean_fonts = array_create(16, -2);
    var hires_font = o.hires && !force_lores && o.theme == 3;
    var index = type + 8 * hires_font;
    if (o.korean_fonts[index] == -2) {
        var medium = (type == 1 || type == 4 || type == 6);
        var path = data_directory + "Fonts/SourceHanSansSC-" + (medium ? "Medium" : "Normal") + ".otf";
        // Asset sizes are points; file-based font_add sizes are pixels.
        var size = ceil(font_get_size(draw_get_font()) * 4 / 3);
        o.korean_fonts[index] = font_add(path, size, false, false, $AC00, $D7A3);
    }
    var font = o.korean_fonts[index];
    if (font != -1 && font_exists(font)) draw_set_font(font);
}

/// @description Release fonts added at runtime when the application exits.
function korean_fonts_free() {
    var o = obj_controller;
    if (!variable_instance_exists(o, "korean_fonts")) return;
    for (var i = 0; i < array_length(o.korean_fonts); i++) {
        var font = o.korean_fonts[i];
        if (font >= 0 && font_exists(font)) font_delete(font);
        o.korean_fonts[i] = -2;
    }
}
