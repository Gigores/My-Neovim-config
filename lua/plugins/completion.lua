local gh = require "util.providers".github

vim.pack.add {
	gh "hrsh7th/nvim-cmp",
	gh "L3MON4D3/LuaSnip",
	gh "windwp/nvim-autopairs",
	{
		src = gh "Saghen/blink.cmp",
		version = vim.version.range "1.*",
	},
}
require "luasnip".setup {
	enable_autosnippets = true
}
require "luasnip.loaders.from_vscode".lazy_load {
	paths = {
		"./.vscode"
	}
}
require "blink.cmp".setup {
	fuzzy = {
		prebuilt_binaries = {
			download = true
		},
		implementation = "lua",
	},
	signature = {
		enabled = true
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500
		},
		menu = {
			auto_show = true,
			draw = {
				treesitter = {
					"lsp"
				},
				columns = {
					{
						"kind_icon",
						"label",
						"label_description",
						gap = 1
					},
					{
						"kind"
					}
				},
			}
		}
	}
}
local autopairs = require "nvim-autopairs"
autopairs.setup {
	check_ts = true
}
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp = require "cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
