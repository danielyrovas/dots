return {
    {
        "echasnovski/mini.files",
        enabled = false,
        opts = {
            options = { use_as_default_explorer = true },
            windows = { preview = true },
            mappings = {
                close = "q",
                go_in = "l",
                go_in_plus = "<CR>",
                go_out = "h",
                go_out_plus = "H",
                reset = "<BS>",
                reveal_cwd = "@",
                show_help = "g?",
                synchronize = "=",
                trim_left = "<",
                trim_right = ">",
            },
        },
        keys = {
            {
                "_",
                function() require("mini.files").open() end,
                desc = "Open folder in Mini.Files",
            },
        },
    },
    {
        "echasnovski/mini.bufremove",
        enabled = false,
        keys = { "<leader>C", "<leader>c" },
        opts = {},
    },
}
