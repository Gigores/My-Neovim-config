local gh = require "util.providers".github

vim.pack.add {
	gh "nvim-tree/nvim-web-devicons",
	gh "nvim-lualine/lualine.nvim",
	gh "folke/which-key.nvim",
	gh "lewis6991/gitsigns.nvim",
	gh "j-hui/fidget.nvim",
	gh "norcalli/nvim-colorizer.lua",
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
		border = "solid",
	},
}

require "lualine".setup {
	options = {
		theme = "everforest",
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	}
}

require "fidget".setup {}

require "colorizer".setup {}
