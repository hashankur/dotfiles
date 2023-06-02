-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<c-d>"] = require("telescope.actions").delete_buffer,
			},
			n = {
				["<c-d>"] = require("telescope.actions").delete_buffer,
			},
		},
		-- prompt_prefix = "  " .. icons.get("telescope") .. "  ",
		selection_caret = " > ",
		entry_prefix = "   ",
	},
	extensions = {
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

require("telescope").load_extension("undo")

require("telescope").load_extension("file_browser")

require("telescope").load_extension("file_browser")
