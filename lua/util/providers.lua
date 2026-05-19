local M = {}

---@param repo string  # example: `Gigores/My-Neovim-config`
---@return string  # a full repo URL
function M.github(repo)
	assert(type(repo) == "string", "providers.github: \"repo\" should be a string, got " .. type(repo))
	return "https://github.com/" .. repo
end

return M
