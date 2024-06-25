return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			require("neo-tree").setup({
				window = {
					mappings = {
						["<C-c>"] = "close_window",
						["gv"] = "open_vsplit", -- not the best keymap
						["gs"] = "open_split",
					},
				},
				filesystem = {
					hijack_netrw_behavior = "disabled",
					-- follow_current_file = { enabled = true },
				},
			})
			vim.keymap.set("n", "<leader>ob", ":Neotree buffers toggle<CR>", { desc = "Open [b]uffers using neotree" })
			vim.keymap.set(
				"n",
				"<leader>of",
				":Neotree reveal toggle<CR>",
				{ desc = "Toggle [f]ilesystem with neotree" }
			)

			vim.keymap.set(
				"n",
				"<leader>gt",
				":Neotree reveal git_status toggle<CR>",
				{ desc = "Toggle git status with neo[t]ree" }
			)
		end,
	},

	-- Plain text file manager
	-- Type `g?` to see all keybindings
	-- See `:help oil-actions` for available cmds
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				keymaps = {
					["<A-v>"] = {
						"actions.select",
						opts = { vertical = true },
						desc = "Open the entry in a vertical split",
					},
					["<A-s>"] = {
						"actions.select",
						opts = { horizontal = true },
						desc = "Open the entry in a horizontal split",
					},
					["~"] = false, -- it was tcd
					["`"] = false, -- it was cd
					["g."] = "actions.cd", -- it was toggle_hidden
					["<C-h>"] = "actions.toggle_hidden", -- it was hor split
					["<C-s>"] = "actions.change_sort", -- it was vert split
				},
				view_options = { show_hidden = true },
			})
			vim.keymap.set("n", "<leader>o-", "<cmd>Oil<cr>", { desc = "parent directory" })
		end,
	},
}
