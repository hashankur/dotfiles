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
		TSRainbowRed = { fg = colors.warning },
		TSRainbowYellow = { fg = colors.accent },
		TSRainbowBlue = { fg = colors.regexp },
		TSRainbowOrange = { fg = colors.statement },
		TSRainbowGreen = { fg = colors.string },
		TSRainbowViolet = { fg = "#D2A6FF" },
		TSRainbowCyan = { fg = "#95e6cb" },
	}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})
