local colors = require("ayu.colors")
colors.generate(false)

require("ayu").setup({
	mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
	overrides = {
		CursorLine = { bg = "#11151C" },
		CursorLineNr = { bg = "#11151C" },
		CmpItemKindCopilot = { fg = "#6CC644" },
		CmpSelection = { bg = "#11151C" },
		DashboardHeader = { fg = colors.accent },
		DashboardFooter = { fg = colors.markup },
		DashboardProjectTitle = { fg = colors.string },
		DashboardMruTitle = { fg = colors.string },
	}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})
