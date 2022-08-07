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
  },

  v = {
    ["x"] = { '"_x', " no yank", opts = { silent = true } },
  },

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
--     ["<leader>lz"] = {
--       function()
--         require("nvterm.terminal").send("lazygit", "vertical")
--       end,
--       "nvterm lazygit",
--     },
--   },
-- }

M.disabled = {
  n = {
      ["<leader>n"] = "",
      ["<leader>rn"] = "",
  }
}

return M
