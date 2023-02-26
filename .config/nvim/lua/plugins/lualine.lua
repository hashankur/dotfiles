-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "ayu",
		component_separators = "",
		section_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			{
				"filename",
				newfile_status = false,
				path = 0,
				symbols = {
					modified = "", -- Text to show when the file is modified.
					readonly = " ", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]", -- Text to show for newly created file before first write
				},
			},
			{
				"diff",
				symbols = { added = "  ", modified = "  ", removed = "  " },
				-- symbols = { added = "  ", modified = " 柳", removed = " " },
			},
		},
		-- lualine_c = {'encoding', 'fileformat'},
		lualine_x = { "diagnostics", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
