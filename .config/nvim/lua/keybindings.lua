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
vim.keymap.set("n", "<leader>sF", tscope.find_files, { desc = "Search Files" })

vim.keymap.set("n", "<leader>sh", tscope.help_tags, { desc = "Search Help" })
vim.keymap.set("n", "<leader>sw", tscope.grep_string, { desc = "Search current Word" })
vim.keymap.set("n", "<leader>sg", tscope.live_grep, { desc = "Search by Grep" })
vim.keymap.set("n", "<leader>sd", tscope.diagnostics, { desc = "Search Diagnostics" })
vim.keymap.set("n", "<leader>sf", tscope.git_files, { desc = "Search current git files" })
vim.keymap.set("n", "<leader>?", tscope.commands, { desc = "Browse commands" })

-- Git
vim.keymap.set("n", "<leader>gc", tscope.git_commits, { desc = "Git commits" })
vim.keymap.set("n", "<leader>gb", tscope.git_bcommits, { desc = "Git buffer commits" })
vim.keymap.set("n", "<leader>gr", tscope.git_branches, { desc = "Git branches" })
vim.keymap.set("n", "<leader>gs", tscope.git_status, { desc = "Git status" })
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Diffview Open" })
vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Diffview Close" })
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", { desc = "Diffview History" })

-- File Keymaps
vim.keymap.set("n", "<leader>fs", "<cmd>w<CR>", { desc = "Write to file" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Write to file" })
-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
	"n",
	"<leader><leader>",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ desc = "File Browser", noremap = true }
)

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

vim.keymap.set("n", "<leader>ts", "<cmd>TSJToggle<CR>", { desc = "Toggle Split/Join" })
vim.keymap.set("n", "<leader>te", "<cmd>Lexplore<CR>", { desc = "Toggle explorer" })
vim.keymap.set("n", "<leader>tu", "<cmd>Telescope undo<cr>", { desc = "Telescope Undo" })
vim.keymap.set("n", "<leader>tn", "<cmd>ASToggle<CR>", { desc = "Toggle autosave" })
vim.keymap.set("n", "<leader>tl", "<cmd>Lazy<CR>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>tm", "<cmd>Mason<CR>", { desc = "Mason" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line(s) down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line(s) up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

local keymap = vim.keymap.set

-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

-- Code action
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the entire file
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

-- Rename all occurrences of the hovered word for the selected files
keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

-- Go to definition
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

-- Go to type definition
keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Show cursor diagnostics
-- Like show_line_diagnostics, it supports passing the ++unfocus argument
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- Show buffer diagnostics
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filters such as only jumping to an error
keymap("n", "[E", function()
	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "]E", function()
	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- Toggle outline
keymap("n", "<leader>to", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- If you want to keep the hover window in the top right hand corner,
-- you can pass the ++keep argument
-- Note that if you use hover with ++keep, pressing this key again will
-- close the hover window. If you want to jump to the hover window
-- you should use the wincmd command "<C-w>w"
-- keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

-- Call hierarchy
keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Floating terminal
keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
