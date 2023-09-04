return {
  "nvim-lua/plenary.nvim",
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      transparent = vim.g.transparent_bg,
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
      icons = {
        -- group = "",
        separator = "",
      },
      disable = { filetypes = { "TelescopePrompt" } },
    },
    config = function(_, opts)
      require("which-key").setup(opts)
      require("utils").which_key_register()
    end,
  },
  {
    "ggandor/flit.nvim",
    keys = function()
      local ret = {}
      for _, key in ipairs { "f", "F", "t", "T" } do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { multiline = false, labeled_modes = "nxo" },
    dependencies = {
      "ggandor/leap.nvim",
      keys = {
        { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
        { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
        { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
      },
      config = function(_, opts)
        local leap = require "leap"
        for k, v in pairs(opts) do
          leap.opts[k] = v
        end
        leap.add_default_mappings(true)
      end,
      dependencies = {
        "tpope/vim-repeat",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    opts = function()
      local commentstring_avail, commentstring =
        pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      return commentstring_avail
          and commentstring
          and { pre_hook = commentstring.create_pre_hook() }
        or {}
    end,
  },
  {
    -- "Darazaki/indent-o-matic",
    "nmac427/guess-indent.nvim",
    opts = {},
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
  },
}
