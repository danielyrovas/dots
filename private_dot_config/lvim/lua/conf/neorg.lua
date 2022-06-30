local status_ok, neorg = pcall(require, 'neorg')
if not status_ok then
  vim.notify 'Neorg did not load'
  return
end

neorg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.keybinds"] = {
      config = {
        default_keybinds = false,
      }
    },
    ["core.norg.journal"] = {
      config = {
        workspace = "notes"
      }
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Documents/notes",
          tasks = "~/Documents/tasks",
        },
        autochdir = true,
        index = "index.norg",
      }
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "tasks",
      }
    },
    ["core.gtd.ui"] = {},
    ["core.norg.concealer"] = {},
    -- ["core.norg.completion"] = { config = { 'nvim-cmp'}},
    -- ["core.integrations.nvim-cmp"] = {},
  }
}
