local get_icon = require("utils").get_icon
return {
    {
        "hiphish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile", "BufWritePost" },
        opts = {
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            },
            exclude = {
                filetypes = {
                    "help",
                    "startify",
                    "aerial",
                    "alpha",
                    "dashboard",
                    "lazy",
                    "neogitstatus",
                    "NvimTree",
                    "oil",
                    "fern",
                    "neo-tree",
                    "Trouble",
                },
                buftypes = {
                    "nofile",
                    "terminal",
                },
            },
        },
        config = function(_, opts)
            require("ibl").setup(opts)
            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },

    {
        "lukas-reineke/headlines.nvim",
        ft = "markdown",
        opts = {},
    },

    {
        "nvim-tree/nvim-web-devicons",
        opts = {
            override = {
                default_icon = { icon = get_icon "DefaultFile" },
                deb = { icon = "", name = "Deb" },
                lock = { icon = "󰌾", name = "Lock" },
                mp3 = { icon = "󰎆", name = "Mp3" },
                mp4 = { icon = "", name = "Mp4" },
                out = { icon = "", name = "Out" },
                ["robots.txt"] = { icon = "󰚩", name = "Robots" },
                ttf = { icon = "", name = "TrueTypeFont" },
                rpm = { icon = "", name = "Rpm" },
                woff = { icon = "", name = "WebOpenFontFormat" },
                woff2 = { icon = "", name = "WebOpenFontFormat2" },
                xz = { icon = "", name = "Xz" },
                zip = { icon = "", name = "Zip" },
            },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        enabled = vim.fn.executable "git" == 1,
        event = "VeryLazy",
        opts = {
            signcolumn = true,
            numhl = true,
            current_line_blame_opts = { ignore_whitespace = true },
            signs = {
                add = { text = get_icon "GitSign" },
                change = { text = get_icon "GitSign" },
                delete = { text = get_icon "GitSign" },
                topdelete = { text = get_icon "GitSign" },
                changedelete = { text = get_icon "GitSign" },
                untracked = { text = get_icon "GitSign" },
            },
        },
    },
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            plugins = {
                wezterm = {
                    enabled = false,
                    -- can be either an absolute font size or the number of incremental steps
                    font = "+4", -- (10% increase per step)
                },
            },
        },
    },
    {
        "folke/twilight.nvim",
        enabled = false,
        cmd = "Twilight",
        opts = {
            dimming = {
                alpha = 0.75,
            },
            context = 15,
            exclude = {
                "NvimTree",
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
        opts = {},
    },

    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = {
            use_diagnostic_signs = true,
            action_keys = {
                close = { "q", "<esc>" },
                cancel = "<c-e>",
            },
        },
    },

    {
        "kevinhwang91/nvim-ufo",
        enabled = false,
        event = { "InsertEnter", "BufReadPost", "BufNewFile", "BufWritePost" },
        dependencies = { "kevinhwang91/promise-async" },
        opts = {
            preview = {
                mappings = {
                    scrollB = "<C-b>",
                    scrollF = "<C-f>",
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                },
            },
            provider_selector = function(_, filetype, buftype)
                local function handleFallbackException(bufnr, err, providerName)
                    if type(err) == "string" and err:match "UfoFallbackException" then
                        return require("ufo").getFolds(bufnr, providerName)
                    else
                        return require("promise").reject(err)
                    end
                end

                return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
                    or function(bufnr)
                        return require("ufo")
                            .getFolds(bufnr, "lsp")
                            :catch(
                                function(err)
                                    return handleFallbackException(bufnr, err, "treesitter")
                                end
                            )
                            :catch(
                                function(err) return handleFallbackException(bufnr, err, "indent") end
                            )
                    end
            end,
        },
    },
}
