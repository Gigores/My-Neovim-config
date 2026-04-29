local writefile = vim.fn.writefile
local mkdir = vim.fn.mkdir
local joinpath = vim.fs.joinpath

local common_files = {
	c = {
		editorconfig = {
			"# https://editorconfig.org",
			"root = true",
			"",
			"[*]",
			"indent_style = space",
			"end_of_line = lf",
			"charset = utf-8",
			"trim_trailing_whitespace = true",
			"insert_final_newline = true",
		},

		clangd = {
			"Diagnostics:",
			"  UnusedIncludes: None",
		},

		gitignore = {
			"bin/",
			"gmon.out",
			"profile.txt",
		},

		justfile = {
			"build:",
			"    @mkdir -p bin",
			"    @gcc $(xargs < compile_flags.txt) src/*.c -o bin/main",
			"",
			"build-asan:",
			"    @mkdir -p bin",
			"    @gcc $(xargs < compile_flags.txt) -fsanitize=address -g src/*.c -o bin/main",
			"",
			"build-profiler:",
			"    @mkdir -p bin",
			"    @gcc $(xargs < compile_flags.txt) -pg -O0 -g src/*.c -o bin/main",
			"",
			"run:",
			"    @bin/main",
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
			"    @rm -rf bin",
			"",
			"default:",
			"    @just build",
			"    @just run",
		}
	}
}
local project_setups = {
	["C noBuild application"] = function(dir)
		local justfile = joinpath(dir, "Justfile")
		local compile_flags = joinpath(dir, "compile_flags.txt")
		local src = joinpath(dir, "src")
		local main = joinpath(src, "main.c")
		local editorconfig = joinpath(dir, ".editorconfig")
		local clangd = joinpath(dir, ".clangd")
		local gitignore = joinpath(dir, ".gitingnore")
		writefile(common_files.c.justfile, justfile)
		writefile({ "-Wall -Wextra" }, compile_flags)
		mkdir(src, "p")
		writefile({
			"#include <stdio.h>",
			"",
			"int main(int argc, char **argv) {",
			"    printf(\"Hello, World!\\n\");",
			"    return 0;",
			"}",
		}, main)
		writefile(common_files.c.editorconfig, editorconfig)
		writefile(common_files.c.clangd, clangd)
		writefile(common_files.c.gitignore, gitignore)
	end,
	["C noBuild Raylib application"] = function(dir)
		AppName = "app_name"
		local justfile = joinpath(dir, "Justfile")
		local compile_flags = joinpath(dir, "compile_flags.txt")
		local src = joinpath(dir, "src")
		local resources = joinpath(dir, "resources")
		local main = joinpath(src, "main.c")
		local common = joinpath(src, "common.h")
		local editorconfig = joinpath(dir, ".editorconfig")
		local clangd = joinpath(dir, ".clangd")
		local gitignore = joinpath(dir, ".gitingnore")
		vim.ui.input({}, function(input) AppName = input end)
		writefile(common_files.c.justfile, justfile)
		writefile({ "-lraylib -Wall -Wextra" }, compile_flags)
		mkdir(src, "p")
		mkdir(resources, "p")
		writefile({
			"#include \"common.h\"",
			"",
			"int main(int argc, char **argv)",
			"{",
			"	InitWindow(1280, 720, \""..AppName.."\");",
			"",
			"	while (!WindowShouldClose())",
			"	{",
			"		BeginDrawing();",
			"			ClearBackground(RAYWHITE);",
			"			DrawText(\""..AppName.."\", 190, 200, 20, LIGHTGRAY);",
			"		EndDrawing();",
			"	}",
			"",
			"	CloseWindow();",
			"",
			"	return 0;",
			"}",
		}, main)
		writefile({
			"#pragma once",
			"",
			"#include \"stdio.h\"",
			"#include \"stdlib.h\"",
			"#include \"raylib.h\"",
			"#include \"stdint.h\"",
			"#include \"math.h\"",
		}, common)
		writefile(common_files.c.editorconfig, editorconfig)
		writefile(common_files.c.clangd, clangd)
		writefile(common_files.c.gitignore, gitignore)
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
