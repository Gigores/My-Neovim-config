local M = {}

function M.create_window(opts)
	return function()
		local max_width  = vim.api.nvim_win_get_width(0)
		local max_height = vim.api.nvim_win_get_height(0)

		local width = math.floor(max_width * 0.75)
		local height = math.floor(max_height * 0.75)

		local buf = vim.api.nvim_create_buf(false, true)
		local win = vim.api.nvim_open_win(buf, true, {
			relative = "editor",
			width = width,
			height = height,
			col = (max_width - width) / 2,
			row = (max_height - height) / 2,
			border = opts.border,
		})
		return win, buf
	end
end

function M.create_terminal(opts)
	return function()
		M.create_window(opts)()
		vim.cmd.term()
		vim.cmd.startinsert()
	end
end

function M.create_terminal_app(cmd, opts)
	return function()
		local window, _ = M.create_window(opts)()
		vim.fn.termopen(cmd, {
			on_exit = opts.on_exit or function()
				if opts and opts.close_on_exit then
					vim.api.nvim_win_close(window, false)
				end
			end,
		})
		vim.cmd.startinsert()
	end
end

return M
