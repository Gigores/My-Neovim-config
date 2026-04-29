local project_setups = {
	["C noBuild application"] = function(dir)
		local justfile = vim.fs.joinpath(dir, "Justfile")
		local compile_flags = vim.fs.joinpath(dir, "compile_flags.txt")
		local src = vim.fs.joinpath(dir, "src")
		local main = vim.fs.joinpath(src, "main.c")
		local editorconfig = vim.fs.joinpath(dir, ".editorconfig")
		local clangd = vim.fs.joinpath(dir, ".clangd")
		local gitignore = vim.fs.joinpath(dir, ".gitingnore")
		vim.fn.writefile({
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
		}, justfile)
		vim.fn.writefile({ "-Wall -Wextra" }, compile_flags)
		vim.fn.mkdir(src, "p")
		vim.fn.writefile({
			"#include <stdio.h>",
			"",
			"int main(int argc, char **argv) {",
			"    printf(\"Hello, World!\\n\");",
			"    return 0;",
			"}",
		}, main)
		vim.fn.writefile({
			"# https://editorconfig.org",
			"root = true",
			"",
			"[*]",
			"indent_style = space",
			"end_of_line = lf",
			"charset = utf-8",
			"trim_trailing_whitespace = true",
			"insert_final_newline = true",
		}, editorconfig)
		vim.fn.writefile({
			"Diagnostics:",
			"  UnusedIncludes: None",
		}, clangd)
		vim.fn.writefile({
			"bin/",
			"gmon.out",
			"profile.txt",
		}, gitignore)
	end,
	["C noBuild Raylib application"] = function(dir)
		AppName = "app_name"
		local justfile = vim.fs.joinpath(dir, "Justfile")
		local compile_flags = vim.fs.joinpath(dir, "compile_flags.txt")
		local src = vim.fs.joinpath(dir, "src")
		local resources = vim.fs.joinpath(dir, "resources")
		local main = vim.fs.joinpath(src, "main.c")
		local common = vim.fs.joinpath(src, "common.h")
		local editorconfig = vim.fs.joinpath(dir, ".editorconfig")
		local clangd = vim.fs.joinpath(dir, ".clangd")
		local gitignore = vim.fs.joinpath(dir, ".gitingnore")
		vim.ui.input({}, function(input) AppName = input end)
		vim.fn.writefile({
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
		}, justfile)
		vim.fn.writefile({ "-lraylib -Wall -Wextra" }, compile_flags)
		vim.fn.mkdir(src, "p")
		vim.fn.mkdir(resources, "p")
		vim.fn.writefile({
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
		vim.fn.writefile({
			"#pragma once",
			"",
			"#include \"stdio.h\"",
			"#include \"stdlib.h\"",
			"#include \"raylib.h\"",
			"#include \"stdint.h\"",
			"#include \"math.h\"",
		}, common)
		vim.fn.writefile({
			"# https://editorconfig.org",
			"root = true",
			"",
			"[*]",
			"indent_style = space",
			"end_of_line = lf",
			"charset = utf-8",
			"trim_trailing_whitespace = true",
			"insert_final_newline = true",
		}, editorconfig)
		vim.fn.writefile({
			"Diagnostics:",
			"  UnusedIncludes: None",
		}, clangd)
		vim.fn.writefile({
			"bin/",
			"gmon.out",
			"profile.txt",
		}, gitignore)
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
