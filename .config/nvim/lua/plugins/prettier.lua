local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
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
})
