require "vim._core.ui2".enable {}
vim.cmd.packadd "nvim.undotree"

vim.diagnostic.config {
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}
	},
	virtual_text = true,
	update_in_insert = true,
}
