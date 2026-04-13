vim.pack.add {
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
}
local wk = require "which-key"
wk.setup {
	preset = "helix",
	spec = {
		{ "<leader>w", group = "Window" },
		{ "<leader>c", group = "Code" },
		{ "<leader>h", group = "Harpoon" },
		{ "<leader>j", group = "Just", icon = " " },
		{ "<leader>jc", icon = "󰍜 " }
	},
	win = {
		border = "rounded",
	},
}

require "lualine".setup {
	options = {
		theme = "everforest",
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	}
}


