local prettier = require("prettier")

prettier.setup({
	bin = "prettierd",
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"lua",
		"markdown",
		"python",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
	cli_options = {
		jsx_single_quote = true,
		print_width = 80,
		single_quote = true,
		tab_width = 4,
	},
})
