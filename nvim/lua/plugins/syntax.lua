-- Syntax
return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"vim",
				"vimdoc",
				"python",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,

			-- Syntax highlighting
			highlight = {
				enable = true,
			},

			-- Indentation for the = operator
			indent = {
				enable = true,
			},

			-- Incremental selection
			incremental_selection = {
				enable = true,
				keymaps = {
					-- Start incremental selection (normal mode)
					init_selection = "gnn",
					-- Increment to the upper named parent (visual mode)
					node_incremental = "grn",
					-- Increment to the upper scope (visual mode)
					scope_incremental = "grc",
					-- Decrement to the previous named node (visual mode)
					node_decremental = "grm",
				},
			},

			-- Treesitter textobjects
			textobjects = {
				select = {
					enable = true,

					-- Automatically jump forward to textobjects
					lookahead = true,

					keymaps = {
						-- Capture groups are defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						-- ["ac"] = "@class.outer",
						-- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
						-- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					},
				},
			},
		},
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		-- Run :TSModuleInfo to check if a module is enabled
		config = function(_, opts)
			-- Prefer git instead of curl in order to improve connectivity in some environments
			require("nvim-treesitter.install").prefer_git = true
			-- Setup nvim-treesitter
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
