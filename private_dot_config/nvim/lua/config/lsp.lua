local lsp_config = {
    lua_ls = {
        formatting = { enabled = false },
        settings = {
            Lua = {
                workspace = {
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                        [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
            },
        },
    },
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                procMacro = { enable = true },
                cargo = { allFeatures = true },
                checkOnSave = {
                    command = "clippy",
                    extraArgs = { "--no-deps" },
                },
            },
        },
    },
    tsserver = {
        init_options = {
            preferences = {
                disableSuggestions = true,
            },
        },
    },
    biome = {
        enabled = false,
    },
}

local is_available = require("utils").is_available

if is_available "efmls-configs-nvim" then
    local efm_languages = require("efmls-configs.defaults").languages()
    local prettier_d = require "efmls-configs.formatters.prettier_d"
    local fixjson = require "efmls-configs.formatters.fixjson"
    local stylua = require "efmls-configs.formatters.stylua"
    efm_languages.typescript = { prettier_d }
    efm_languages.javascript = { prettier_d }
    efm_languages.json = { fixjson }
    efm_languages.lua = { stylua }
    lsp_config.efm = {
        filetypes = vim.tbl_keys(efm_languages),
        settings = {
            rootMarkers = { ".git/" },
            languages = efm_languages,
        },
        init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
        },
    }
end

return lsp_config
