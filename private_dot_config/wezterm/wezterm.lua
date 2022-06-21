local wezterm = require 'wezterm';
local catppuccin = require 'colors/catppuccin'.setup {
  sync_flavours = {
    light = "latte",
    dark = "mocha"
  }
}

return {
  -- Appearance
  colors = catppuccin,
  font = wezterm.font("JetBrains Mono"),
  font_size = 14,
  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  window_decorations = "NONE",
  window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 0,
  },
  ssh_domains = {
    {
      name = "alp",
      remote_address = "192.168.1.10",
      username = "lxc"
    },
  },

  -- Functionality
  clean_exit_codes = { 130, 127 },
}
