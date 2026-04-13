local gh = require "util.providers".github

vim.pack.add {
	gh "nguyenvukhang/nvim-toggler"
}

local toggler = require "nvim-toggler"
toggler.setup {}
vim.keymap.set({ 'n', 'v' }, "<leader>ct", toggler.toggle, { desc = "toggle" })
