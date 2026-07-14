require "core.options"
require "core.keymaps"
require "core.lsp"
require "core.ui"
require "core.setups"

require "plugins.completion"
require "plugins.treesitter"
require "plugins.java"
require "plugins.toggler"
require "plugins.navigation"
require "plugins.ui"
require "plugins.md"
-- require "plugins.colorscheme"
require "plugins.surround"

vim.filetype.add {
    extension = {
        gr = "gearshift",
    },
    pattern = { ["*.gr"] = "gearshift" }
}

vim.filetype.add {
	pattern = {
		[".*"] = {
			function(path, bufnr)
				local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
				if line and line:match("^#!.*/env%s+clisp") then
					return "lisp"
				end
			end,
		},
	},
}

vim.cmd.colorscheme "jetBrains"
