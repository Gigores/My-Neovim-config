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

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	pattern = "*.log",
	callback = function()
		vim.bo.filetype = "log"
	end,
})

local function is_binary(path)
    local f = io.open(path, "rb")
    if not f then
        return false
    end

    local chunk = f:read(1024)
    f:close()

    if not chunk then
        return false
    end

    return chunk:find("\0") ~= nil
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function(args)
        local path = vim.api.nvim_buf_get_name(args.buf)

        if is_binary(path) then
            vim.bo[args.buf].binary = true

            vim.cmd("%!xxd")
            vim.bo[args.buf].filetype = "xxd"

            vim.b[args.buf].is_xxd = true
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        if vim.b[args.buf].is_xxd then
            vim.cmd("%!xxd -r")
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function(args)
        if vim.b[args.buf].is_xxd then
            vim.cmd("%!xxd")
        end
    end,
})
