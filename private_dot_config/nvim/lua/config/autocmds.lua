local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command
local namespace = vim.api.nvim_create_namespace

local utils = require "utils"
local is_available = utils.is_available

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("yank_highlight", { clear = true }),
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})

autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text", "plaintex" },
  group = augroup("auto_spell", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local new_hlsearch =
        vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end, namespace "auto_hlsearch")

autocmd("BufReadPre", {
  desc = "Disable certain functionality on very large files",
  group = augroup("large_buf", { clear = true }),
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    vim.b[args.buf].large_buf = (ok and stats and stats.size > vim.g.max_file.size)
        or vim.api.nvim_buf_line_count(args.buf) > vim.g.max_file.lines
  end,
})

autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = augroup("q_close_windows", { clear = true }),
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    if vim.tbl_contains(vim.g.q_close_windows, buftype) and vim.fn.maparg("q", "n") == "" then
      vim.keymap.set("n", "q", "<cmd>close<cr>", {
        desc = "Close window",
        buffer = args.buf,
        silent = true,
        nowait = true,
      })
    end
  end,
})

autocmd("ColorScheme", {
  desc = "Load custom highlights from user configuration",
  group = augroup("highlights", { clear = true }),
  callback = function()
    for group, spec in pairs(require "config.highlights") do
      vim.api.nvim_set_hl(0, group, spec)
    end
  end,
})

-- if false and is_available "nvim-tree.lua" then
--   autocmd("VimEnter", {
--     desc = "Open nvim-tree.lua on startup with directory",
--     group = augroup("nvimtree_start", { clear = true }),
--     callback = function()
--       if package.loaded["nvim-tree.lua"] then
--         vim.api.nvim_del_augroup_by_name "nvimtree_start"
--       else
--         local stats = (vim.uv or vim.loop).fs_stat(vim.api.nvim_buf_get_name(0)) -- TODO: REMOVE vim.loop WHEN DROPPING SUPPORT FOR Neovim v0.9
--         if stats and stats.type == "directory" then
--           vim.api.nvim_del_augroup_by_name "nvimtree_start"
--           require "nvim-tree.lua"
--         end
--       end
--     end,
--   })
-- end

if is_available "oil.nvim" then
  -- autocmd("BufEnter", {
  --   desc = "Open oil.nvim on startup with directory",
  --   group = augroup("oil_start", { clear = true }),
  --   callback = function()
  --     if package.loaded["oil.nvim"] then
  --       vim.api.nvim_del_augroup_by_name "oil_start"
  --     else
  --       local stats = (vim.uv or vim.loop).fs_stat(vim.api.nvim_buf_get_name(0)) -- TODO: REMOVE vim.loop WHEN DROPPING SUPPORT FOR Neovim v0.9
  --       if stats and stats.type == "directory" then
  --         require("oil.nvim").open()
  --         -- vim.cmd "Oil"
  --         vim.api.nvim_del_augroup_by_name "oil_start"
  --       end
  --     end
  --   end,
  -- })

  autocmd("User", {
    desc = "Open oil.nvim preview automatically",
    pattern = "OilEnter",
    callback = vim.schedule_wrap(function(args)
      local oil = require("oil")
      if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
        oil.select({ preview = true })
      end
    end),
  })
end
