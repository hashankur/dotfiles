-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
		},
	},

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	},

	-- Git related plugins
	"lewis6991/gitsigns.nvim",
	{ "TimUntersberger/neogit", dependencies = "nvim-lua/plenary.nvim" },

	-- "Shatur/neovim-ayu",
	{ "catppuccin/nvim", name = "catppuccin" },
	-- "nvim-lualine/lualine.nvim", -- Fancier statusline
	"freddiehaddad/feline.nvim",
	"lukas-reineke/indent-blankline.nvim", -- Add indentation guides even on blank lines
	"numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = vim.fn.executable("make") == 1,
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	-- UI
	"nvim-tree/nvim-web-devicons",
	"petertriho/nvim-scrollbar",

	-- Prettier
	"jose-elias-alvarez/null-ls.nvim",

	-- Lua
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	},

	{
		"nguyenvukhang/nvim-toggler",
		config = function()
			-- Enable toggling values (Boolean)
			require("nvim-toggler").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			-- Enable auto tag closing in html, jsx, etc.
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"tummetott/reticle.nvim",
		config = function()
			-- Enable cursorline only on current file
			require("reticle").setup({})
		end,
	},
	{
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup({
				hlgroup = "GitSignsAddInline",
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					names = false, -- "Name" codes like Blue or blue
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					AARRGGBB = true, -- 0xAARRGGBB hex codes
					css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available methods are false / true / "normal" / "lsp" / "both"
					-- True is same as normal
					tailwind = false, -- Enable tailwind colors
				},
			})
		end,
	},
	"HiPhish/nvim-ts-rainbow2",
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("ultimate-autopair").setup({})
		end,
	},
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{
		"Wansmer/treesj",
		dependencies = "nvim-treesitter",
		config = function()
			require("treesj").setup({
				use_default_keymaps = false,
			})
		end,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	"rafamadriz/friendly-snippets",
	"b0o/incline.nvim",
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				debounce_delay = 5000,
			})
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		config = function()
			require("lspsaga").setup({
				lightbulb = {
					sign = true,
					virtual_text = false,
				},
				symbol_in_winbar = {
					enable = false,
					separator = " > ",
					color_mode = true,
				},
				ui = {
					-- This option only works in Neovim 0.9
					title = true,
					-- Border type can be single, double, rounded, solid, shadow.
					border = "rounded",
					kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
					code_action = "",
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"akinsho/flutter-tools.nvim",
		config = function()
			require("flutter-tools").setup({}) -- use defaults
		end,
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	"gnikdroy/projections.nvim",
	"famiu/bufdelete.nvim",
	"elkowar/yuck.vim",
	"simrat39/rust-tools.nvim",
	"nanozuki/tabby.nvim",
	{
		"ggandor/flit.nvim",
		config = function()
			require("flit").setup()
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup()
		end,
	},
	"mfussenegger/nvim-jdtls",
	{
		"lervag/vimtex",
		config = function()
			vim.g.vimtex_view_method = "zathura"
			-- vim.g.vimtex_compiler_method = "latexrun"
			vim.g.tex_comment_nospell = 1
			vim.g.vimtex_compiler_progname = "nvr"
			vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
		end,
		ft = "tex",
	},
})
