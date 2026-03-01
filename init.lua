require "core"
-- require "lazy_init"
vim.filetype.add {
    extension = {
        gr = "gearshift",
    },
    pattern = { ["*.gr"] = "gearshift" }
}
