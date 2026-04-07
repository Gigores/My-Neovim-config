vim.pack.add {
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" }
}
vim.treesitter.language.register('markdown', 'vimwiki')
local markdown = require "render-markdown"
markdown.setup {
	indent = {
		enabled = true
	},
	heading = {
		border = true
	},
	code = {
		style = "normal",
		border = "thick"
	},
	completions = { lsp = { enabled = true } },
	file_types = { 'markdown', 'vimwiki' },
	checkbox = {
		checked = {
			icon = " "
		},
		unchecked = {
			icon = " "
		},
		custom = {
			in_progress = {
				raw = "[/]",
				rendered = " ",
				highlight = 'DiagnosticWarn',
				scope_highlight = nil
			}
		}
	}
}

vim.keymap.set('n', "<leader>cm", function()
	markdown.set()
end, { desc = "Toggle Markdown" })
