require("scrollbar").setup({
	-- handle = { color = "#282C34" },
	excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
	marks = {
		Search = { text = { "-", "🬇" } },
		Error = { text = { "-", "🬇" } },
		Warn = { text = { "-", "🬇" } },
		Info = { text = { "-", "🬇" } },
		Hint = { text = { "-", "🬇" } },
		Misc = { text = { "-", "🬇" } },
		Cursor = { text = "∎" },
		GitAdd = { text = "▏" },
		GitChange = { text = "▏" },
		GitDelete = {},
	},
	handlers = {
		cursor = true,
		diagnostic = true,
		gitsigns = true, -- Requires gitsigns
		handle = true,
		search = false, -- Requires hlslens
		ale = false, -- Requires ALE
	},
})
