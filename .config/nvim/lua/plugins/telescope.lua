local icons = require("nvim-nonicons")

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
		prompt_prefix = "  " .. icons.get("telescope") .. "  ",
		selection_caret = " ❯ ",
		entry_prefix = "   ",
	},
	extensions = {
		project = { base_dirs = { "~/.config/nvim", "~/.config/hypr" } },
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Enable telescope project picker
pcall(require("telescope").load_extension, "projects")
