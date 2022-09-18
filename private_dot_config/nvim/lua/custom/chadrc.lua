local M = {}

-- M.options = {}

M.ui = {
  theme = "catppuccin",
  theme_toggle = "catppuccin, one_light",
}

M.plugins = require "custom.plugins"

M.mappings = require "custom.mappings"

return M
