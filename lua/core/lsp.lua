vim.pack.add {
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
}

vim.lsp.enable {
	"lua_ls",
	"rust_analyzer",
	"jdtls",
	"clangd",
	"typescript-language-server",
}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("userlspconfig", {}),
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }
		local key = vim.keymap

		opts.desc = "hover info"
		key.set('n', "<leader>ck", vim.lsp.buf.hover, opts)

		opts.desc = "go to definition"
		key.set('n', "gd", vim.lsp.buf.definition, opts)

		opts.desc = "go to declaration"
		key.set('n', "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "go to implementation"
		key.set('n', "gi", vim.lsp.buf.implementation, opts)

		opts.desc = "signature help"
		key.set('n', "<leader>ck", vim.lsp.buf.signature_help, opts)

		opts.desc = "rename"
		key.set('n', "<leader>cr", vim.lsp.buf.rename, opts)

		opts.desc = "code action"
		key.set('n', "<leader>ca", vim.lsp.buf.code_action, opts)

		opts.desc = "find references"
		key.set('n', "<leader>cr", vim.lsp.buf.references, opts)

		opts.desc = "format"
		key.set('n', "<leader>cf", function()
			vim.lsp.buf.format { async = true }
		end, opts)

		opts.desc = "next diagnostic"
		key.set('n', "<leader>c]", function()
			vim.diagnostic.jump { count = 1, float = true }
		end, opts)

		opts.desc = "previous diagnostic"
		key.set('n', "<leader>c[", function()
			vim.diagnostic.jump { count = -1, float = true }
		end, opts)
	end
})

vim.diagnostic.config {
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}
	},
	virtual_lines = true,
}

local autopairs = require "nvim-autopairs"
autopairs.setup { check_ts = true }
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp = require "cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())


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
			['@class.outer'] = '<c-v>',
		},
		include_surrounding_whitespace = false,
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
