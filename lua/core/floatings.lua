local M = {}

function M.create_window(opts)
	return function()
		local max_width  = vim.api.nvim_win_get_width(0)
		local max_height = vim.api.nvim_win_get_height(0)

		local width = math.floor(max_width * 0.75)
		local height = math.floor(max_height * 0.75)

		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_open_win(buf, true, {
			relative = "editor",
			width = width,
			height = height,
			col = (max_width - width) / 2,
			row = (max_height - height) / 2,
			border = opts.border,
		})
	end
end

function M.create_terminal(cmd, opts)
	return function()
		M.create_window(opts)()
		vim.cmd.term(cmd)
		vim.cmd.startinsert()
	end
end

return M
