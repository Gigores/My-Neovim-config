local map = vim.keymap.set

local opts = { noremap = true, silent = true }

vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

map('v', "<", "<gv", opts)
map('v', ">", ">gv", opts)

map({ 'n', 'v' }, "<leader>d", [["_d]], { desc = "Delete without copying" })
map('n', "<leader>u", ":Undotree<CR>", { desc = "Undo tree" })
map('n', "x", "_x", opts)

map('n', "L", "<cmd>tabn<CR>")
map('n', "K", "<cmd>tabn<CR>")
map('n', "H", "<cmd>tabp<CR>")
map('n', "J", "<cmd>tabp<CR>")

map('n', "<leader>w|", "<C-w>v", { desc = "Split window vertically" })
map('n', "<leader>w-", "<C-w>s", { desc = "Split window horizontally" })
map('n', "<leader>w=", "<C-w>=", { desc = "Make windows equally sized" })
map('n', "<leader>wx", "<cmd>close<CR>", { desc = "Close current window" })
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

map('n', "<leader>r", ":restart<CR>", { desc = ":restart" })
map('n', "<leader>W", ":w<CR>", { desc = " :w" })
map('n', "<leader>q", ":q<CR>", { desc = " :q" })
map('n', "<leader>Q", ":qa<CR>", { desc = " :qa" })

map('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })

local Floatings = require "util.floatings"

map('n', "<leader>jc", Floatings.create_terminal_app({"just", "--choose"}, { border = "solid" }), { desc = "Choose & Run" })
map('n', "<leader>jd", Floatings.create_terminal_app({"just", "default"}, { border = "solid" }), { desc = "Run Default" })
map('n', "<leader>jf", function()
	local justfile = vim.fs.find(
		{ "justfile", "Justfile" },
		{ type = "file" }
	)
	vim.print(#justfile)
	Floatings.create_split_window({ width_factor = Floatings.Factors.HALF })()
	if (#justfile ~= 0) then
		vim.cmd.edit(justfile[1])
	else
		vim.cmd.edit "Justfile"
	end
end, { desc = "Open Justfile" })
map('n', "<leader>o", Floatings.create_terminal_app({"opencode", "."}, { split = Floatings.SplitDirection.RIGHT }), { desc = "OpenCode" })
map('n', "<leader>g", Floatings.create_terminal_app({"lazygit"}, { border = "solid", close_on_exit = true }), { desc = "Git" })
map('n', "<leader>t", Floatings.create_terminal { border = "solid" }, { desc = "Open Terminal" })
