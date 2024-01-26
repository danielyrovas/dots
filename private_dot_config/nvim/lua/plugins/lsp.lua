local lspconfig_setup = function()
  local on_attach = require "config.lsp-on-attach"
  local servers = require "config.servers"
  local lspconfig = require "lspconfig"
  local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
  local mason_servers = {} -- require("mason-lspconfig").get_installed_servers()
  local settings = require "config.lsp"

  for _, server in ipairs(vim.list_extend(servers.external, mason_servers)) do
    local opts = settings[server] or {}
    opts.capabilities = lsp_capabilities
    opts.on_attach = on_attach
    lspconfig[server].setup(opts)
  end
end

local mason_lspconfig_setup = function()
  local servers = require "config.servers"
  require("mason-lspconfig").setup()
  vim.api.nvim_create_user_command(
    "LspInstallAll",
    function() vim.cmd("LspInstall " .. table.concat(servers.mason_lsp, " ")) end,
    {}
  )
end

local mason_setup = function(_, opts)
  local servers = require "config.servers"
  require("mason").setup(opts)
  if not vim.tbl_isempty(servers.mason) then
    vim.api.nvim_create_user_command(
      "MasonInstallAll",
      function() vim.cmd("MasonInstall " .. table.concat(servers.mason, " ")) end,
      {}
    )
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", config = true },
      -- { "creativenull/efmls-configs-nvim" },
      -- {
      --   "williamboman/mason.nvim",
      --   dependencies = { "stevearc/dressing.nvim" },
      --   cmd = {
      --     "Mason",
      --     "MasonInstall",
      --     "MasonUninstall",
      --     "MasonUninstallAll",
      --     "MasonLog",
      --     "MasonUpdate",
      --     "MasonInstallAll",
      --   },
      --   build = ":MasonUpdate",
      --   opts = {
      --     max_concurrent_installers = 5,
      --     ui = {
      --       icons = {
      --         package_pending = " ",
      --         package_installed = "󰄳 ",
      --         package_uninstalled = " 󰚌",
      --       },
      --     },
      --   },
      --   config = mason_setup,
      -- },
      -- {
      --   "williamboman/mason-lspconfig.nvim",
      --   cmd = { "LspInstall", "LspUninstall", "LspInstallAll" },
      --   config = mason_lspconfig_setup,
      -- },
    },
    cmd = function(_, cmds) -- HACK: lazy load lspconfig on `:Neoconf` if neoconf is available
      if require("utils").is_available "neoconf.nvim" then table.insert(cmds, "Neoconf") end
    end,
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = lspconfig_setup,
  },
}
