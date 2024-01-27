return function(client, bufnr)
    local utils = require "utils"
    local maps = utils.empty_map_table()
    local is_available = utils.is_available
    local function add_buffer_autocmd(augroup, bufnr, autocmds)
        if not vim.tbl_islist(autocmds) then autocmds = { autocmds } end
        local cmds_found, cmds =
            pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
        if not cmds_found or vim.tbl_isempty(cmds) then
            vim.api.nvim_create_augroup(augroup, { clear = false })
            for _, autocmd in ipairs(autocmds) do
                local events = autocmd.events
                autocmd.events = nil
                autocmd.group = augroup
                autocmd.buffer = bufnr
                vim.api.nvim_create_autocmd(events, autocmd)
            end
        end
    end

    local function del_buffer_autocmd(augroup, bufnr)
        local cmds_found, cmds =
            pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
        if cmds_found then vim.tbl_map(function(cmd) vim.api.nvim_del_autocmd(cmd.id) end, cmds) end
    end

    --- Helper function to check if any active LSP clients given a filter provide a specific capability
    ---@param capability string The server capability to check for (example: "documentFormattingProvider")
    ---@param filter vim.lsp.get_active_clients.filter|nil (table|nil) A table with
    ---              key-value pairs used to filter the returned clients.
    ---              The available keys are:
    ---               - id (number): Only return clients with the given id
    ---               - bufnr (number): Only return clients attached to this buffer
    ---               - name (string): Only return clients with the given name
    ---@return boolean # Whether or not any of the clients provide the capability
    local function has_capability(capability, filter)
        for _, client in ipairs(vim.lsp.get_active_clients(filter)) do
            if client.supports_method(capability) then return true end
        end
        return false
    end

    -- local get_icon = utils.get_icon
    maps.n["<leader>ld"] =
    { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
    maps.n["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" }
    maps.n["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" }
    maps.n["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }

    if is_available "mason-lspconfig.nvim" then
        maps.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" }
    end

    if client.supports_method "textDocument/codeAction" then
        maps.n["<leader>la"] = {
            function() vim.lsp.buf.code_action() end,
            desc = "LSP code action",
        }
        maps.v["<leader>la"] = maps.n["<leader>la"]
    end

    if client.supports_method "textDocument/declaration" then
        maps.n["gD"] = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
        }
    end

    if client.supports_method "textDocument/definition" then
        maps.n["gd"] = {
            function() vim.lsp.buf.definition() end,
            desc = "Show the definition of current symbol",
        }
    end

    if client.supports_method "textDocument/implementation" then
        maps.n["gI"] = {
            function() vim.lsp.buf.implementation() end,
            desc = "Implementation of current symbol",
        }
    end

    if client.supports_method "textDocument/references" then
        maps.n["gr"] = {
            function() vim.lsp.buf.references() end,
            desc = "References of current symbol",
        }
        maps.n["<leader>lR"] = {
            function() vim.lsp.buf.references() end,
            desc = "Search references",
        }
    end

    if client.supports_method "textDocument/rename" then
        maps.n["<leader>lr"] = {
            function() vim.lsp.buf.rename() end,
            desc = "Rename current symbol",
        }
    end

    if client.supports_method "textDocument/signatureHelp" then
        maps.n["<leader>lh"] = {
            function() vim.lsp.buf.signature_help() end,
            desc = "Signature help",
        }
    end

    if client.supports_method "textDocument/typeDefinition" then
        maps.n["gy"] = {
            function() vim.lsp.buf.type_definition() end,
            desc = "Definition of current type",
        }
    end

    if client.supports_method "workspace/symbol" then
        maps.n["<leader>lG"] =
        { function() vim.lsp.buf.workspace_symbol() end, desc = "Search workspace symbols" }
    end

    if false and client.supports_method "textDocument/hover" then
        -- TODO: Remove mapping after dropping support for Neovim v0.9, it's automatic
        if vim.fn.has "nvim-0.10" == 0 then
            maps.n["K"] = {
                function() vim.lsp.buf.hover() end,
                desc = "Hover symbol details",
            }
        end
    end

    -- TODO: inlay hints
    if false and client.supports_method "textDocument/inlayHint" then
        if vim.b.inlay_hints_enabled == nil then
            vim.b.inlay_hints_enabled = vim.g.inlay_hints_enabled
        end
        if vim.b.inlay_hints_enabled then vim.lsp.inlay_hint(bufnr, true) end
        maps.n["<leader>uH"] = {
            function() require("utils.toggles").toggle_buffer_inlay_hints(bufnr) end,
            desc = "Toggle LSP inlay hints (buffer)",
        }
    end

    if false and client.supports_method "textDocument/codeLens" then
        add_buffer_autocmd("lsp_codelens_refresh", bufnr, {
            events = { "InsertLeave", "BufEnter" },
            desc = "Refresh codelens",
            callback = function()
                if not has_capability("textDocument/codeLens", { bufnr = bufnr }) then
                    del_buffer_autocmd("lsp_codelens_refresh", bufnr)
                    return
                end
                if vim.g.codelens_enabled then vim.lsp.codelens.refresh() end
            end,
        })
        if vim.g.codelens_enabled then vim.lsp.codelens.refresh() end
        maps.n["<leader>ll"] = {
            function() vim.lsp.codelens.refresh() end,
            desc = "LSP CodeLens refresh",
        }
        maps.n["<leader>lL"] = {
            function() vim.lsp.codelens.run() end,
            desc = "LSP CodeLens run",
        }
    end

    if client.supports_method "textDocument/documentHighlight" then
        add_buffer_autocmd("lsp_document_highlight", bufnr, {
            {
                events = { "CursorHold", "CursorHoldI" },
                desc = "highlight references when cursor holds",
                callback = function()
                    if not has_capability("textDocument/documentHighlight", { bufnr = bufnr }) then
                        del_buffer_autocmd("lsp_document_highlight", bufnr)
                        return
                    end
                    vim.lsp.buf.document_highlight()
                end,
            },
            {
                events = { "CursorMoved", "CursorMovedI", "BufLeave" },
                desc = "clear references when cursor moves",
                callback = function() vim.lsp.buf.clear_references() end,
            },
        })
    end

    if client.supports_method "textDocument/formatting" then
        local settings = require("config.lsp")[client.name]
        if settings and settings.formatting and settings.formatting.enabled == false then return end
        maps.n["<leader>lf"] = {
            function() vim.lsp.buf.format() end,
            desc = "Format buffer",
        }
        maps.v["<leader>lf"] = maps.n["<leader>lf"]
        vim.api.nvim_buf_create_user_command(
            bufnr,
            "Format",
            function() vim.lsp.buf.format() end,
            { desc = "Format file with LSP" }
        )

        if vim.b.autoformat_enabled == nil then
            vim.b.autoformat_enabled = vim.g.autoformat_enabled
        end
        add_buffer_autocmd("lsp_auto_format", bufnr, {
            events = "BufWritePre",
            desc = "autoformat on save",
            callback = function()
                if not has_capability("textDocument/formatting", { bufnr = bufnr }) then
                    del_buffer_autocmd("lsp_auto_format", bufnr)
                    return
                end
                if vim.b.autoformat_enabled then
                    -- vim.notify(tostring(vim.b[bufnr].autoformat_enabled))
                    vim.lsp.buf.format { bufnr = bufnr }
                end
            end,
        })
        maps.n["<leader>uf"] = {
            function() require("utils.toggles").toggle_buffer_autoformat() end,
            desc = "Toggle autoformatting (buffer)",
        }
        maps.n["<leader>uF"] = {
            function() require("utils.toggles").toggle_autoformat() end,
            desc = "Toggle autoformatting (global)",
        }
        -- end
    end

    if is_available "telescope.nvim" then -- setup telescope mappings if available
        maps.n["<leader>lD"] = {
            function() require("telescope.builtin").diagnostics() end,
            desc = "Search diagnostics",
        }

        if maps.n.gd then
            maps.n.gd[1] = function() require("telescope.builtin").lsp_definitions() end
        end
        if maps.n.gI then
            maps.n.gI[1] = function() require("telescope.builtin").lsp_implementations() end
        end
        if maps.n.gr then
            maps.n.gr[1] = function() require("telescope.builtin").lsp_references() end
        end
        if maps.n["<leader>lR"] then
            maps.n["<leader>lR"][1] = function() require("telescope.builtin").lsp_references() end
        end
        if maps.n.gy then
            maps.n.gy[1] = function() require("telescope.builtin").lsp_type_definitions() end
        end
        if maps.n["<leader>lG"] then
            maps.n["<leader>lG"][1] = function()
                vim.ui.input(
                    { prompt = "Symbol Query: (leave empty for word under cursor)" },
                    function(query)
                        if query then
                            -- word under cursor if given query is empty
                            if query == "" then query = vim.fn.expand "<cword>" end
                            require("telescope.builtin").lsp_workspace_symbols {
                                query = query,
                                prompt_title = ("Find word (%s)"):format(query),
                            }
                        end
                    end
                )
            end
        end
    end

    if not vim.tbl_isempty(maps.v) then
        maps.v["<leader>l"] = { desc = utils.get_icon("ActiveLSP", 1) .. "LSP" }
    end
    utils.set_mappings(maps, { buffer = bufnr })
end
