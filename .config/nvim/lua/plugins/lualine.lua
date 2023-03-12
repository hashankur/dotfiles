-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		component_separators = "",
		section_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {},
		-- lualine_c = {'encoding', 'fileformat'},
		lualine_x = {},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
