vim.cmd "let g:netrw_banner = 0"
vim.cmd "set completeopt+=noselect"

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.number         = true
vim.opt.relativenumber = true

vim.opt.autoindent  = true
vim.opt.smartindent = true
vim.opt.wrap        = false

vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4

vim.opt.swapfile = false
vim.opt.backup   = false
vim.opt.undofile = true

vim.opt.incsearch  = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase  = true

vim.opt.termguicolors = true
vim.opt.background    = "dark"
vim.opt.scrolloff     = 8
vim.opt.signcolumn    = "yes"

vim.opt.updatetime = 50

vim.opt.clipboard:append "unnamedplus"
-- vim.o.winborder = 'rounded'
vim.opt.hlsearch = true

vim.opt.mouse      = "a"
vim.g.editorconfig = true

vim.o.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function() vim.hl.on_yank() end,
})
