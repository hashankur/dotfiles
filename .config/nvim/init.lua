-- Dependencies
require("config.options")
require("config.lazy")
require("config.keymaps")

-- Plugin specific configs
-- require("plugins.ayu")
require("plugins.catppuccin")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.cmp")
require("plugins.telescope")
require("plugins.gitsigns")
-- require("plugins.lualine")
require("plugins.feline")
-- require("plugins.nvim-scrollbar")
require("plugins.null-ls")
require("plugins.alpha")
require("plugins.incline")
require("plugins.projections")
require("plugins.tabby")
require("plugins.dap")

-- Enable Comment.nvim
require("Comment").setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require("indent_blankline").setup({
	char = "▏",
	use_treesitter = false, -- Issues with js, css
	show_first_indent_level = false,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
