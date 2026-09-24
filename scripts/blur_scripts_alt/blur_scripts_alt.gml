/*
* Provided as a replacement to blur_scripts.gml, which belongs to
* the Realtime Blur extension by Foxy Of Jungle:
* https://marketplace.yoyogames.com/assets/9540/blur-realtime-performance
* 
* Since it's a paid extension, the source code cannot be published
* to the repository, so the extension files must be added manually
* to the project folder after cloning.
* 
* Note Block Studio will work just fine without the extension, but
* the transparency effects for the Fluent theme will be missing the
* blur effect.
*/

function sprite_create_blur_alt(sprite, downamount, width, height, blurradius, quality, directions) {
	// Returns a sprite index
	try {
		//return sprite_create_blur(sprite, downamount, width, height, blurradius, quality, directions);
		return blur_sprite_create(sprite, 0, BLUR_TYPE.GAUSSIAN, width, height, blurradius, downamount)
	} catch (exc) {
		// A failed blur must not expose the unblurred desktop wallpaper.
		return -1;
	}
}

function draw_surface_blur_alt(surface, x, y, w, h, downamount) {
	// The paid blur extension is optional in public-source builds.
	static blur_available = true;
	if (!blur_available || !surface_exists(surface) || w <= 0 || h <= 0) return;

	var temp_surface = -1;
	var area_id = -1;
	var target_pushed = false;
	var previous_filter = gpu_get_tex_filter();
	var previous_blend = gpu_get_blendenable();
	try {
		var scale = obj_controller.window_scale;
		var pixel_w = max(1, ceil(w * scale));
		var pixel_h = max(1, ceil(h * scale));
		temp_surface = surface_create(pixel_w, pixel_h);
		if (!surface_exists(temp_surface)) return;
		area_id = blur_area_create();
		surface_set_target(temp_surface);
		target_pushed = true;
		draw_surface_part(surface, x * scale, y * scale, pixel_w, pixel_h, 0, 0);
		blur_area_draw(area_id, temp_surface, BLUR_TYPE.GAUSSIAN, 0, 0, pixel_w, pixel_h, 0, 0, 0.25 * downamount * scale);
		surface_reset_target();
		target_pushed = false;
		surface_set_target(surface);
		target_pushed = true;
		gpu_set_tex_filter(true);
		draw_rectangle_color(x, y, x + w - 1, y + h - 1, 0, 0, 0, 0, 0);
		draw_surface_stretched(temp_surface, x, y, w, h);
	} catch (exc) {
		// Do not retry a missing or failing extension for every popup frame.
		blur_available = false;
	}

	// Only release resources and targets acquired by this call. In particular,
	// never access controller fields that may not have been initialized.
	if (target_pushed) surface_reset_target();
	gpu_set_tex_filter(previous_filter);
	gpu_set_blendenable(previous_blend);
	if (surface_exists(temp_surface)) surface_free(temp_surface);
	if (area_id != -1) {
		try {
			blur_area_destroy(area_id);
		} catch (cleanup_exc) {
			blur_available = false;
		}
	}
}

// NB: sprite_blur_clear and sprite_draw_blur were suppressed
// from this script as they aren't currently used.
