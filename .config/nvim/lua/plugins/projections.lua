require("projections").setup({
	workspaces = { -- Default workspaces to search for
		{ "~/Documents/Projects", {} },
		{ "~/Documents/University", { ".git" } },
		{ "~/.config", { "hypr", "nvim" } },
		-- { "~/Documents/dev", { ".git" } },        Documents/dev is a workspace. patterns = { ".git" }
		-- { "~/repos", {} },                        An empty pattern list indicates that all subdirectories are considered projects
		-- "~/dev",                                  dev is a workspace. default patterns is used (specified below)
	},
	patterns = { ".git", ".svn", ".hg" }, -- Default patterns to use if none were specified. These are NOT regexps.
	-- store_hooks = { pre = nil, post = nil },   -- pre and post hooks for store_session, callable | nil
	-- restore_hooks = { pre = nil, post = nil }, -- pre and post hooks for restore_session, callable | nil
	-- workspaces_file = "path/to/file",          -- Path to workspaces json file
	-- sessions_directory = "path/to/dir",        -- Directory where sessions are stored
})

-- Bind <leader>fp to Telescope projections
require("telescope").load_extension("projections")
vim.keymap.set("n", "<leader>fp", function()
	vim.cmd("Telescope projections")
end, { desc = "Find project" })

-- Autostore session on VimExit
local Session = require("projections.session")
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	callback = function()
		Session.store(vim.loop.cwd())
	end,
})

-- Switch to project if vim was started in a project dir
local switcher = require("projections.switcher")
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		if vim.fn.argc() == 0 then
			switcher.switch(vim.loop.cwd())
		end
	end,
})
