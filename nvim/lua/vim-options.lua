-- Setting options
-- See `:help vim.opt` and `:help option-list`

local opt = vim.opt

-- Configure indentation
opt.expandtab = true -- Insert spaces when <Tab> is pressed
opt.tabstop = 2 -- <Tab> width
opt.softtabstop = 2 -- Number of spaces for each <Tab> press
opt.shiftwidth = 2 -- Number of spaces with < and > cmds
opt.smartindent = true -- Autoindent when starting a new line

vim.g.markdown_indent_level = 2 -- Default is 4

-- Use relative line numbers
opt.number = true
opt.relativenumber = true

-- Show which line your cursor is on
opt.cursorline = true

-- Decrease update time
opt.updatetime = 250

-- Enable mouse mode (e.g., useful for line splits)
opt.mouse = "a"

-- Sync OS and Nvim clipboard
opt.clipboard = "unnamedplus"

-- Use nerd font
vim.g.have_nerd_font = true

-- Enable breakindent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Don't show the mode, since it's already in the status line
-- vim.opt.showmode = false

-- Case-insensitive searching unless \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Preview substitutions live as you type
opt.inccommand = "split"

-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Set spell language
opt.spelllang = "en_us"

-- Enable folding in markdown buffers
vim.g.markdown_folding = 1

-- Wrap lines at word boundaries
opt.linebreak = true

-- Scroll with screen lines
opt.smoothscroll = true

-- Set minimum window width
opt.winminwidth = 5

-- Autocommands
-- See `:help lua-guide-autocommands`

local function add_augroup(name)
	return vim.api.nvim_create_augroup("mk_" .. name, { clear = true })
end

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = add_augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = add_augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = add_augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
