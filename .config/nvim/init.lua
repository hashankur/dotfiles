-- Dependencies
require("config.options")
require("config.lazy")
require("config.keymaps")

-- Plugin specific configs
require("plugins.ayu")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.cmp")
require("plugins.telescope")
require("plugins.gitsigns")
require("plugins.lualine")
-- require("plugins.feline")
require("plugins.nvim-scrollbar")
require("plugins.null-ls")
require("plugins.prettier")
require("plugins.dashboard")
-- require("plugins.incline")
require("plugins.projections")

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

-- Set colorscheme
vim.cmd([[colorscheme ayu]])

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
