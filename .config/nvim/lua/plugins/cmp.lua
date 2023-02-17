-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

local lsp_kinds = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs( -4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable( -1) then
				luasnip.jump( -1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	formatting = {
		deprecated = true,
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local strings = vim.split(lsp_kinds[vim_item.kind], "%s", { trimempty = true })
			vim_item.kind = " " .. (strings[1] or "") .. " "
			vim_item.menu = ({
					nvim_lsp = "[LSP]",
					emoji = "[Emoji]",
					path = "[Path]",
					calc = "[Calc]",
					neorg = "[Neorg]",
					orgmode = "[Org]",
					luasnip = "[Luasnip]",
					buffer = "[Buffer]",
					spell = "[Spell]",
					git = "[VCS]",
					nvim_lua = "[Lua]",
					latex_symbols = "[LaTeX]",
				})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})
