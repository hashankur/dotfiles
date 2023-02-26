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
		-- prompt_prefix = "  " .. icons.get("telescope") .. "  ",
		selection_caret = " ❯ ",
		entry_prefix = "   ",
	},
	extensions = {
		project = { base_dirs = { "~/.config/nvim", "~/.config/hypr" } },
		undo = {
			side_by_side = true,
			layout_strategy = "vertical",
			layout_config = {
				preview_height = 0.6,
			},
		},
		file_browser = {
			layout_config = {
				preview_width = 0.6,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Enable telescope project picker
pcall(require("telescope").load_extension, "projects")

require("telescope").load_extension("undo")

require("telescope").load_extension("file_browser")
