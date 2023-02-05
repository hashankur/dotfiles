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
require("plugins.nvim-scrollbar")
require("plugins.null-ls")
require("plugins.prettier")
require("plugins.ayu")

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make relative line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme ayu]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Enable current line highlight
vim.wo.cursorline = true


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- Enable nvim-toggler
require('nvim-toggler').setup()

-- Enable auto tag closing in html, jsx, etc.
require('nvim-ts-autotag').setup()

-- Enable cursorline to current file
require('reticle').setup {
    -- add options here or leave empty
}

-- Highlight similar words
require('illuminate').setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

