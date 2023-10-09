return {
    "nvim-lua/plenary.nvim",
    -- the colorscheme should be available when starting Neovim
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
                separator = "",
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
        "lambdalisue/fern.vim",
        cmd = "Fern",
        enabled = false,
    },
    {
        "nvim-tree/nvim-tree.lua",
        enabled = true,
        cmd = {
            "NvimTreeOpen",
            "NvimTreeFocus",
            "NvimTreeToggle",
            "NvimTreeFindFileToggle",
        },
        opts = {
            view = {
                width = 25,
            },
            filters = {
                dotfiles = true,
            },
            git = {
                enable = true,
            },
            diagnostics = {
                enable = true,
            },
        },
    },
    {
        "stevearc/oil.nvim",
        enabled = false,
        opts = {
            default_file_explorer = true,
            columns = {
                "icon",
                -- "permissions",
                "size",
                -- "mtime",
            },
            -- Buffer-local options to use for oil buffers
            buf_options = {
                buflisted = false,
                bufhidden = "hide",
            },
            -- Window-local options to use for oil buffers
            win_options = {
                wrap = false,
                signcolumn = "no",
                cursorcolumn = false,
                foldcolumn = "0",
                spell = false,
                list = false,
                conceallevel = 3,
                concealcursor = "nvic",
            },
            -- Restore window options to previous values when leaving an oil buffer
            restore_win_options = true,
            -- Skip the confirmation popup for simple operations
            skip_confirm_for_simple_edits = false,
            -- Deleted files will be removed with the trash_command (below).
            delete_to_trash = false,
            -- Change this to customize the command used when deleting to trash
            trash_command = "trash-put",
            -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
            prompt_save_on_select_new_entry = true,
            -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
            -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
            -- Additionally, if it is a string that matches "actions.<name>",
            -- it will use the mapping at require("oil.actions").<name>
            -- Set to `false` to remove a keymap
            -- See :help oil-actions for a list of all available actions
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["q"] = "actions.close",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["g."] = "actions.toggle_hidden",
            },
            -- Set to false to disable all of the above keymaps
            use_default_keymaps = true,
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = false,
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name, bufnr) return vim.startswith(name, ".") end,
                -- This function defines what will never be shown, even when `show_hidden` is set
                is_always_hidden = function(name, bufnr) return false end,
            },
            -- Configuration for the floating window in oil.open_float
            float = {
                -- Padding around the floating window
                padding = 2,
                max_width = 0,
                max_height = 0,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                override = function(conf) return conf end,
            },
            -- Configuration for the actions floating preview window
            preview = {
                -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_width and max_width can be a single value or a list of mixed integer/float types.
                -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
                max_width = 0.9,
                -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
                min_width = { 40, 0.4 },
                -- optionally define an integer/float for the exact width of the preview window
                width = nil,
                -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_height and max_height can be a single value or a list of mixed integer/float types.
                -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
                max_height = 0.9,
                -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
                min_height = { 5, 0.1 },
                -- optionally define an integer/float for the exact height of the preview window
                height = nil,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
            },
            -- Configuration for the floating progress window
            progress = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = { 10, 0.9 },
                min_height = { 5, 0.1 },
                height = nil,
                border = "rounded",
                minimized_border = "none",
                win_options = {
                    winblend = 0,
                },
            },
        },
        cmd = "Oil",
        keys = {
            {
                "-",
                function() require("oil").open() end,
                desc = "Open folder in Oil",
            },
        },
    },
    { "moll/vim-bbye", enabled = false },
}
