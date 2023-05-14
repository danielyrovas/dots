local wezterm = require("wezterm")
-- local catppuccin = require("colors/catppuccin").setup({
-- 	sync_flavours = {
-- 		light = "latte",
-- 		dark = "mocha",
-- 	},
-- })

-- wezterm.on('gui-startup', function(cmd)
-- end
-- )

return {
	-- Appearance
	-- color_scheme = "catppuccin",
	-- colors = catppuccin,
    -- default_prog
    -- default_gui_startup_args = { 'start', '--', 'zellij', 'attach', 'session', '--create' },
  color_scheme = "tokyonight-storm",
	font = wezterm.font_with_fallback({
		"Fira Code",
		-- "JetBrains Mono",
		{ family = "Symbols Nerd Font Mono", scale = 0.7 }
	}),
	font_size = 15,
	warn_about_missing_glyphs = false,
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	check_for_updates = false,
	window_decorations = "RESIZE",
	-- window_background_image = "/Users/daniel.savory/Pictures/Mist.jpg",
	-- window_background_opacity = 0.8,
	window_padding = {
		left = 0,
		right = 0,
		top = 4,
		bottom = 0,
	},
	-- Functionality
	clean_exit_codes = { 130, 127 },

	keys = {
		{ key = "Enter", mods = "ALT", action = "DisableDefaultAssignment" },
		{ key = "t", mods = "CMD", action = "DisableDefaultAssignment" },
	},
}
