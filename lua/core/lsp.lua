vim.pack.add {
	{
		src = 'https://github.com/JavaHello/spring-boot.nvim',
		version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
	},
	'https://github.com/MunifTanjim/nui.nvim',
	'https://github.com/mfussenegger/nvim-dap',
	'https://github.com/nvim-java/nvim-java',

	"https://github.com/nguyenvukhang/nvim-toggler",
}

require('java').setup()
vim.lsp.config('jdtls', {
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-21",
						path = "/usr/lib/jvm/java-21-openjdk",
						default = true,
					},
					{
						name = "JavaSE-1.8",
						path = "/usr/lib/jvm/java-8-openjdk",
					},
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk",
					},
					{
						name = "JavaSE-25",
						path = "/usr/lib/jvm/java-25-openjdk",
					}
				}
			}
		}
	}
})
vim.lsp.enable {
	"lua_ls",
	"rust_analyzer",
	"jdtls",
	"clangd",
	"ts_ls",
	"pyright",
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
		key.set('n', "<leader>cR", vim.lsp.buf.references, opts)

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


require 'nvim-toggler'.setup {}

vim.keymap.set({ 'n', 'v' }, "<leader>ct", require "nvim-toggler".toggle, { desc = "toggle" })
