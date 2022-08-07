local M = {}
local override = require "custom.override"

M.options = {}

M.ui = {
  theme = "catppuccin",
}

M.plugins = {
  override = {
    ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
    ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
    ["lukas-reineke/indent-blankline.nvim"] = override.blankline,
    ["williamboman/mason.nvim"] = override.mason,
    ["hrsh7th/nvim-cmp"] = override.cmp,
  },
  user = require "custom.plugins",
}

M.mappings = require "custom.mappings"

return M
