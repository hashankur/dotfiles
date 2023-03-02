local cmp = require("cmp")
local luasnip = require("luasnip")

local symbols = {
	Boolean = " ",
	Character = " ",
	Class = " ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Enum = " ",
	EnumMember = " ",
	Event = "",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = "ﬦ",
	Interface = " ",
	Keyword = " ",
	Method = " ",
	Module = "	",
	Number = " ",
	Operator = " ",
	Parameter = " ",
	Property = "ﰠ ",
	Reference = " ",
	Snippet = " ",
	String = " ",
	Struct = " ",
	Text = " ",
	TypeParameter = " ",
	Unit = " ",
	Value = " ",
	Variable = " ",
	Copilot = " ",
}

local has_copilot, copilot_cmp = pcall(require, "copilot_cmp.comparators")

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	style = {
		winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	window = {
		completion = {
			border = "rounded",
			winhighlight = "Normal:CmpMenu,FloatBorder:CmpMenuBorder,CursorLine:CmpSelection,Search:None",
			autocomplete = {
				require("cmp.types").cmp.TriggerEvent.InsertEnter,
				require("cmp.types").cmp.TriggerEvent.TextChanged,
			},
		},
		documentation = {
			border = "rounded",
			winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
		},
	},
	-- formatting = {
	-- 	deprecated = true,
	-- 	fields = { "kind", "abbr", "menu" },
	-- 	format = function(entry, vim_item)
	-- 		local strings = vim.split(lsp_kinds[vim_item.kind], "%s", { trimempty = true })
	-- 		vim_item.kind = " " .. (strings[1] or "") .. " "
	-- 		vim_item.menu = ({
	-- 			nvim_lsp = "[LSP]",
	-- 			emoji = "[Emoji]",
	-- 			path = "[Path]",
	-- 			calc = "[Calc]",
	-- 			neorg = "[Neorg]",
	-- 			orgmode = "[Org]",
	-- 			luasnip = "[Luasnip]",
	-- 			buffer = "[Buffer]",
	-- 			spell = "[Spell]",
	-- 			git = "[VCS]",
	-- 			nvim_lua = "[Lua]",
	-- 			latex_symbols = "[LaTeX]",
	-- 		})[entry.source.name]
	-- 		return vim_item
	-- 	end,
	-- },
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.menu_hl_group = "CmpItemKind" .. vim_item.kind
			vim_item.menu = vim_item.kind
			vim_item.abbr = vim_item.abbr:sub(1, 50)
			vim_item.kind = symbols[vim_item.kind]
			vim_item.dup = { buffer = 1, path = 1, nvim_lsp = 0 } -- Deduplication?
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "copilot" },
		{ name = "luasnip" },
	},
	sorting = {
		--keep priority weight at 2 for much closer matches to appear above copilot
		--set to 1 to make copilot always appear on top
		priority_weight = 2,
		comparators = {
			-- order matters here
			cmp.config.compare.exact,
			has_copilot and copilot_cmp.prioritize or nil,
			has_copilot and copilot_cmp.score or nil,
			cmp.config.compare.offset,
			-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
			-- personal settings:
			-- cmp.config.compare.recently_used,
			-- cmp.config.compare.offset,
			-- cmp.config.compare.score,
			-- cmp.config.compare.sort_text,
			-- cmp.config.compare.length,
			-- cmp.config.compare.order,
		},
	},
	preselect = cmp.PreselectMode.Item,
})

vim.cmd([[ set pumheight=15 ]])

require("luasnip.loaders.from_vscode").lazy_load()
