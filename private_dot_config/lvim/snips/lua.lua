local ls = require('luasnip')
local f = ls.function_node
local i = ls.insert_node
-- local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt
-- local snips = {
-- snip.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"),
-- s("req", fmt("local {} = require('{}')", { i(1, "module") , rep(1)})),
-- }
return {
  req = fmt(
    [[local {} = require "{}"]],
    { f(function(import_name)
      local parts = vim.split(import_name[1][1], ".", true)
      return parts[#parts] or ""
    end, { 1 }), i(1) }
  ),
}
