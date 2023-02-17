local tscope = require("telescope.builtin")
-- local tprojects = require("telescope").extensions.project.project({})

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>.", tscope.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>,", tscope.buffers, { desc = "Switch buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	tscope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "Search in current buffer" })
vim.keymap.set("n", "<leader><leader>", tscope.find_files, { desc = "Search Files" })

vim.keymap.set("n", "<leader>sh", tscope.help_tags, { desc = "Search Help" })
vim.keymap.set("n", "<leader>sw", tscope.grep_string, { desc = "Search current Word" })
vim.keymap.set("n", "<leader>sg", tscope.live_grep, { desc = "Search by Grep" })
vim.keymap.set("n", "<leader>sd", tscope.diagnostics, { desc = "Search Diagnostics" })
vim.keymap.set("n", "<leader>sf", tscope.git_files, { desc = "Search current git files" })
vim.keymap.set("n", "<leader>?", tscope.commands, { desc = "Browse commands" })

-- Telescope Git
vim.keymap.set("n", "<leader>gc", tscope.git_commits, { desc = "Git commits" })
vim.keymap.set("n", "<leader>gb", tscope.git_bcommits, { desc = "Git buffer commits" })
vim.keymap.set("n", "<leader>gr", tscope.git_branches, { desc = "Git branches" })
vim.keymap.set("n", "<leader>gs", tscope.git_status, { desc = "Git status" })

-- File Keymaps
vim.keymap.set("n", "<leader>fs", "<cmd>w<CR>", { desc = "Write to file" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Write to file" })

-- Buffer Keymaps
vim.keymap.set("n", "<leader>bk", "<cmd>close<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>by", "<cmd>%y+<CR>", { desc = "Yank buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#<CR>", { desc = "Close other buffers" })

-- Window Keymaps
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Window bottom" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Window top" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Swap window left" })
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Swap window bottom" })
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Swap window top" })
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Swap window right" })
vim.keymap.set("n", "<leader>wx", "<C-w>x", { desc = "Swap windows" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Enlarge window" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split horizontal" })

-- Session keymaps
-- vim.keymap.set("n", "<leader><tab><tab>", tprojects, { desc = "List projects" })
vim.api.nvim_set_keymap(
	"n",
	"<leader><tab><tab>",
	[[<cmd>lua require("telescope").extensions.project.project({})<cr>]],
	{ desc = "List projects" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader><tab>r",
	[[<cmd>lua require("persistence").load()<cr>]],
	{ desc = "Restore session CWD" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader><tab>l",
	[[<cmd>lua require("persistence").load({ last = true })<cr>]],
	{ desc = "Restore last session" }
)
-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap(
	"n",
	"<leader><tab>d",
	[[<cmd>lua require("persistence").stop()<cr>]],
	{ desc = "Exit without saving" }
)

vim.keymap.set("n", "<leader>ol", "<cmd>Lazy<CR>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>om", "<cmd>Mason<CR>", { desc = "Mason" })
vim.keymap.set("n", "<leader>ot", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
