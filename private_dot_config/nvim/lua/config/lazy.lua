local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.api.nvim_get_vvar "shell_error" ~= 0 then
    vim.api.nvim_err_writeln "Error cloning lazy.nvim repository...\n"
  end
  local oldcmdheight = vim.opt.cmdheight:get()
  vim.opt.cmdheight = 1
  vim.notify "Please wait while plugins are installed..."
  vim.api.nvim_create_autocmd("User", {
    desc = "Load Mason and Treesitter after Lazy installs plugins",
    once = true,
    pattern = "LazyInstall",
    callback = function()
      vim.cmd.bw()
      vim.opt.cmdheight = oldcmdheight
      vim.tbl_map(function(module) pcall(require, module) end, { "nvim-treesitter", "mason" })
    end,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  vim.notify "Could not load lazy.nvim, no plugins will be loaded."
  return
end

lazy.setup {
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = true,
    version = false,
  },
  install = { colorscheme = { vim.g.colorscheme or nil, "habamax" } },
  change_detection = { enabled = false },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      paths = {}, -- add any custom paths here that you want to include in the rtp
      disabled_plugins = vim.g.disabled_plugins,
    },
  },
  readme = {
    enabled = true,
    root = vim.fn.stdpath "state" .. "/lazy/readme",
    files = { "README.md", "lua/**/README.md" },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },
  build = {
    -- Plugins can provide a `build.lua` file that will be executed when the plugin is installed
    -- or updated. When the plugin spec also has a `build` command, the plugin's `build.lua` not be
    -- executed. In this case, a warning message will be shown.
    warn_on_override = true,
  },
}
