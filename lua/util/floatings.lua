local M = {}

---@alias SplitDirection
---| "left"
---| "right"
---| "above"
---| "below"

---@type table<string, SplitDirection>
M.SplitDirection = {
	LEFT  = "left",
	RIGHT = "right",
	ABOVE = "above",
	BELOW = "below",
}

---@type table<string, number>
M.Factors = {
	ONE_THIRD = 0.3333,
	TWO_THIRDS = 0.6666,
	THREE_QUATERS = 0.75,
	HALF = 0.5,
}

---@class WindowOpts
---@field border (string | string[])?
---@field buf integer?

---@class FloatingWindowOpts : WindowOpts
---@field width_factor number?
---@field height_factor number?

---@param opts FloatingWindowOpts
---@return fun(): integer, integer  # window and buffer
function M.create_floating_window(opts)
	return function()
		local max_width  = vim.api.nvim_win_get_width(0)
		local max_height = vim.api.nvim_win_get_height(0)

		local width = math.floor(max_width * (opts.width_factor or M.Factors.THREE_QUATERS))
		local height = math.floor(max_height * (opts.height_factor or M.Factors.THREE_QUATERS))

		local buf = opts.buf or vim.api.nvim_create_buf(false, true)
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

---@class SplitWindowOpts : WindowOpts
---@field split SplitDirection?
---@field width_factor number?

---@param opts SplitWindowOpts
---@return fun(): integer, integer  # window and buffer
function M.create_split_window(opts)
	return function()
		local max_width = vim.api.nvim_win_get_width(0)
		local width = math.floor(max_width * (opts.width_factor or M.Factors.ONE_THIRD))

		local buf = opts.buf or vim.api.nvim_create_buf(false, true)
		local win = vim.api.nvim_open_win(buf, true, {
			width = width,
			split = opts.split or M.SplitDirection.RIGHT,
			border = opts.border,
		})
		return win, buf
	end
end

---@param opts FloatingWindowOpts
---@return fun()
function M.create_terminal(opts)
	return function()
		M.create_floating_window(opts)()
		vim.cmd.term()
		vim.cmd.startinsert()
	end
end

---@class TermAppOpts : SplitWindowOpts, FloatingWindowOpts
---@field on_exit fun()?
---@field close_on_exit boolean?

---@param cmd string[]
---@param opts TermAppOpts
---@return fun()
function M.create_terminal_app(cmd, opts)
	return function()
		local window, _
		if opts.split == nil then
			window, _ = M.create_floating_window(opts)()
		else
			window, _ = M.create_split_window(opts)()
		end
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
