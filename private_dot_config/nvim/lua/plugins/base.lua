local get_icon = require("utils").get_icon

return {
    "nvim-lua/plenary.nvim",
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = {
            transparent = vim.g.transparent_bg,
            dim_inactive = true, -- dims inactive windows
            styles = {
                sidebars = "transparent", -- style for sidebars, see below
                floats = "transparent", -- style for floating windows
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        enabled = true,
        opts = {
            icons = {
                -- group = "",
                separator = get_icon("Separator"),
            },
            disable = { filetypes = { "TelescopePrompt" } },
        },
        config = function(_, opts)
            require("which-key").setup(opts)
            require("utils").which_key_register()
        end,
    },
    {
        "ggandor/flit.nvim",
        keys = function()
            local ret = {}
            for _, key in ipairs { "f", "F", "t", "T" } do
                ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
            end
            return ret
        end,
        opts = { multiline = false, labeled_modes = "nxo" },
        dependencies = {
            "ggandor/leap.nvim",
            keys = {
                { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
                { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
                { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
            },
            config = function(_, opts)
                local leap = require "leap"
                for k, v in pairs(opts) do
                    leap.opts[k] = v
                end
                leap.add_default_mappings(true)
            end,
            dependencies = {
                "tpope/vim-repeat",
            },
        },
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
        "numToStr/Comment.nvim",
        keys = {
            { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
            { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
        },
        opts = function()
            local commentstring_avail, commentstring =
                pcall(require, "ts_context_commentstring.integrations.comment_nvim")
            return commentstring_avail
                    and commentstring
                    and { pre_hook = commentstring.create_pre_hook() }
                or {}
        end,
    },
    {
        -- "Darazaki/indent-o-matic",
        "nmac427/guess-indent.nvim",
        opts = {},
        event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    },
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

}
