local gh = require "util.providers".github

vim.pack.add {
	gh "nvim-lua/plenary.nvim",
	{ src = gh "ThePrimeagen/harpoon", version = "harpoon2" },

	{ src = gh "nvim-telescope/telescope.nvim", name = "make" },
	gh "stevearc/oil.nvim",
}

local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add" })
vim.keymap.set("n", "<leader><C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon open" })

vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Open 1st" })
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Open 2nd" })
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Open 4rd" })
vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Open 4th" })

local function prev()
	harpoon:list():prev()
end

local function next()
	harpoon:list():next()
end

-- vim.keymap.set("n", "<leader>h<", prev, { desc = "Open previous" })
-- vim.keymap.set("n", "<leader>h>", next, { desc = "Open next" })
vim.keymap.set("n", "<leader>hk", prev, { desc = "Open previous" })
vim.keymap.set("n", "<leader>hj", next, { desc = "Open next" })

local builtin = require "telescope.builtin"
vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Search file contens' })
vim.keymap.set('v', '<leader><space>', builtin.grep_string, { desc = 'Search selection' })
require "telescope".setup {}

local oil = require "oil"
oil.setup {
	lsp_file_methods = {
		enabled = true,
	},
	float = {
		padding = 10,
		border = "rounded",
	},
	keymaps_help = {
		border = "rounded",
	},
	keymaps = {
		["K"] = { "k", mode = 'n' },
		["J"] = { "j", mode = 'n' },
		["H"] = { "actions.parent", mode = 'n' },
		["L"] = "actions.select",
	},
	git = {
		add = function(path)
			return true
		end,
		mv = function(src_path, dest_path)
			return true
		end,
		rm = function(path)
			return true
		end,
	},
}
vim.keymap.set('n', "<leader>e", "<CMD>Oil --float<CR><C-p>", { desc = "Open file explorer", remap = true })
