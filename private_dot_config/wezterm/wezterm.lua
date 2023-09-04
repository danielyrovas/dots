local wezterm = require("wezterm")

return {
	color_scheme = "tokyonight",
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		{ family = "Symbols Nerd Font Mono", scale = 0.7 },
	}),
	font_size = 17,
	warn_about_missing_glyphs = false,
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	check_for_updates = false,
	window_decorations = "RESIZE",
	window_background_opacity = 0.8,
	-- window_background_image = "/Users/daniel.savory/Pictures/Mist.jpg",
	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 0,
	},
	clean_exit_codes = { 130, 127 },
	keys = {
		{ key = "Enter", mods = "ALT", action = "DisableDefaultAssignment" },
		{ key = "t", mods = "CMD", action = "DisableDefaultAssignment" },
	},
}
