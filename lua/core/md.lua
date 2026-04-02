vim.pack.add {
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" }
}
local markdown = require "render-markdown"
markdown.setup {
	completions = { lsp = { enabled = true } },
	file_types = { 'markdown', 'vimwiki' },
	checkbox = {
		checked = {
			icon = "  "
		},
		unchecked = {
			icon = "  "
		},
		custom = {}
	}
}

vim.keymap.set('n', "<leader>cm", function()
	markdown.set()
end, { desc = "Toggle Markdown" })
