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

autocmd("BufEnter", {
  desc = "Quit Nvim if more than one window is open and only sidebar windows are list",
  group = augroup("auto_quit", { clear = true }),
  callback = function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    -- Both neo-tree and aerial will auto-quit if there is only a single window left
    if #wins <= 1 then return end
    local sidebar_fts = { aerial = true, ["neo-tree"] = true }
    for _, winid in ipairs(wins) do
      if vim.api.nvim_win_is_valid(winid) then
        local bufnr = vim.api.nvim_win_get_buf(winid)
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
        -- If any visible windows are not sidebars, early return
        if not sidebar_fts[filetype] then
          return
          -- If the visible window is a sidebar
        else
          -- only count filetypes once, so remove a found sidebar from the detection
          sidebar_fts[filetype] = nil
        end
      end
    end
    if #vim.api.nvim_list_tabpages() > 1 then
      vim.cmd.tabclose()
    else
      vim.cmd.qall()
    end
  end,
})

if is_available "alpha-nvim" then
  autocmd({ "User", "BufEnter" }, {
    desc = "Disable status, tablines, and cmdheight for alpha",
    group = augroup("alpha_settings", { clear = true }),
    callback = function(args)
      if
          (
            (args.event == "User" and args.file == "AlphaReady")
            or (
              args.event == "BufEnter"
              and vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "alpha"
            )
          ) and not vim.g.before_alpha
      then
        vim.g.before_alpha = {
          showtabline = vim.opt.showtabline:get(),
          laststatus = vim.opt.laststatus:get(),
          cmdheight = vim.opt.cmdheight:get(),
        }
        vim.opt.showtabline, vim.opt.laststatus, vim.opt.cmdheight = 0, 0, 0
      elseif
          vim.g.before_alpha
          and args.event == "BufEnter"
          and vim.api.nvim_get_option_value("buftype", { buf = args.buf }) ~= "nofile"
      then
        vim.opt.laststatus, vim.opt.showtabline, vim.opt.cmdheight =
            vim.g.before_alpha.laststatus,
            vim.g.before_alpha.showtabline,
            vim.g.before_alpha.cmdheight
        vim.g.before_alpha = nil
      end
    end,
  })
  autocmd("VimEnter", {
    desc = "Start Alpha when vim is opened with no arguments",
    group = augroup("alpha_autostart", { clear = true }),
    callback = function()
      local should_skip = false
      if vim.fn.argc() > 0 or vim.fn.line2byte(vim.fn.line "$") ~= -1 or not vim.o.modifiable then
        should_skip = true
      else
        for _, arg in pairs(vim.v.argv) do
          if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
            should_skip = true
            break
          end
        end
      end
      if not should_skip then
        require("alpha").start(true, require("alpha").default_config)
        vim.schedule(function() vim.cmd.doautocmd "FileType" end)
      end
    end,
  })
end

if is_available "neo-tree.nvim" then
  autocmd("BufEnter", {
    desc = "Open Neo-Tree on startup with directory",
    group = augroup("neotree_start", { clear = true }),
    callback = function()
      if package.loaded["neo-tree"] then
        vim.api.nvim_del_augroup_by_name "neotree_start"
      else
        local stats = (vim.uv or vim.loop).fs_stat(vim.api.nvim_buf_get_name(0)) -- TODO: REMOVE vim.loop WHEN DROPPING SUPPORT FOR Neovim v0.9
        if stats and stats.type == "directory" then
          vim.api.nvim_del_augroup_by_name "neotree_start"
          require "neo-tree"
        end
      end
    end,
  })
end

if false and is_available "nvim-tree.lua" then
  autocmd("VimEnter", {
    desc = "Open nvim-tree.lua on startup with directory",
    group = augroup("nvimtree_start", { clear = true }),
    callback = function()
      if package.loaded["nvim-tree.lua"] then
        vim.api.nvim_del_augroup_by_name "nvimtree_start"
      else
        local stats = (vim.uv or vim.loop).fs_stat(vim.api.nvim_buf_get_name(0)) -- TODO: REMOVE vim.loop WHEN DROPPING SUPPORT FOR Neovim v0.9
        if stats and stats.type == "directory" then
          vim.api.nvim_del_augroup_by_name "nvimtree_start"
          require "nvim-tree.lua"
        end
      end
    end,
  })
end

if false and is_available "fern.vim" then
  autocmd("BufEnter", {
    desc = "Open Fern.vim on startup with directory",
    group = augroup("fern_start", { clear = true }),
    callback = function()
      if package.loaded["fern.vim"] then
        vim.api.nvim_del_augroup_by_name "fern_start"
      else
        local stats = (vim.uv or vim.loop).fs_stat(vim.api.nvim_buf_get_name(0)) -- TODO: REMOVE vim.loop WHEN DROPPING SUPPORT FOR Neovim v0.9
        if stats and stats.type == "directory" then
          vim.api.nvim_del_augroup_by_name "fern_start"
          require "fern.vim"
        end
      end
    end,
  })
end

if false and is_available "oil.nvim" then
  autocmd("BufEnter", {
    desc = "Open oil.nvim on startup with directory",
    group = augroup("oil_start", { clear = true }),
    callback = function()
      if package.loaded["oil.nvim"] then
        vim.api.nvim_del_augroup_by_name "oil_start"
      else
        local stats = (vim.uv or vim.loop).fs_stat(vim.api.nvim_buf_get_name(0)) -- TODO: REMOVE vim.loop WHEN DROPPING SUPPORT FOR Neovim v0.9
        if stats and stats.type == "directory" then
          require("oil.nvim").open()
          vim.api.nvim_del_augroup_by_name "oil_start"
        end
      end
    end,
  })
end
