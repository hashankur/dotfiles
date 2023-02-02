local colors = require("ayu.colors")

require("scrollbar").setup({
    handle = { color = colors.accent },  -- Not seem to be working
        excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
    handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true, -- Requires gitsigns
        handle = false,
        search = false, -- Requires hlslens
        ale = false, -- Requires ALE
    },
})

