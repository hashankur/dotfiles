local rainbow = require("ts-rainbow")

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		"bash",
		"c",
		"comment",
		"css",
		"dart",
		"diff",
		"fish",
		"gitcommit",
		"gitignore",
		"help",
		"html",
		"java",
		"javascript",
		"json",
		"latex",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"rust",
		"scss",
		"toml",
		"tsx",
		"typescript",
		"yuck",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
	rainbow = {
		enable = true,
		disable = { "html" },
		-- Which query to use for finding delimiters
		query = "rainbow-parens",
		strategy = {
			-- Use global strategy by default
			rainbow.strategy["global"],
			-- Use local for HTML
			-- html = rainbow.strategy["local"],
			tsx = rainbow.strategy["local"],
		},
		hlgroups = {
			"TSRainbowYellow",
			"TSRainbowViolet",
			"TSRainbowCyan",
			"TSRainbowRed",
			"TSRainbowBlue",
			"TSRainbowOrange",
			"TSRainbowGreen",
		},
	},
})
