local wezterm = require("wezterm")
local catppuccin = require("colors/catppuccin").setup({
	sync_flavours = {
		light = "latte",
		dark = "mocha",
	},
})

return {
	-- Appearance
	-- color_scheme = "catppuccin",
	colors = catppuccin,
	font = wezterm.font("JetBrains Mono"),
	font_size = 14,
	warn_about_missing_glyphs = false,
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	check_for_updates = false,
	window_decorations = "RESIZE",
	-- window_background_image = "/home/danielyrovas/Pictures/Mist.jpg",
	window_background_opacity = 1,
	window_padding = {
		left = 0,
		right = 0,
		top = 10,
		bottom = 0,
	},
	ssh_domains = {
		{
			name = "alp",
			remote_address = "192.168.1.10",
			username = "lxc",
		},
	},

	-- Functionality
	clean_exit_codes = { 130, 127 },

	keys = {
		{ key = "Enter", mods = "ALT", action = "DisableDefaultAssignment" },
	},
}
