-- Options
lvim.colorscheme = "tokyonight"
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.builtin.alpha.mode = "startify"
-- lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.lualine.options.globalstatus = true

local o = vim.opt
o.timeoutlen = 300
o.shell = "/bin/sh"

table.insert(lvim.builtin.cmp.sources, {name = "cmdline"} )
table.insert(lvim.builtin.cmp.sources, {name = "cmp_git"} )
-- table.insert(lvim.builtin.cmp.sources, {name = "digraphs"} )
table.insert(lvim.builtin.cmp.sources, {name = "spell", keyword_length = 3} )
table.insert(lvim.builtin.cmp.sources, {name = "dictionary", keyword_length = 3} )
table.insert(lvim.builtin.cmp.sources, {name = "rg", keyword_length = 3} )

-- Keymappings
lvim.leader = "space"

local delete = function () end
local cmp_status_ok, cmp = pcall (require, 'cmp')
if cmp_status_ok then
  lvim.builtin.cmp.formatting.kind_icons.Method = "m "
  lvim.builtin.cmp.formatting.kind_icons.Module = " "
  lvim.builtin.cmp.formatting.kind_icons.Variable = " "
  lvim.builtin.cmp.formatting.kind_icons.Constant = " "
  lvim.builtin.cmp.formatting.kind_icons.Interface = " "
  lvim.builtin.cmp.formatting.kind_icons.Field = "ﰠ "
  lvim.builtin.cmp.mapping["<C-Space>"] = delete()
  lvim.builtin.cmp.mapping["<C-k>"] = delete()
  lvim.builtin.cmp.mapping["<C-j>"] = delete()
  lvim.builtin.cmp.mapping["<Tab>"] = delete()
  lvim.builtin.cmp.mapping["<S-Tab>"] = delete()
  lvim.builtin.cmp.mapping["<CR>"] = delete()
  lvim.builtin.cmp.mapping["<C-y>"] = cmp.mapping.confirm { select = true}
  lvim.builtin.cmp.mapping["<C-d>"] = delete()
  lvim.builtin.cmp.mapping["<C-b>"] = cmp.mapping.scroll_docs(-4)
end
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

lvim.builtin.which_key.mappings["n"] = {
  name = "+Neorg",
  s = { ":NeorgStart silent=true<cr>", "Start"},
  t = { ":Neorg gtd capture<cr>", "New Task"},
  v = { ":Neorg gtd views<cr>", "View Tasks"},
  e = { ":Neorg gtd edit<cr>", "Edit Tasks"},
  w = { ":Neorg news all<cr>", "Neorg News"},
  d = {
    name = "+Journal",
    t = { ":Neorg journal today<cr>", "Today" },
    y = { ":Neorg journal yesterday<cr>", "Yesterday" },
    n = { ":Neorg journal tomorrow<cr>", "Tomorrow" },
    c = { ":Neorg journal custom", "Custom" },
  },
}

-- Plugins
local req = function (module)
  require(module)
end
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true

lvim.plugins = {
  {
    "folke/tokyonight.nvim",
	-- config = function()
	--   vim.cmd[[colorscheme tokyonight]]
	-- end,
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.cmd[[colorscheme catppuccin]]
    end,
  },
  { "petertriho/cmp-git" },
  { "uga-rosa/cmp-dictionary" },
  { "dmitmel/cmp-digraphs"},
  { "lukas-reineke/cmp-rg" },
  { "nvim-neorg/neorg", config = req "conf.neorg", },
  { "folke/trouble.nvim", cmd = "TroubleToggle", },
}

require "conf.luasnip"
require "conf.dap"
require "conf.dictionary"

