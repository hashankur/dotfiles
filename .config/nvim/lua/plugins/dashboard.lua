-- local Session = require("projections.session")
-- restore = function()
-- 	Session.restore_latest()
-- end

require("dashboard").setup({
	theme = "hyper",
	config = {
		week_header = {
			enable = true,
		},
		shortcut = {
			{
				desc = "  Last session",
				group = "@property",
				action = "restore()",
				key = "r",
			},
			{
				desc = " Apps",
				group = "DiagnosticHint",
				action = "Telescope app",
				key = "a",
			},
			{
				desc = " dotfiles",
				group = "Number",
				action = "Telescope dotfiles",
				key = "d",
			},
		},
	},
})
