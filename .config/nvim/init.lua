-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true

-- Dependencies
require("plugins")
require("keybindings")
require("lsp")

-- Plugin specific configs
require("plugins.treesitter")
require("plugins.cmp")
require("plugins.telescope")
require("plugins.gitsigns")
require("plugins.lualine")
-- require("plugins.feline")
require("plugins.nvim-scrollbar")
require("plugins.null-ls")
require("plugins.prettier")
require("plugins.ayu")
require("plugins.dashboard")
require("plugins.nvim-ts-rainbow")
-- require("plugins.incline")

local function list(value, str, sep)
	sep = sep or ","
	str = str or ""
	value = type(value) == "table" and table.concat(value, sep) or value
	return str ~= "" and table.concat({ value, str }, sep) or value
end

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make relative line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set colorscheme
vim.cmd([[colorscheme ayu]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Enable current line highlight
vim.wo.cursorline = true

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.o.smartindent = true

vim.o.wrap = false

-- Keep scroll space for context
vim.o.scrolloff = 8

vim.o.fillchars = list({
	-- "vert:▏",
	"vert:│",
	"diff:╱",
	"foldclose:",
	"foldopen:",
	"fold: ",
	"msgsep:─",
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Global statusline
vim.o.laststatus = 3

-- Enable Comment.nvim
require("Comment").setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require("indent_blankline").setup({
	char = "▏",
	show_trailing_blankline_indent = false,
	use_treesitter = true,
	show_current_context = false,
	show_first_indent_level = false,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
