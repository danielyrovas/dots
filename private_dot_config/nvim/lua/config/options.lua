vim.opt.shortmess:append { s = true, I = true } -- disable `hit enter` prompts
vim.opt.viewoptions:remove "curdir"             -- disable saving current directory with views
vim.opt.backspace:append { "nostop" }           -- don't stop backspace at insert
vim.opt.diffopt:append "linematch:60"           -- enable linematch diff algorithm
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- opt.whichwrap:append "<>[]hl"

local options = {
    opt = {
        breakindent = true,                                     -- wrap indent to match  line start
        clipboard = "unnamedplus",                              -- connection to the system clipboard
        cmdheight = 1,                                          -- hide command line unless needed
        completeopt = { "menu", "menuone", "noselect" },        -- Options for insert mode completion
        copyindent = true,                                      -- copy the previous indentation on autoindenting
        cursorline = true,                                      -- highlight the text line of the cursor
        expandtab = true,                                       -- enable the use of space in tab
        fileencoding = "utf-8",                                 -- file content encoding for the buffer
        fillchars = { eob = " " },                              -- disable `~` on nonexistent lines
        -- fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
        foldenable = true,                                      -- enable fold for nvim-ufo
        foldlevel = 99,                                         -- set high foldlevel for nvim-ufo
        foldlevelstart = 99,                                    -- start with all code unfolded
        foldcolumn = vim.fn.has "nvim-0.9" == 1 and "1" or nil, -- show foldcolumn in nvim 0.9
        history = 100,                                          -- number of commands to remember in a history table
        ignorecase = true,                                      -- case insensitive searching
        infercase = true,                                       -- infer cases in keyword completion
        laststatus = 3,                                         -- global statusline
        linebreak = true,                                       -- wrap lines at 'breakat'
        mouse = "a",                                            -- enable mouse support
        mousemodel = "extend",                                  -- remove dog menu
        number = true,                                          -- show numberline
        preserveindent = true,                                  -- preserve indent structure as much as possible
        pumheight = 10,                                         -- height of the pop up menu
        relativenumber = false,                                 -- no trashy line number flickering
        scrolloff = 8,                                          -- number of lines to keep above and below the cursor
        shiftwidth = 4,                                         -- number of space inserted for indentation
        showmode = true,                                        -- disable showing modes in command line
        showtabline = 1,
        sidescrolloff = 4,                                      -- number of columns to keep at the sides of the cursor
        signcolumn = "no",                                      -- always show the sign column
        smartcase = true,                                       -- case sensitive searching
        splitbelow = true,                                      -- splitting a new window below the current one
        splitright = true,                                      -- splitting a new window at the right of the current one
        tabstop = 4,                                            -- number of space in a tab
        softtabstop = -1,                                       -- follow shiftwidth
        termguicolors = true,                                   -- enable 24-bit RGB color in the TUI
        timeoutlen = 500,                                       -- shorten key timeout length a little bit for which-key
        undofile = true,                                        -- enable persistent undo
        updatetime = 250,                                       -- length of time to wait before triggering the plugin
        virtualedit = "block",                                  -- allow going past end of line in visual block mode
        wrap = false,                                           -- disable wrapping of lines longer than the width of window
        writebackup = false,                                    -- disable making a backup before overwriting a file

        smartindent = true,
        spell = false,
        spelllang = "en_gb,en_au",
        spellfile = vim.fn.stdpath "config" .. "/spell/en.utf-8.add",
        thesaurus = vim.fn.stdpath "config" .. "/spell/thesaurus.txt",
        swapfile = false,
        list = true, -- show whitespace characters
        listchars = {
            -- tab = "│ →",
            tab = "│ ",
            extends = "⟩",
            precedes = "⟨",
            trail = "·",
            nbsp = "␣",
        },
        showbreak = "↪ ",
    },
    g = {
        mapleader = " ",      -- set leader key
        maplocalleader = ",", -- set default local leader key

        -- custom options or <toggles?>
        colorscheme = "tokyonight-night",
        transparent_bg = true,
        q_close_windows = { "help", "nofile", "quickfix" },
        max_file = { size = 1024 * 100, lines = 10000 }, -- set global limits for large files

        autoformat_enabled = true,                       -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
        autopairs_enabled = true,                        -- enable autopairs at start
        cmp_enabled = true,                              -- enable completion at start
        codelens_enabled = true,                         -- enable or disable automatic codelens refreshing for lsp that support it
        diagnostics_mode = 3,                            -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
        highlighturl_enabled = true,                     -- highlight URLs by default
        inlay_hints_enabled = true,                      -- enable or disable LSP inlay hints on startup (Neovim v0.10 only)
        lsp_handlers_enabled = true,                     -- enable or disable default vim.lsp.handlers (hover and signature help)
        semantic_tokens_enabled = true,                  -- enable or disable LSP semantic tokens on startup
        ui_notifications_enabled = true,                 -- disable notifications
    },
    -- t = vim.t.bufs and vim.t.bufs or { bufs = vim.api.nvim_list_bufs() }, -- initialize buffers for the current tab
}

for scope, table in pairs(options) do
    for setting, value in pairs(table) do
        vim[scope][setting] = value
    end
end

-- disable some builtin vim plugins
vim.g.disabled_plugins = {
    "2html_plugin",
    "tohtml",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "compiler",
    "bugreport",
}

local default_providers = {
    "node",
    "perl",
    "python3",
    "ruby",
}

for _, provider in ipairs(default_providers) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.g.neovide_transparency = 0.0
    vim.g.transparency = 0.0
    -- vim.o.guifont = "JetBrains\\ Mono,Hack:h27"
    vim.g.neovide_scale_factor = 1.4
end
