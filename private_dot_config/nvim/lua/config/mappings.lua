local utils = require "utils"
local ui = require "utils.toggles"
local is_available = utils.is_available
local get_icon = utils.get_icon
local maps = utils.empty_map_table()

local sections = {
    f = { desc = get_icon("Search", 1) .. "Find" },
    p = { desc = get_icon("Package", 1) .. "Packages" },
    l = { desc = get_icon("ActiveLSP", 1) .. "LSP" },
    u = { desc = get_icon("Window", 1) .. "UI/UX" },
    b = { desc = get_icon("Tab", 1) .. "Buffers" },
    bs = { desc = get_icon("Sort", 1) .. "Sort Buffers" },
    d = { desc = get_icon("Debugger", 1) .. "Debugger" },
    g = { desc = get_icon("Git", 1) .. "Git" },
    S = { desc = get_icon("Session", 1) .. "Session" },
    t = { desc = get_icon("Terminal", 1) .. "Terminal" },
}

maps.n = {
    ["q;"] = ":q",
    ["q:"] = ":q",
    [";"] = { ":", desc = "Easy CMD mode" },
    [":"] = { ";", desc = "Hard semicolon mode" },
    ["<leader>bm"] = { "<cmd>%s///gn<cr>", desc = "Count Matches" },
    ["<leader>c"] = { "<cmd>bp|bd #<cr>", desc = "Stably delete buffer" },

    ["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" },
    ["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" },
    ["<leader>w"] = { "<cmd>w<cr>", desc = "Save" },
    ["<leader>q"] = { "<cmd>confirm q<cr>", desc = "Quit" },
    ["<leader>n"] = { "<cmd>enew<cr>", desc = "New File" },
    ["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" },
    ["<C-c>"] = { "<cmd>%y<cr>", desc = "Copy buffer" },
    ["ygb"] = { "<cmd>%y<cr>", desc = "Copy buffer" },
    ["<C-q>"] = { "<cmd>qa!<cr>", desc = "Force quit" },
    ["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
    ["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" },

    -- Plugin Manager
    ["<leader>p"] = sections.p,
    ["<leader>pi"] = {
        function() require("lazy").install() end,
        desc = "Plugins Install",
    },
    ["<leader>ps"] = {
        function() require("lazy").home() end,
        desc = "Plugins Status",
    },
    ["<leader>pS"] = {
        function() require("lazy").sync() end,
        desc = "Plugins Sync",
    },
    ["<leader>pu"] = {
        function() require("lazy").check() end,
        desc = "Plugins Check Updates",
    },
    ["<leader>pU"] = {
        function() require("lazy").update() end,
        desc = "Plugins Update",
    },

    -- Navigate tabs
    ["]t"] = {
        function() vim.cmd.tabnext() end,
        desc = "Next tab",
    },
    ["[t"] = {
        function() vim.cmd.tabprevious() end,
        desc = "Previous tab",
    },

    ["<leader>u"] = sections.u,
    ["<leader>ud"] = { ui.toggle_diagnostics, desc = "Toggle diagnostics" },
    ["<leader>ug"] = { ui.toggle_signcolumn, desc = "Toggle signcolumn" },
    ["<leader>ui"] = { ui.set_indent, desc = "Change indent setting" },
    ["<leader>ul"] = { ui.toggle_statusline, desc = "Toggle statusline" },
    ["<leader>uL"] = { ui.toggle_codelens, desc = "Toggle CodeLens" },
    ["<leader>un"] = { ui.change_number, desc = "Change line numbering" },
    ["<leader>uN"] = { ui.toggle_ui_notifications, desc = "Toggle Notifications" },
    ["<leader>up"] = { ui.toggle_paste, desc = "Toggle paste mode" },
    ["<leader>us"] = { ui.toggle_spell, desc = "Toggle spellcheck" },
    ["<leader>uS"] = { ui.toggle_conceal, desc = "Toggle conceal" },
    ["<leader>ut"] = { ui.toggle_tabline, desc = "Toggle tabline" },
    ["<leader>uu"] = { ui.toggle_url_match, desc = "Toggle URL highlight" },
    ["<leader>uw"] = { ui.toggle_wrap, desc = "Toggle wrap" },
    ["<leader>uy"] = { ui.toggle_syntax, desc = "Toggle syntax highlighting (buffer)" },
    ["<leader>uh"] = { ui.toggle_foldcolumn, desc = "Toggle foldcolumn" },

    -- Firefly Script mappings
    ["<leader>r"] = { name = "Firefly" },
    ["<leader>rr"] = {
        "<cmd>%s/\\.tmp-/\\/tmp\\/<cr><cmd>%s/puts/logger.info<cr>",
        desc = "set for firefly",
    },
    ["<leader>ri"] = {
        "<cmd>%s/\\/tmp\\//\\.tmp-/<cr><cmd>%s/logger.info/puts<cr>",
        desc = "set for local (from info)",
    },
    ["<leader>rp"] = {
        "<cmd>%s/\\.tmp-/\\/tmp\\/<cr><cmd>%s/puts/logger.debug<cr>",
        desc = "set for firefly (to debug)",
    },
    ["<leader>rd"] = {
        "<cmd>%s/\\/tmp\\//\\.tmp-/<cr><cmd>%s/logger.debug/puts<cr>",
        desc = "set for local (from debug)",
    },
    ["<leader>rc"] = {
        "vipJVyu",
        desc = "Copy paragraph without newlines",
    },
    ["<leader>rb"] = {
        "GVggJVyu",
        desc = "Copy buffer without newlines",
    },
}

maps.v = {
    -- Stay in indent mode
    ["<S-Tab>"] = { "<gv", desc = "Unindent line" },
    ["<Tab>"] = { ">gv", desc = "Indent line" },

    ["<leader>rc"] = {
        "JVyu",
        desc = "Copy selection without newlines",
    },
}

-- Comment
if is_available "Comment.nvim" then
    maps.n["<leader>/"] = {
        function()
            require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
        end,
        desc = "Toggle comment line",
    }
    maps.v["<leader>/"] = {
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        desc = "Toggle comment for selection",
    }
end

-- GitSigns
if is_available "gitsigns.nvim" then
    maps.n["<leader>g"] = sections.g
    maps.n["]g"] = {
        function() require("gitsigns").next_hunk() end,
        desc = "Next Git hunk",
    }
    maps.n["[g"] = {
        function() require("gitsigns").prev_hunk() end,
        desc = "Previous Git hunk",
    }
    maps.n["<leader>gl"] = {
        function() require("gitsigns").blame_line() end,
        desc = "View Git blame",
    }
    maps.n["<leader>gL"] = {
        function() require("gitsigns").blame_line { full = true } end,
        desc = "View full Git blame",
    }
    maps.n["<leader>gp"] = {
        function() require("gitsigns").preview_hunk() end,
        desc = "Preview Git hunk",
    }
    maps.n["<leader>gh"] = {
        function() require("gitsigns").reset_hunk() end,
        desc = "Reset Git hunk",
    }
    maps.n["<leader>gr"] = {
        function() require("gitsigns").reset_buffer() end,
        desc = "Reset Git buffer",
    }
    maps.n["<leader>gs"] = {
        function() require("gitsigns").stage_hunk() end,
        desc = "Stage Git hunk",
    }
    maps.n["<leader>gS"] = {
        function() require("gitsigns").stage_buffer() end,
        desc = "Stage Git buffer",
    }
    maps.n["<leader>gu"] = {
        function() require("gitsigns").undo_stage_hunk() end,
        desc = "Unstage Git hunk",
    }
    maps.n["<leader>gd"] = {
        function() require("gitsigns").diffthis() end,
        desc = "View Git diff",
    }
end

if is_available "resession.nvim" then
    maps.n["<leader>S"] = sections.S
    maps.n["<leader>Sl"] = {
        function() require("resession").load "Last Session" end,
        desc = "Load last session",
    }
    maps.n["<leader>Ss"] = {
        function() require("resession").save() end,
        desc = "Save this session",
    }
    maps.n["<leader>St"] = {
        function() require("resession").save_tab() end,
        desc = "Save this tab's session",
    }
    maps.n["<leader>Sd"] = {
        function() require("resession").delete() end,
        desc = "Delete a session",
    }
    maps.n["<leader>Sf"] = {
        function() require("resession").load() end,
        desc = "Load a session",
    }
    maps.n["<leader>S."] = {
        function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
        desc = "Load current directory session",
    }
end

-- Package Manager
if is_available "mason.nvim" then
    maps.n["<leader>pm"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
    maps.n["<leader>pM"] = { "<cmd>MasonUpdateAll<cr>", desc = "Mason Update" }
end

-- Smart Splits
if is_available "smart-splits.nvim" then
    maps.n["<C-h>"] = {
        function() require("smart-splits").move_cursor_left() end,
        desc = "Move to left split",
    }
    maps.n["<C-j>"] = {
        function() require("smart-splits").move_cursor_down() end,
        desc = "Move to below split",
    }
    maps.n["<C-k>"] = {
        function() require("smart-splits").move_cursor_up() end,
        desc = "Move to above split",
    }
    maps.n["<C-l>"] = {
        function() require("smart-splits").move_cursor_right() end,
        desc = "Move to right split",
    }
    maps.n["<C-Up>"] = {
        function() require("smart-splits").resize_up() end,
        desc = "Resize split up",
    }
    maps.n["<C-Down>"] = {
        function() require("smart-splits").resize_down() end,
        desc = "Resize split down",
    }
    maps.n["<C-Left>"] = {
        function() require("smart-splits").resize_left() end,
        desc = "Resize split left",
    }
    maps.n["<C-Right>"] = {
        function() require("smart-splits").resize_right() end,
        desc = "Resize split right",
    }
else
    maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
    maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
    maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
    maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
    maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
    maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
    maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
    maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

-- SymbolsOutline
if is_available "aerial.nvim" then
    maps.n["<leader>l"] = sections.l
    maps.n["<leader>lS"] = {
        function() require("aerial").toggle() end,
        desc = "Symbols outline",
    }
end

-- Telescope
if is_available "telescope.nvim" then
    maps.n["<leader>f"] = sections.f
    maps.n["<leader>g"] = sections.g
    maps.n["<leader>gb"] = {
        function() require("telescope.builtin").git_branches { use_file_path = true } end,
        desc = "Git branches",
    }
    maps.n["<leader>gc"] = {
        function() require("telescope.builtin").git_commits { use_file_path = true } end,
        desc = "Git commits (repository)",
    }
    maps.n["<leader>gC"] = {
        function() require("telescope.builtin").git_bcommits { use_file_path = true } end,
        desc = "Git commits (current file)",
    }
    maps.n["<leader>gt"] = {
        function() require("telescope.builtin").git_status { use_file_path = true } end,
        desc = "Git status",
    }
    maps.n["<leader>f<CR>"] = {
        function() require("telescope.builtin").resume() end,
        desc = "Resume previous search",
    }
    maps.n["<leader>f'"] = {
        function() require("telescope.builtin").marks() end,
        desc = "Find marks",
    }
    maps.n["<leader>f/"] = {
        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        desc = "Find words in current buffer",
    }
    maps.n["<leader>fb"] = {
        function() require("telescope.builtin").buffers() end,
        desc = "Find buffers",
    }
    maps.n["<leader>fc"] = {
        function() require("telescope.builtin").grep_string() end,
        desc = "Find word under cursor",
    }
    maps.n["<leader>fC"] = {
        function() require("telescope.builtin").commands() end,
        desc = "Find commands",
    }
    maps.n["<leader>ff"] = {
        function() require("telescope.builtin").find_files() end,
        desc = "Find files",
    }
    maps.n["<leader>fF"] = {
        function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
        desc = "Find all files",
    }
    maps.n["<leader>fh"] = {
        function() require("telescope.builtin").help_tags() end,
        desc = "Find help",
    }
    maps.n["<leader>fk"] = {
        function() require("telescope.builtin").keymaps() end,
        desc = "Find keymaps",
    }
    maps.n["<leader>fm"] = {
        function() require("telescope.builtin").man_pages() end,
        desc = "Find man",
    }
    if is_available "nvim-notify" then
        maps.n["<leader>fn"] = {
            function() require("telescope").extensions.notify.notify() end,
            desc = "Find notifications",
        }
    end
    maps.n["<leader>fo"] = {
        function() require("telescope.builtin").oldfiles() end,
        desc = "Find history",
    }
    maps.n["<leader>fr"] = {
        function() require("telescope.builtin").registers() end,
        desc = "Find registers",
    }
    maps.n["<leader>fT"] = {
        function() require("telescope.builtin").colorscheme { enable_preview = true } end,
        desc = "Find themes",
    }
    maps.n["<leader>fw"] = {
        function() require("telescope.builtin").live_grep() end,
        desc = "Find words",
    }
    maps.n["<leader>fW"] = {
        function()
            require("telescope.builtin").live_grep {
                additional_args = function(args)
                    return vim.list_extend(args, { "--hidden", "--no-ignore" })
                end,
            }
        end,
        desc = "Find words in all files",
    }
    maps.n["<leader>fl"] = {
        function() require("telescope.builtin").highlights() end,
        desc = "Find Highlights",
    }
    maps.n["<leader>l"] = sections.l
    maps.n["<leader>ls"] = {
        function()
            local aerial_avail, _ = pcall(require, "aerial")
            if aerial_avail then
                require("telescope").extensions.aerial.aerial()
            else
                require("telescope.builtin").lsp_document_symbols()
            end
        end,
        desc = "Search symbols",
    }
    maps.n["<leader><leader>"] = {
        function()
            require("telescope.builtin").buffers(require("telescope.themes").get_dropdown {
                previewer = false,
                sort_mru = true,
                -- ignore_current_buffer = true,
            })
        end,
        desc = "Find Buffers",
    }
    maps.n["<leader>,"] = {
        function()
            require("telescope.builtin").current_buffer_fuzzy_find(
                require("telescope.themes").get_dropdown { previewer = false }
            )
        end,
        desc = "Current Buffer Fuzzy Find",
    }
    maps.n["<leader>m"] = {
        function()
            require("telescope.builtin").current_buffer_fuzzy_find(
                require("utils").extend_tbl(
                    require("telescope.themes").get_dropdown { previewer = false },
                    { fuzzy = false, case_mode = "smart_case" }
                )
            )
        end,
        desc = "Current Buffer Fuzzy Find",
    }

    if is_available "todo-comments.nvim" then
        maps.n["<leader>ft"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" }
    end
    if is_available "telescope-file-browser.nvim" then
        maps.n["<leader>fe"] = { "<cmd>Telescope file_browser<cr>", desc = "File Explorer" }
    end
end

if is_available "nvim-dap" then
    maps.n["<leader>d"] = sections.d
    maps.v["<leader>d"] = sections.d
    -- modified function keys found with `showkey -a` in the terminal to get key code
    -- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
    maps.n["<F5>"] = {
        function() require("dap").continue() end,
        desc = "Debugger: Start",
    }
    maps.n["<F17>"] = {
        function() require("dap").terminate() end,
        desc = "Debugger: Stop",
    } -- Shift+F5
    maps.n["<F21>"] = { -- Shift+F9
        function()
            vim.ui.input({ prompt = "Condition: " }, function(condition)
                if condition then require("dap").set_breakpoint(condition) end
            end)
        end,
        desc = "Debugger: Conditional Breakpoint",
    }
    maps.n["<F29>"] = {
        function() require("dap").restart_frame() end,
        desc = "Debugger: Restart",
    } -- Control+F5
    maps.n["<F6>"] = {
        function() require("dap").pause() end,
        desc = "Debugger: Pause",
    }
    maps.n["<F9>"] = {
        function() require("dap").toggle_breakpoint() end,
        desc = "Debugger: Toggle Breakpoint",
    }
    maps.n["<F10>"] = {
        function() require("dap").step_over() end,
        desc = "Debugger: Step Over",
    }
    maps.n["<F11>"] = {
        function() require("dap").step_into() end,
        desc = "Debugger: Step Into",
    }
    maps.n["<F23>"] = {
        function() require("dap").step_out() end,
        desc = "Debugger: Step Out",
    } -- Shift+F11
    maps.n["<leader>db"] = {
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint (F9)",
    }
    maps.n["<leader>dB"] = {
        function() require("dap").clear_breakpoints() end,
        desc = "Clear Breakpoints",
    }
    maps.n["<leader>dc"] = {
        function() require("dap").continue() end,
        desc = "Start/Continue (F5)",
    }
    maps.n["<leader>dC"] = {
        function()
            vim.ui.input({ prompt = "Condition: " }, function(condition)
                if condition then require("dap").set_breakpoint(condition) end
            end)
        end,
        desc = "Conditional Breakpoint (S-F9)",
    }
    maps.n["<leader>di"] = {
        function() require("dap").step_into() end,
        desc = "Step Into (F11)",
    }
    maps.n["<leader>do"] = {
        function() require("dap").step_over() end,
        desc = "Step Over (F10)",
    }
    maps.n["<leader>dO"] = {
        function() require("dap").step_out() end,
        desc = "Step Out (S-F11)",
    }
    maps.n["<leader>dq"] = {
        function() require("dap").close() end,
        desc = "Close Session",
    }
    maps.n["<leader>dQ"] = {
        function() require("dap").terminate() end,
        desc = "Terminate Session (S-F5)",
    }
    maps.n["<leader>dp"] = {
        function() require("dap").pause() end,
        desc = "Pause (F6)",
    }
    maps.n["<leader>dr"] = {
        function() require("dap").restart_frame() end,
        desc = "Restart (C-F5)",
    }
    maps.n["<leader>dR"] = {
        function() require("dap").repl.toggle() end,
        desc = "Toggle REPL",
    }
    maps.n["<leader>ds"] = {
        function() require("dap").run_to_cursor() end,
        desc = "Run To Cursor",
    }

    if is_available "nvim-dap-ui" then
        maps.n["<leader>dE"] = {
            function()
                vim.ui.input({ prompt = "Expression: " }, function(expr)
                    if expr then require("dapui").eval(expr, { enter = true }) end
                end)
            end,
            desc = "Evaluate Input",
        }
        maps.v["<leader>dE"] = {
            function() require("dapui").eval() end,
            desc = "Evaluate Input",
        }
        maps.n["<leader>du"] = {
            function() require("dapui").toggle() end,
            desc = "Toggle Debugger UI",
        }
        maps.n["<leader>dh"] = {
            function() require("dap.ui.widgets").hover() end,
            desc = "Debugger Hover",
        }
    end
end

-- Improved Code Folding
if is_available "nvim-ufo" then
    maps.n["zR"] = {
        function() require("ufo").openAllFolds() end,
        desc = "Open all folds",
    }
    maps.n["zM"] = {
        function() require("ufo").closeAllFolds() end,
        desc = "Close all folds",
    }
    maps.n["zr"] = {
        function() require("ufo").openFoldsExceptKinds() end,
        desc = "Fold less",
    }
    maps.n["zm"] = {
        function() require("ufo").closeFoldsWith() end,
        desc = "Fold more",
    }
    maps.n["zp"] = {
        function() require("ufo").peekFoldedLinesUnderCursor() end,
        desc = "Peek fold",
    }
end

-- Custom menu for modification of the user experience
if is_available "nvim-autopairs" then
    maps.n["<leader>ua"] = { ui.toggle_autopairs, desc = "Toggle autopairs" }
end
maps.n["<leader>ub"] = { ui.toggle_background, desc = "Toggle background" }
if is_available "nvim-cmp" then
    maps.n["<leader>uc"] = { ui.toggle_cmp, desc = "Toggle autocompletion" }
end
if is_available "nvim-colorizer.lua" then
    maps.n["<leader>uC"] = { "<cmd>ColorizerToggle<cr>", desc = "Toggle color highlight" }
end

if is_available "trouble.nvim" then
    maps = utils.extend_tbl(maps, {
        n = {
            ["<leader>x"] = { desc = "󰒡 Trouble" },
            ["<leader>xx"] = {
                "<cmd>TroubleToggle document_diagnostics<cr>",
                desc = "Document Diagnostics (Trouble)",
            },
            ["<leader>xX"] = {
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                desc = "Workspace Diagnostics (Trouble)",
            },
            ["<leader>xl"] = {
                "<cmd>TroubleToggle loclist<cr>",
                desc = "Location List (Trouble)",
            },
            ["<leader>xq"] = {
                "<cmd>TroubleToggle quickfix<cr>",
                desc = "Quickfix List (Trouble)",
            },
            ["<leader>xt"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
        },
    })
end

if is_available "neo-tree.nvim" then
    maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
    maps.n["<leader>o"] = {
        function()
            if vim.bo.filetype == "neo-tree" then
                vim.cmd.wincmd "p"
            else
                vim.cmd.Neotree "focus"
            end
        end,
        desc = "Toggle Explorer Focus",
    }
end

if is_available "nvim-tree.lua" then
    maps.n["<leader>e"] = {
        function() vim.cmd [[ NvimTreeToggle ]] end,
        desc = "Toggle Explorer",
    }
    maps.n["<leader>o"] = {
        function()
            if vim.bo.filetype == "NvimTree" then
                vim.cmd.wincmd "p"
            else
                vim.cmd [[ NvimTreeFindFile ]]
            end
        end,
        desc = "Toggle Explorer Focus",
    }
end

if is_available "fern.vim" then
    maps.n["-"] = { "<cmd>Fern . -reveal=%<cr>", desc = "Reveal in Directory" }
    maps.n["<leader>e"] = {
        function()
            if vim.bo.filetype == "fern" then
                vim.cmd.wincmd "p"
            else
                vim.cmd [[ Fern . -drawer ]]
            end
        end,
        desc = "Toggle Explorer Focus",
    }
end

if is_available "zen-mode.nvim" then
    maps.n["<leader>z"] = {
        "<cmd>ZenMode<cr>",
        desc = "Toggle Zen Mode",
    }
end

-- if is_available "mini.bufremove" then
--   maps.n["<leader>c"] = {
--     function()
--       require("mini.bufremove").delete()
--     end,
--     desc = "Delete current buffer",
--   }
--   maps.n["<leader>C"] = {
--     function()
--       require("mini.bufremove").delete(true)
--     end,
--     desc = "Delete current buffer",
--   }
-- end
--
utils.set_mappings(maps)
