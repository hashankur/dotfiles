-- Gitsigns
-- See `:help gitsigns.txt`
require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "│ " },
		untracked = { text = "" },
	},
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "    <author>, <author_time> • <summary>",
	current_line_blame_formatter_opts = { relative_time = true },
	diff_opts = {
		algorithm = "histogram",
	},
	yadm = {
		enable = true,
	},
})
