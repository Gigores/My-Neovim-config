require "core.options"
require "core.keymaps"
require "core.lsp"
require "core.snippets"
require "core.md"

require "plugins.completion"
require "plugins.treesitter"

require "config.colorscheme"
require "config.ui"

vim.filetype.add {
    extension = {
        gr = "gearshift",
    },
    pattern = { ["*.gr"] = "gearshift" }
}
