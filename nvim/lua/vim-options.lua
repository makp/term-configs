vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- [[ Setting options ]]
-- See `:help vim.opt` and `:help option-list`

-- Use relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Decrease update time
vim.opt.updatetime = 250

-- Enable mouse mode (e.g., useful for line splits)
vim.opt.mouse = "a"

-- Sync OS and Nvim clipboard
vim.opt.clipboard = "unnamedplus"

-- Use nerd font
vim.g.have_nerd_font = true

-- Enable breakindent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Don't show the mode, since it's already in the status line
-- vim.opt.showmode = false

-- Case-insensitive searching unless \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim displays certain whitespace chars in the editor
--  See `:help 'list'` and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live as you type
vim.opt.inccommand = "split"

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Set spell language
vim.opt.spelllang = "en_us"

-- Use a easier keybinding for exiting terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Wrap lines at word boundaries
vim.opt.linebreak = true

--[[ -- Move to the beginning of the paragraph (a little hacky)
vim.api.nvim_set_keymap("n", "]_", "}j_", { noremap = true })
vim.api.nvim_set_keymap("n", "[_", "{{j_", { noremap = true }) ]]

--[[ -- Use j/k to move visual lines instead of actual lines
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })
vim.api.nvim_set_keymap("n", "gj", "j", { noremap = true })
vim.api.nvim_set_keymap("n", "gk", "k", { noremap = true }) ]]

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Don't automatically create commented lines with 'o'/'O' commds in Lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.opt_local.formatoptions:remove("o")
	end,
})
