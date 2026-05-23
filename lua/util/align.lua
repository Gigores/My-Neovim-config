return function(delim, start_line, end_line)
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	local max_col = 0
	local parsed = {}

	for i, line in ipairs(lines) do
		local col = line:find(delim, 1, true)

		if col then
			local before = line:sub(1, col - 1)
			local after = line:sub(col + #delim)
			max_col = math.max(max_col, #before)
			parsed[i] = {
				before = before,
				after = after,
			}
		end
	end

	for i, item in ipairs(parsed) do
		if item then
			local padding = string.rep(" ", max_col - #item.before)
			lines[i] = item.before..padding..delim..item.after
		end
	end

	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end
