local null_ls = require("null-ls")

-- local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
-- local event = "BufWritePre" -- or "BufWritePost"
-- local async = event == "BufWritePost"

local b = null_ls.builtins

local sources = {
	b.code_actions.gitsigns.with({
		config = {
			filter_actions = function(title)
				return title:lower():match("blame") == nil -- filter out blame actions
			end,
		},
	}),
	b.code_actions.refactoring,
	-- b.code_actions.eslint_d,

	b.completion.luasnip,
	b.completion.tags,

	b.diagnostics.misspell,
	-- Python
	b.diagnostics.flake8,
	-- CSS
	-- b.diagnostics.stylelint,
	-- HTML
	b.diagnostics.tidy,
	-- b.diagnostics.eslint_d,

	b.formatting.astyle.with({
		filetypes = { "c", "cpp", "cs" },
	}),
	-- Python formatting
	b.formatting.black,
	b.formatting.google_java_format.with({
		extra_args = { "--aosp" },
	}),
	b.formatting.prettierd,
	b.formatting.rustfmt,
	b.formatting.stylua,
}

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			-- vim.keymap.set("n", "<Leader>ff", function()
			-- 	vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			-- end, { buffer = bufnr, desc = "Format buffer" })
			vim.api.nvim_buf_create_user_command(bufnr, "LspFormatting", function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, {})

			-- format on save
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup })
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				group = augroup,
				-- callback = function()
				-- 	vim.lsp.buf.format({ bufnr = bufnr, async = async })
				-- end,
				-- desc = "[lsp] format on save",
				command = "undojoin | LspFormatting",
			})
		end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>ff", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "Format buffer" })
		end
	end,
	debug = true,
	sources = sources,
})
