local colors = require("ayu.colors")
colors.generate(false)

require("scrollbar").setup({
	handle = { color = "#282C34" },
	excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
	marks = {
		Search = { text = { "-", "🬇" }, color = colors.keyword },
		Error = { text = { "-", "🬇" }, color = colors.warning },
		Warn = { text = { "-", "🬇" }, color = colors.warning },
		Info = { text = { "-", "🬇" }, color = colors.entity },
		Hint = { text = { "-", "🬇" }, color = colors.special },
		Misc = { text = { "-", "🬇" }, color = "#C99FF4" },
		Cursor = { text = "∎" },
		GitAdd = { text = "▏", color = colors.vcs_added },
		GitChange = { text = "▏" },
		GitDelete = { color = colors.vcs_removed },
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
