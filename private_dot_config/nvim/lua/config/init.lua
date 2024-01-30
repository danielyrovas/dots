for _, source in ipairs {
  "options",
  "lazy",
  "autocmds",
  "mappings",
} do
  local status_ok, fault = pcall(require, "config." .. source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

if not pcall(vim.cmd.colorscheme, vim.g.colorscheme or "habamax") then
  vim.notify(("Error setting up colorscheme: `%s`"):format(vim.g.colorscheme), vim.log.levels.ERROR)
end

vim.cmd.doautocmd "ColorScheme"
