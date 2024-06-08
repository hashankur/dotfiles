local wt = require("wezterm")
local colors = require("colors")

return {
	enable_wayland = true,
	color_schemes = {
		["Ayu Dark Nue"] = require("colors")
	},
	color_scheme = 'Ayu Dark Nue',
	font = wt.font { family = 'Pragmasevka', weight = 400 },
	font_size = 10,
	line_height = 1.25,

	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	default_cursor_style = "BlinkingUnderline",

	window_padding = {
		top = "10px",
		right = "1cell",
		bottom = "0px",
		left = "1cell",
	},

	window_frame = {
		font = wt.font { family = 'Iosevka', weight = 600 },
		font_size = 10,

		active_titlebar_bg = colors.background,
		inactive_titlebar_bg = colors.background,

	},

	colors = {
		tab_bar = {
			-- The color of the inactive tab bar edge/divider
			inactive_tab_edge = colors.foreground,
		},
	},
}
