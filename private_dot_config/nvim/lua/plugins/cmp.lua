return {
    {
        "L3MON4D3/LuaSnip",
        -- build = vim.fn.has "win32" == 0
        --     and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
        --   or nil,
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
            region_check_events = "CursorMoved",
            store_selection_keys = "<C-x>",
        },
        config = function(_, opts)
            if opts then require("luasnip").config.setup(opts) end
            vim.tbl_map(
                function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
                { "vscode", "snipmate", "lua" }
            )
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "f3fora/cmp-spell",
            "hrsh7th/cmp-nvim-lua",
            "lukas-reineke/cmp-rg",
        },
        event = "InsertEnter",
        opts = function()
            local cmp = require "cmp"
            local snip_status_ok, luasnip = pcall(require, "luasnip")
            local utils = require "utils"
            if not snip_status_ok then return end
            local border_opts = {
                border = "rounded",
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            }

            local function has_words_before()
                local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api
                            .nvim_buf_get_lines(0, line - 1, line, true)[1]
                            :sub(col, col)
                            :match "%s"
                        == nil
            end

            return {
                sources = cmp.config.sources {
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "nvim_lua", priority = 750 },
                    { name = "luasnip", priority = 700 },
                    { name = "buffer", priority = 500, keyword_length = 2 },
                    { name = "rg", priority = 400, keyword_length = 4 },
                    { name = "path", priority = 250 },
                    {
                        name = "spell",
                        priority = 250,
                        keyword_length = 5,
                        option = {
                            keep_all_entries = false,
                            enable_in_context = function()
                                return require("cmp.config.context").in_treesitter_capture "spell"
                            end,
                        },
                    },
                },
                enabled = function()
                    local dap_prompt = utils.is_available "cmp-dap" -- add interoperability with cmp-dap
                        and vim.tbl_contains(
                            { "dap-repl", "dapui_watches", "dapui_hover" },
                            vim.api.nvim_get_option_value("filetype", { buf = 0 })
                        )
                    if
                        vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt"
                        and not dap_prompt
                    then
                        return false
                    end
                    return vim.g.cmp_enabled
                end,
                preselect = cmp.PreselectMode.None,
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local icons = require "utils.lsp-icons"
                        vim_item.kind = string.format("%s", icons[vim_item.kind])
                        -- vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[NVIM]",
                            luasnip = "[Snip]",
                            buffer = "[Buf]",
                            rg = "[RG]",
                            path = "[Path]",
                            spell = "[SPELL]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                duplicates = {
                    nvim_lsp = 1,
                    luasnip = 1,
                    cmp_tabnine = 1,
                    buffer = 1,
                    path = 1,
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = cmp.config.window.bordered(border_opts),
                    documentation = cmp.config.window.bordered(border_opts),
                },
                mapping = {
                    -- ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
                    -- ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },

                    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.mapping.confirm { select = true },
                    ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
                    ["<CR>"] = cmp.mapping.confirm { select = false },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
            }
        end,
    },
}
