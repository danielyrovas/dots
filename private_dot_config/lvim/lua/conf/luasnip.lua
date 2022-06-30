local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  return
end

local types = require "luasnip.util.types"

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = {{"●", "Error"}}
      }
    },
    [types.insertNode] = {
      active = {
        virt_text = {{"|", "Ok"}}
      }
    }
  },
}

local snippet = ls.s
local i = ls.insert_node
local t = ls.text_node
-- local types = require "luasnip.util.types"
-- local f = ls.function_node
-- local c = ls.choice_node
-- local rep = require('luasnip.extras').rep
-- local fmt = require('luasnip.extras.fmt').fmt

local opts = { silent = true }
local map = vim.keymap.set

map({"i", "s"}, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, opts )
map({"i", "s"}, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, opts )
map({"i",}, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, opts )
map("n", "<leader><leader>s", "<cmd>source ~/.config/lvim/luasnip.lua<CR>" , opts)

local shortcut = function(val)
  if type(val) == "string" then
    return { t { val }, i(0) }
  end

  if type(val) == "table" then
    for k, v in ipairs(val) do
      if type(v) == "string" then
        val[k] = t { v }
      end
    end
  end

  return val
end

local make = function(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    table.insert(result, (snippet({ trig = k, desc = v.desc }, shortcut(v))))
  end

  return result
end

local snippets = {}

snippets.all = {}

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("snips/*.lua", true)) do
  local ft = vim.fn.fnamemodify(ft_path, ":t:r")
  snippets[ft] = make(loadfile(ft_path)())
end

ls.snippets = snippets
