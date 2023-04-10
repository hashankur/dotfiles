require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = {
		-- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
	show_end_of_buffer = false, -- show the '~' characters after the end of buffers
	term_colors = true,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {
		mocha = {
			-- rosewater = "#ff8f40",
			-- flamingo = "#f29668",
			-- pink = "#f07178",
			-- mauve = "#d2a6ff",
			-- red = "#d95757",
			-- maroon = "#f26d78",
			-- peach = "#e6b673",
			-- yellow = "#ffb454",
			-- green = "#aad94c",
			-- teal = "#95e6cb",
			-- sky = "#73b8ff",
			-- sapphire = "#59c2ff",
			-- blue = "#39bae6",
			-- lavender = "#6c5980",
			base = "#0b0e14",
			mantle = "#11151c",
			crust = "#131721",
		},
	},
	custom_highlights = {},
	integrations = {
		cmp = true,
		fidget = true,
		gitsigns = true,
		leap = true,
		lsp_saga = true,
		markdown = true,
		mason = true,
		neogit = true,
		telescope = true,
		treesitter = true,
		ts_rainbow2 = true,
		which_key = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
