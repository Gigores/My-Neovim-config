local gh = require "util.providers".github

vim.pack.add {
	gh "nvim-treesitter/nvim-treesitter",
	gh "nvim-treesitter/nvim-treesitter-textobjects",
}

local treesitter = require "nvim-treesitter"

treesitter.setup {
	ensure_installed = {
		"yaml",
		"just",
		"css",
		"python",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"vimdoc",
		"java",
		"rust",
		"c",
		"typescript",
		"tsx",
		"javascript",
		"html",
		"latex"
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection    = "<C-space>",
			node_incremental  = "<C-space>",
			scope_incremental = false,
		},
	},
	additional_vim_regex_highlighting = false,
}
vim.api.nvim_create_autocmd('FileType', {
	pattern = { '<filetype>' },
	callback = function() vim.treesitter.start() end,
})
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

require("nvim-treesitter-textobjects").setup {
	select = {
		lookahead = true,
		selection_modes = {
			['@parameter.outer'] = 'v',
			['@function.outer'] = 'V',
			['@class.outer'] = 'v',
		},
		include_surrounding_whitespace = false, -- tete
	},
}

vim.keymap.set({ "x", "o" }, "af", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end, { desc = "function" })
vim.keymap.set({ "x", "o" }, "if", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end, { desc = "function" })
vim.keymap.set({ "x", "o" }, "ac", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end, { desc = "class" })
vim.keymap.set({ "x", "o" }, "ic", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end, { desc = "class" })
vim.keymap.set({ "x", "o" }, "as", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end, { desc = "locals" })
vim.keymap.set({ "x", "o" }, "iC", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@comment.inner", "textobjects")
end, { desc = "comment" })
vim.keymap.set({ "x", "o" }, "aC", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@comment.outer", "textobjects")
end, { desc = "comment" })
vim.keymap.set({ "x", "o" }, "ip", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@parameter.inner", "textobjects")
end, { desc = "parameter" })
vim.keymap.set({ "x", "o" }, "ap", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@parameter.outer", "textobjects")
end, { desc = "parameter" })
vim.keymap.set({ "x", "o" }, "il", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@loop.inner", "textobjects")
end, { desc = "loop" })
vim.keymap.set({ "x", "o" }, "al", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@loop.outer", "textobjects")
end, { desc = "loop" })
vim.keymap.set({ "x", "o" }, "iF", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@contitional.inner", "textobjects")
end, { desc = "contitional" })
vim.keymap.set({ "x", "o" }, "aF", function()
	require "nvim-treesitter-textobjects.select".select_textobject("@contitional.outer", "textobjects")
end, { desc = "contitional" })
