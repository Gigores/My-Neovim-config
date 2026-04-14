require "core.options"
require "core.keymaps"
require "core.lsp"
require "core.ui"

require "plugins.completion"
require "plugins.treesitter"
require "plugins.java"
require "plugins.toggler"
require "plugins.navigation"
require "plugins.ui"
require "plugins.md"
require "plugins.colorscheme"
require "plugins.surround"

vim.filetype.add {
    extension = {
        gr = "gearshift",
    },
    pattern = { ["*.gr"] = "gearshift" }
}
