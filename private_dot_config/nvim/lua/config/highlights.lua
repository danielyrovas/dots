local get_hlgroup = require("utils").get_hlgroup
-- get highlights from highlight groups
local fg = get_hlgroup("Normal").fg
-- local fg, bg_alt = normal.fg, normal.bg
local bg_alt = get_hlgroup("Visual").bg
local bg = get_hlgroup("FloatBorder").bg
local green = get_hlgroup("@field").fg
local red = get_hlgroup("@keyword.function").fg

return {
  TelescopeBorder = { fg = bg_alt, bg = bg },
  TelescopeNormal = { bg = bg },
  TelescopePreviewBorder = { fg = bg, bg = bg },
  TelescopePreviewNormal = { bg = bg },
  TelescopePreviewTitle = { fg = bg, bg = green },
  TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
  TelescopePromptNormal = { fg = fg, bg = bg_alt },
  TelescopePromptPrefix = { fg = red, bg = bg_alt },
  TelescopePromptTitle = { fg = bg, bg = red },
  TelescopeResultsBorder = { fg = bg, bg = bg },
  TelescopeResultsNormal = { bg = bg },
  TelescopeResultsTitle = { fg = bg, bg = bg },
}
