return {
	-- Color scheme
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			-- Use termguicolors if available
			if vim.fn.has("termguicolors") == 1 then
				vim.opt.termguicolors = true
			end

			-- Use the dark theme
			vim.opt.background = "dark"

			-- Set foreground ('material', 'mix', 'original')
			vim.g.gruvbox_material_foreground = "material"

			-- Set background ('hard', 'medium', 'soft)
			vim.g.gruvbox_material_background = "soft"

			-- Enable bold in function names
			vim.g.gruvbox_material_enable_bold = 1

			-- Dim inactive windows
			vim.g.gruvbox_material_dim_inactive_windows = 1

			-- For better performance
			vim.g.gruvbox_material_better_performance = 1

			-- Load the colorscheme
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},

	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = { theme = "gruvbox_dark" },
			})
		end,
	},

	-- Highlight TODOs in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- Add indentation guides even on blank lines
	{
		"lukas-reineke/indent-blankline.nvim",
		-- version = "v3.5.4",
		-- See `:help ibl`
		config = function()
			require("ibl").setup()
		end,
		main = "ibl",
		opts = {},
	},

	-- Display pending keybindings
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		dependencies = { "echasnovski/mini.icons", version = false },
		opts = {
			-- Document existing key chains
			-- leader key chains
			-- "<leader>a"
			{ "<leader>e", group = "gr[e]p" },
			{ "<leader>o", group = "[o]pen" },
			-- ["<leader>u"] = { group = "",  },
			{ "<leader>i", group = "f[i]nd" },

			{ "<leader>g", group = "[g]it" },
			{ "<leader>h", group = "[h]elp for" },
			{ "<leader>d", group = "[d]iagnostics" },
			{ "<leader>O", group = "[O]rgmode" },
			{ "<leader>r", group = "[r]un" },

			-- localleader key chains
			{ "<localleader>c", group = "[c]ode" },
			{ "<localleader>r", group = "[r]epl" },
			{ "<localleader>h", group = "git [h]unk" },
		},
	},
}
