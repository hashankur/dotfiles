local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

local b = null_ls.builtins

local sources = {
	b.code_actions.gitsigns,
	b.code_actions.xo,

	b.completion.luasnip,
	b.completion.tags,

	b.diagnostics.markdownlint,
	b.diagnostics.codespell,
	-- Python
	b.diagnostics.flake8,
	-- CSS
	b.diagnostics.stylelint,
	-- HTML
	b.diagnostics.tidy,

	-- Python formatting
	b.formatting.black,
	b.formatting.google_java_format,
	b.formatting.prettierd,
	b.formatting.rustfmt,
	b.formatting.stylua,
}

null_ls.setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<Leader>ff", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "Format buffer" })

			-- format on save
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
			vim.api.nvim_create_autocmd(event, {
				buffer = bufnr,
				group = group,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, async = async })
				end,
				desc = "[lsp] format on save",
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
