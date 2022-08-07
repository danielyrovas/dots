local present, _ = pcall(require, "lspconfig")
if not present then
  return
end

require("custom.plugins.lsp.config")

-- local present, _ = pcall(require, "mason-lspconfig")
-- if not present then
--   return
-- end
--
-- require("custom.plugins.lsp.mason-config")
