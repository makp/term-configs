-- TODO:
-- - Maybe integrate LSP with breadcrumb-like feature. Maybe nvim.navic?
return {
	{
		-- Configure LSP servers
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Enable the following language servers
			-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
			local servers = {
				pyright = {
					root_dir = function()
						return vim.fn.getcwd()
					end,
				},
				texlab = {
					settings = {
						texlab = {
							chktex = {
								onEdit = true,
								onOpenAndSave = true,
							},
							forwardSearch = {
								executable = "zathura",
								args = { "--synctex-forward", "%l:1:%f", "%p" },
							},
						},
					},
				},
				marksman = {},
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- Ignore Lua_LS's noisy `missing-fields` warnings
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
			}

			local servers_to_install = vim.tbl_keys(servers or {})

			-- Have LSPs play nicely with cmp
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			require("mason-lspconfig").setup({
				ensure_installed = servers_to_install,
				automatic_installation = true,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	-- Configure LuaLS for Neovim config
	{
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{
			-- `vim.uv` typings
			"Bilal2453/luvit-meta",
			lazy = true,
		},
		{
			-- Completion source for require statements and module annotations
			"hrsh7th/nvim-cmp",
			opts = function(_, opts)
				opts.sources = opts.sources or {}
				table.insert(opts.sources, {
					name = "lazydev",
					group_index = 0, -- set group index to 0 to skip loading LuaLS completions
				})
			end,
		},
	},
	{
		-- Display notifications LSP progress
		"j-hui/fidget.nvim",
		opts = {},
	},
}
