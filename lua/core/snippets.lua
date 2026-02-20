vim.pack.add {
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") }
}
require "luasnip".setup { enable_autosnippets = true }
require "luasnip.loaders.from_vscode".lazy_load()
require "blink.cmp".setup {
	fuzzy = {
		prebuilt_binaries = { download = true },
		implementation = "lua",
	},
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			}
		}
	}
}
