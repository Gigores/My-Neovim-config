local project_setups = {
	["C noBuild application"] = function(dir)
		local justfile = vim.fs.joinpath(dir, "Justfile")
		local compile_flags = vim.fs.joinpath(dir, "compile_flags.txt")
		local src = vim.fs.joinpath(dir, "src")
		local resources = vim.fs.joinpath(dir, "resources")
		local main = vim.fs.joinpath(src, "main.c")
		vim.fn.writefile({
			"build:",
			"	@mkdir -p bin",
			"	@gcc $(xargs < compile_flags.txt) src/*.c -o bin/main",
			"",
			"build-asan:",
			"	@mkdir -p bin",
			"	@gcc $(xargs < compile_flags.txt) -fsanitize=address -g src/*.c -o bin/main",
			"",
			"build-profiler:",
			"	@mkdir -p bin",
			"	@gcc $(xargs < compile_flags.txt) -pg -O0 -g src/*.c -o bin/main",
			"",
			"run:",
			"	@bin/main",
			"",
			"run-asan: build-asan",
			"    @just run",
			"",
			"run-profiler: build-profiler",
			"    @just run",
			"    @gprof bin/main gmon.out > profile.txt",
			"    @cat profile.txt",
			"",
			"clear:",
			"	@rm -rf bin",
			"",
			"default:",
			"	@just build",
			"	@just run",
		}, justfile)
		vim.fn.writefile({ "-Wall -Wextra" }, compile_flags)
		vim.fn.mkdir(src, "p")
		vim.fn.mkdir(resources, "p")
		vim.fn.writefile({
			"#include <stdio.h>",
			"",
			"int main(int argc, char **argv) {",
			"	printf(\"Hello, World!\\n\");",
			"	return 0;",
			"}",
		}, main)
	end,
}

local function get_setup_names()
	local project_setup_names = {}
	for k, _ in pairs(project_setups) do
		table.insert(project_setup_names, k)
	end
	return project_setup_names
end

local function run_setup(setup_name)
	local setup = project_setups[setup_name]
	if setup == nil then
		error("Setup not found")
	else
		print("RUNNING "..setup_name)
		setup(vim.cmd.pwd())
	end
end

vim.keymap.set('n', "<leader>S", function()
	vim.ui.select(get_setup_names(), {}, run_setup)
end, { desc = "Project setup wizard" })
