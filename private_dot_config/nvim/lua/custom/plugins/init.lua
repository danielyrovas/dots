return {
  -- minimal modes
  ["Pocco81/TrueZen.nvim"] = {
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
      -- "TZFocus",
    },
    config = function()
      require "custom.plugins.truezen"
    end,
  },

  ["goolord/alpha-nvim"] = {
    disable = false,
    cmd = "Alpha",
  },

  ["kevinhwang91/nvim-ufo"] = {
    cmd = "UfoEnable",
    requires = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup()
    end,
  },
  -- needs config ??
  ["lukas-reineke/cmp-rg"] = {},
  -- ["petertriho/cmp-git"] = {
  --   -- after = "",
  --   config = function()
  --     require("cmp_git").setup()
  --   end,
  -- },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lsp"
    end,
  },

  -- format & linting
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  -- ['echasnovski/mini.nvim'] = {}

  -- Will refactor
  ["phaazon/hop.nvim"] = {
    branch = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup { keys = "arstneiomcqwyu" }
      vim.api.nvim_set_keymap(
        "",
        "f",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "",
        "F",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "",
        "t",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "",
        "T",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })<cr>",
        {}
      )
    end,
  },
}
