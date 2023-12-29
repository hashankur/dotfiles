local wt = require("wezterm")
local colors = require("colors")

return {
	enable_wayland = false,
	color_schemes = {
		["Ayu Dark Nue"] = require("colors")
	},
	color_scheme = 'Ayu Dark Nue',
	font = wt.font { family = 'Iosevka', weight = 'Medium' },
	font_size = 12,

	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	default_cursor_style = "BlinkingUnderline",

	window_padding = {
		top = "0cell",
		right = "1cell",
		bottom = "0",
		left = "1cell",
	},

	window_frame = {
		font = wt.font { family = 'Roboto', weight = 'Bold' },
		font_size = 12.0,

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
