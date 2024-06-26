local clrs = require("ayu.colors")
clrs.generate(false)

---depends om https://github.com/feline-nvim/feline.nvim
local present, feline = pcall(require, "feline")

if not present then
	return
end

local theme = {
	aqua = clrs.tag,
	bg = clrs.bg,
	blue = clrs.enitity,
	cyan = clrs.regexp,
	darkred = clrs.markup,
	fg = clrs.fg,
	gray = clrs.ui,
	green = clrs.string,
	lime = "#54CED6",
	orange = clrs.keyword,
	pink = clrs.operator,
	purple = clrs.lsp_parameter,
	red = clrs.error,
	yellow = clrs.accent,
}

local mode_theme = {
	["NORMAL"] = theme.blue,
	["N-PENDING"] = theme.blue,
	["INSERT"] = theme.green,
	["TERMINAL"] = theme.green,
	["VISUAL"] = theme.purple,
	["V-LINE"] = theme.purple,
	["V-BLOCK"] = theme.purple,
	["REPLACE"] = theme.darkred,
	["V-REPLACE"] = theme.darkred,
	["SELECT"] = theme.darkred,
	["S-LINE"] = theme.darkred,
	["S-BLOCK"] = theme.darkred,
	["COMMAND"] = theme.pink,
	["PROMPT"] = theme.lime,
	["MORE"] = theme.lime,
	["CONFIRM"] = theme.yellow,
	["SHELL"] = theme.green,
}

local component = {}

component.vim_mode = {
	provider = function()
		return vim.api.nvim_get_mode().mode:upper()
	end,
	hl = function()
		return {
			fg = "bg",
			bg = require("feline.providers.vi_mode").get_mode_color(),
			style = "bold",
			name = "NeovimModeHLColor",
		}
	end,
	left_sep = "block",
	right_sep = "block",
}

component.git_branch = {
	provider = "git_branch",
	icon = " ",
	hl = {
		fg = "fg",
		bg = "bg",
		style = "bold",
	},
	left_sep = "block",
	right_sep = "",
}

component.git_add = {
	provider = "git_diff_added",
	hl = {
		fg = "green",
		bg = "bg",
	},
	left_sep = "",
	right_sep = "",
}

component.git_delete = {
	provider = "git_diff_removed",
	hl = {
		fg = "red",
		bg = "bg",
	},
	left_sep = "",
	right_sep = "",
}

component.git_change = {
	provider = "git_diff_changed",
	hl = {
		fg = "purple",
		bg = "bg",
	},
	left_sep = "",
	right_sep = "",
}

component.separator = {
	provider = "",
	hl = {
		fg = "bg",
		bg = "bg",
	},
}

component.diagnostic_errors = {
	provider = "diagnostic_errors",
	hl = {
		fg = "red",
	},
}

component.diagnostic_warnings = {
	provider = "diagnostic_warnings",
	hl = {
		fg = "yellow",
	},
}

component.diagnostic_hints = {
	provider = "diagnostic_hints",
	hl = {
		fg = "aqua",
	},
}

component.diagnostic_info = {
	provider = "diagnostic_info",
}

component.lsp = {
	provider = function()
		if not rawget(vim, "lsp") then
			return ""
		end

		local progress = vim.lsp.util.get_progress_messages()[1]
		if vim.o.columns < 120 then
			return ""
		end

		local clients = vim.lsp.get_active_clients({ bufnr = 0 })
		if #clients ~= 0 then
			if progress then
				local spinners = {
					"◜ ",
					"◠ ",
					"◝ ",
					"◞ ",
					"◡ ",
					"◟ ",
				}
				local ms = vim.loop.hrtime() / 1000000
				local frame = math.floor(ms / 120) % #spinners
				local content = string.format("%%<%s", spinners[frame + 1])
				return content or ""
			else
				return " LSP"
			end
		end
		return ""
	end,
	hl = function()
		local progress = vim.lsp.util.get_progress_messages()[1]
		return {
			fg = progress and "yellow" or "green",
			bg = "bg",
			style = "bold",
		}
	end,
	left_sep = "",
	right_sep = "block",
}

component.file_type = {
	provider = {
		name = "file_type",
		opts = {
			filetype_icon = true,
		},
	},
	hl = {
		fg = "fg",
		bg = "bg",
	},
	left_sep = "block",
	right_sep = "block",
}

component.fileinfo = {
	provider = { name = "file_info", opts = { type = "relative" } },
	short_provider = {
		name = "file_info",
		opts = {
			type = "base-only",
		},
	},
	left_sep = "block",
	right_sep = "block",
}

component.scroll_bar = {
	provider = function()
		local chars = {
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
		}
		local line_ratio = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
		local position = math.floor(line_ratio * 100)

		if position <= 5 then
			position = " TOP"
		elseif position >= 95 then
			position = " BOT"
		else
			position = chars[math.floor(line_ratio * #chars)] .. position
		end
		return position
	end,
	hl = function()
		local position = math.floor(vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0) * 100)
		local fg
		local style

		if position <= 5 then
			fg = "aqua"
			style = "bold"
		elseif position >= 95 then
			fg = "red"
			style = "bold"
		else
			fg = "purple"
			style = nil
		end
		return {
			fg = fg,
			style = "bold",
			bg = "bg",
		}
	end,
	left_sep = "block",
	right_sep = "block",
}

local left = {
	component.vim_mode,
	component.git_branch,
	-- component.fileinfo,
	-- component.git_add,
	-- component.git_delete,
	-- component.git_change,
}
local middle = {}
local right = {
	component.lsp,
	-- component.separator,
	-- component.diagnostic_errors,
	-- component.diagnostic_warnings,
	-- component.diagnostic_info,
	-- component.diagnostic_hints,
	component.file_type,
	component.scroll_bar,
}

local components = {
	active = {
		left,
		middle,
		right,
	},
}

feline.setup({
	components = components,
	theme = theme,
	vi_mode_colors = mode_theme,
})

---vim:filetype=lua
