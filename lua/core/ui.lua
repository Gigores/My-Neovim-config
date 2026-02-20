vim.pack.add {
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/romgrk/fzy-lua-native" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/gelguy/wilder.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", name = "make" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
}

local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == 'make' and (kind == 'install' or kind == 'update') then
		vim.system({ 'make' }, { cwd = ev.data.path }):wait()
	end
end
vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

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

local wilder = require('wilder')
wilder.setup({ modes = { ':', '?' } })

wilder.set_option('renderer', wilder.popupmenu_renderer(
	wilder.popupmenu_border_theme {
		highlighter = {
			wilder.lua_pcre2_highlighter(),
			wilder.lua_fzy_highlighter(),
		},
		highlights = {
			accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
			border = "rounded"
		},
		border = "rounded",
	}))

local builtin = require "telescope.builtin"
vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Search file contens' })
vim.keymap.set('v', '<leader><space>', builtin.grep_string, { desc = 'Search selection' })
require "telescope".setup {}


require "lualine".setup {
	options = {
		theme = "everforest",
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	}
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
