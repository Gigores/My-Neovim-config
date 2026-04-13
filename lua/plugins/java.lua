local gh = require "util.providers".github

vim.pack.add {
	{
		src = gh 'JavaHello/spring-boot.nvim',
		version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
	},
	gh 'MunifTanjim/nui.nvim',
	gh 'mfussenegger/nvim-dap',
	gh 'nvim-java/nvim-java',
}

require('java').setup()
