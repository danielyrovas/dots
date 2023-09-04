return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      enabled = vim.fn.executable "make" == 1,
      build = "make",
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
    },
    {
      "stevearc/dressing.nvim",
      enabled = true,
      opts = {
        input = { default_prompt = "➤ " },
        select = { backend = { "telescope", "builtin" } },
      },
    },
  },
  cmd = "Telescope",
  opts = function()
    local actions = require "telescope.actions"
    local get_icon = require("utils").get_icon
    return {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        extensions = {},
        color_devicons = true,
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        prompt_prefix = get_icon("Telescope", 1),
        selection_caret = get_icon("Selected", 1),
        path_display = { "smart" },
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.6 },
          flex = { horizontal = { preview_width = 0.9 } },
          vertical = { mirror = false },
          width = 0.9,
          height = 0.85,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<esc>"] = actions.close,
          },
          n = { q = actions.close },
        },
      },
      pickers = {
        buffers = {
          path_display = { "smart" },
          mappings = {
            i = { ["<c-d>"] = actions.delete_buffer },
            n = { ["d"] = actions.delete_buffer },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require "telescope"
    local utils = require "utils"
    local conditional_func = utils.conditional_func

    if utils.is_available "telescope-file-browser.nvim" then
      local fb_actions = telescope.extensions.file_browser.actions
      opts.defaults.extensions.file_browser = {
        mappings = {
          i = {
            ["<C-h>"] = fb_actions.toggle_hidden,
          },
          n = {
            z = fb_actions.toggle_hidden,
          },
        },
      }
    end

    telescope.setup(opts)
    conditional_func(telescope.load_extension, pcall(require, "notify"), "notify")
    conditional_func(telescope.load_extension, pcall(require, "aerial"), "aerial")
    conditional_func(
      telescope.load_extension,
      utils.is_available "telescope-fzf-native.nvim",
      "fzf"
    )
    conditional_func(
      telescope.load_extension,
      utils.is_available "telescope-file-browser.nvim",
      "file_browser"
    )
  end,
}
