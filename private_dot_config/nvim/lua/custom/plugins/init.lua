return {
	-- minimal modes
	["Pocco81/TrueZen.nvim"] = {
		cmd = {
			"TZAtaraxis",
			"TZMinimalist",
			-- "TZFocus",
		},
		config = function()
			require("custom.plugins.truezen")
		end,
	},

	["goolord/alpha-nvim"] = {
		disable = false,
		cmd = "Alpha",
	},

	["folke/which-key.nvim"] = {
		disable = false,
	},

	["kevinhwang91/nvim-ufo"] = {
		cmd = "UfoEnable",
		requires = "kevinhwang91/promise-async",
		config = function()
			require("ufo").setup()
		end,
	},
	-- needs config ??
	["lukas-reineke/cmp-rg"] = {},
	-- ["petertriho/cmp-git"] = {
	--   -- after = "",
	--   config = function()
	--     require("cmp_git").setup()
	--   end,
	-- },

	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lsp")
		end,
	},

	-- format & linting
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},

	-- ['echasnovski/mini.nvim'] = {}

	-- Will refactor
	["phaazon/hop.nvim"] = {
		branch = "v2", -- optional but strongly recommended
		event = "VimEnter",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "arstdhneioqwfpluyxzcvkm" })
		end,
	},

	["rmagatti/auto-session"] = {
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Downloads", "/", "~/Documents" },
				auto_save_enabled = true,
				auto_restore_enabled = true,
			})
		end,
	},
	["rmagatti/session-lens"] = {
		after = "telescope.nvim",
		requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
		config = function()
			require("session-lens").setup({})
		end,
	},
	["wfxr/minimap.vim"] = { cmd = "MinimapToggle" },
	["b0o/incline.nvim"] = {
		disable = true,
		config = function()
			require("incline").setup()
		end,
	},
}