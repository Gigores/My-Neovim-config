local map = vim.keymap.set

local opts = { noremap = true, silent = true }

vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

map('v', "<", "<gv", opts)
map('v', ">", ">gv", opts)

map({ 'n', 'v' }, "<leader>d", [["_d]], { desc = "Delete without copying" })
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

map('n', "<leader>r", ":update<CR>:source<CR>", { desc = "Source the current file" })
map('n', "<leader>W", ":w<CR>", { desc = " :w" })
map('n', "<leader>q", ":q<CR>", { desc = " :q" })
map('n', "<leader>Q", ":qa<CR>", { desc = " :qa" })

map('t', '<Esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })

local Floatings = require "core.floatings"

map('n', "<leader>jc", Floatings.create_terminal({"just", "--choose"}, { border = "rounded" }), { desc = "Choose & Run" })
map('n', "<leader>jd", Floatings.create_terminal({"just", "default"}, { border = "rounded" }), { desc = "Run Default" })
map('n', "<leader>g", Floatings.create_terminal({"lazygit"}, { border = "none" }), { desc = "Git" })
map('n', "<leader>t", Floatings.create_terminal({}, { border = "rounded" }), { desc = "Open Terminal" })
