--- Get highlight properties for a given highlight name
function get_hlgroup(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local hl
    if vim.api.nvim_get_hl then -- check for new neovim 0.9 API
      hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      if not hl.fg then hl.fg = "NONE" end
      if not hl.bg then hl.bg = "NONE" end
    else
      hl = vim.api.nvim_get_hl_by_name(name, vim.o.termguicolors)
      if not hl.foreground then hl.foreground = "NONE" end
      if not hl.background then hl.background = "NONE" end
      hl.fg, hl.bg = hl.foreground, hl.background
      hl.ctermfg, hl.ctermbg = hl.fg, hl.bg
      hl.sp = hl.special
    end
    return hl
  end
  return fallback or {}
end
local fg = get_hlgroup("Normal").fg
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
