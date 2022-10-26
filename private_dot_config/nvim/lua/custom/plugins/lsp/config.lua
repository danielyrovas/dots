local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "emmet_ls", "clangd", "jsonls", "tsserver", "jdtls", "rust_analyzer", "pyright" } -- manual specification > multiple plugins

local config = {
  virtual_text = true,
  update_in_insert = true,
  underline = false,
  severity_sort = true,
  --[[ float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  }, ]]
}

vim.diagnostic.config(config)

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
