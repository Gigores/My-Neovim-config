local gh = require "util.providers".github

vim.pack.add {
	gh "MeanderingProgrammer/render-markdown.nvim"
}
vim.treesitter.language.register('markdown', 'vimwiki')
local markdown = require "render-markdown"
markdown.setup {
	code = {
		style = "normal",
		border = "thick"
	},
	completions = { lsp = { enabled = true } },
	file_types = { 'markdown', 'vimwiki' },
	checkbox = {
		checked = {
			icon = "󰄵 "
		},
		unchecked = {
			icon = "󰄱 "
		},
		custom = {
			in_progress = {
				raw = "[.]",
				rendered = "󱑎 ",
				highlight = 'DiagnosticWarn',
			},
			partial = {
				raw = "[|]",
				rendered = "󰛲 ",
				highlight = 'DiagnosticWarn',
			},
			rejected = {
				raw = "[/]",
				rendered = "󰅘 ",
				highlight = 'DiagnosticError',
			}
		}
	},
}

vim.keymap.set('n', "<leader>cm", function()
	markdown.set()
end, { desc = "Toggle Markdown" })
