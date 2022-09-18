local M = {}

M.truzen = {
  n = {
    ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "   truzen ataraxis" },
    ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "   truzen minimal" },
    -- ["<leader>tf"] = { "<cmd> TZFocus <CR>", "   truzen focus" },
  },
}

M.alpha = {
  n = {
    ["<leader>a"] = { "<cmd> Alpha <CR>", "   dashboard" },
  },
}

M.general = {
  i = {
    ["<C-s>"] = { "<cmd> w <CR>", "﬚  save file" },
  },

  n = {
    -- line numbers
    ["<leader>tn"] = { "<cmd> set nu! <CR>", "   toggle line number" },
    ["<leader>tr"] = { "<cmd> set rnu! <CR>", "   toggle relative number" },
    ["x"] = { '"_x', " no yank", opts = { silent = true } },
    ["<S-h>"] = { "<CMD> bprevious <CR>", "previous bufferr", opts = { silent = true } },
    ["<S-l>"] = { "<CMD> bnext <CR>", "next bufferr", opts = { silent = true } },
    ["<S-q><S-q>"] = { "gqap" },
    [";"] = { ":", "command mode", opts = { nowait = true } },
    -- copy to clipboard without newline characters
  },

  v = {
    ["x"] = { '"_x', " no yank", opts = { silent = true } },
    ["<leader>ny"] = { "Jyyu", "copy no newlines" },
  },
}

M.nvterm = {
  n = {
    ["<leader>lz"] = {
      function()
        require("nvterm.terminal").send("lazygit", "vertical")
      end,
      "nvterm lazygit",
    },
  },
}

M.minimap = {
  n = {
    ["<leader>mm"] = { "<cmd> MinimapToggle<CR>", "Minimap" },
  },
}

M.telescope = {
  n = {
    ["<leader>ts"] = { "<cmd> Telescope session-lens search_session<CR>", "search sessions" },
  },
}

local hopping = {
  ["f"] = {
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<CR>",
    "",
  },
  ["F"] = {
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<CR>",
    "",
  },
  ["t"] = {
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })<CR>",
    "",
  },
  ["T"] = {
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })<CR>",
    "",
  },
}

M.hop = {
  n = hopping,
  v = hopping,
  o = hopping,
}
-- M.treesitter = {
--   n = {
--     ["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "  find media" },
--   },
-- }

-- M.shade = {
--   n = {
--     ["<leader>s"] = {
--       function()
--         require("shade").toggle()
--       end,
--
--       "   toggle shade.nvim",
--     },
--
--   },
-- }

M.disabled = {
  n = {
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
  },
}

return M
