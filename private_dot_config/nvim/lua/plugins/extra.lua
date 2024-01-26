return {
    {
        "dhruvasagar/vim-table-mode",
        cmd = "TableModeToggle",
        config = function()
            vim.g.table_mode_corner = "|"
            vim.g.table_mode_syntax = 0
        end,
    },
}
