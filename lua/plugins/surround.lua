local gh = require "util.providers".github

vim.pack.add {
	gh "nvim-mini/mini.surround"
}

require "mini.surround".setup {}
