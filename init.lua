require "core.options"
require "core.keymaps"
require "core.lsp"
require "core.snippets"
require "core.md"
require "core.ui"

require "plugins.completion"
require "plugins.treesitter"
require "plugins.java"
require "plugins.toggler"
require "plugins.navigation"

require "config.colorscheme"
require "config.ui"

vim.filetype.add {
    extension = {
        gr = "gearshift",
    },
    pattern = { ["*.gr"] = "gearshift" }
}
