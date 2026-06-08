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
	"c3_lsp",
}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("userlspconfig", {}),
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }
		local key = vim.keymap

		opts.desc = "hover info"
		key.set('n', "<leader>ck", function()
			vim.lsp.buf.hover {
				border = { '⎸', ' ', '⎹', '⎹', '⎹', ' ', '⎸', '⎸' },
			}
		end, opts)

		opts.desc = "go to definition"
		key.set('n', "gd", vim.lsp.buf.definition, opts)

		opts.desc = "go to declaration"
		key.set('n', "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "go to implementation"
		key.set('n', "gi", vim.lsp.buf.implementation, opts)

		opts.desc = "signature help"
		key.set('n', "<leader>cK", vim.lsp.buf.signature_help, opts)

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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end
		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
		end
	end,
})

vim.keymap.set('n', "<leader>ch", function()
	vim.lsp.inlay_hint.enable(
		not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
		{ bufnr = 0 }
	)
end, { desc = "Toggle hints "})
