-- local colors = require("ayu.colors")
-- colors.generate(false)
--
local rainbow = { "#CC8888", "#CCCC88", "#88CC88", "#88CCCC", "#8888CC", "#CC88CC" }

require("nvim-treesitter.configs").setup({
	highlight = {
		-- ...
	},
	-- ...
	rainbow = {
		enable = true,
		disable = { "html" }, -- list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		colors = rainbow, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})

-- Workaround: https://github.com/p00f/nvim-ts-rainbow/issues/81#issuecomment-1058124957
for i, c in ipairs(rainbow) do -- p00f/rainbow#81
	vim.cmd(("hi rainbowcol%d guifg=%s"):format(i, c))
end
