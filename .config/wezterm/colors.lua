local bg = "#0b0e14"
local fg = "#bfbfb6"

local black = "#0b0e14"
local bright_black = "#565b66"

local red= "#f26d78"
local green = "#7fd962"
local yellow = "#ffb454"
local blue = "#59c2ff"
local magenta = "#d2a6ff"
local cyan = "#95e6cb"
local white = "#bfbdb6"

return {
	background = bg,
	foreground = fg,
	cursor_bg = fg,
	cursor_fg = bg,
	cursor_border = fg,
	selection_fg = bg,
	selection_bg = fg,
	scrollbar_thumb = fg,
	split = black,
	ansi = {
		black,
		red,
		green,
		yellow,
		blue,
		magenta,
		cyan,
		white,
	},
	brights = {
		bright_black,
		red,
		green,
		yellow,
		blue,
		magenta,
		cyan,
		white,
	},
}
