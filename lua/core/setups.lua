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
			"set dotenv-filename := \"project.env\"",
			"set dotenv-load := true",
			"",
			"project_name := env_var(\"NAME\")",
			"project_version := env_var(\"VERSION\")",
			"",
			"binary := \"bin/\" + project_name",
			"c_env := \"-DAPP_NAME=\\\\\\\"\" + project_name + \"\\\\\\\" \" + \\",
			"         \"-DAPP_VERSION=\\\\\\\"\" + project_version + \"\\\\\\\"\"",
			"",
			"_create-bin:",
			"    mkdir -p bin",
			"",
			"build: _create-bin",
			"    gcc {{ c_env }} $(xargs < compile_flags.txt) src/*.c -o {{ binary }}",
			"",
			"build-asan: _create-bin",
			"    gcc $(xargs < compile_flags.txt) {{ c_env }} -fsanitize=address -g src/*.c -o {{ binary }}",
			"",
			"build-profiler: _create-bin",
			"    gcc $(xargs < compile_flags.txt) {{ c_env }} -pg -O0 -g src/*.c -o {{ binary }}",
			"",
			"run:",
			"    {{ binary }}",
			"",
			"run-asan: build-asan run",
			"",
			"run-profiler: build-profiler run",
			"    gprof bin/main gmon.out > profile.txt",
			"    cat profile.txt",
			"",
			"clear:",
			"    rm -rf bin",
			"",
			"update-compiler-defines:",
			"    bear -- just build",
			"",
			"default: build run",
		}
	}
}
local project_setups = {
	["C noBuild application"] = function(dir)
		AppName = "app_name"
		AppVer = "app_ver"
		local justfile = joinpath(dir, "Justfile")
		local compile_flags = joinpath(dir, "compile_flags.txt")
		local src = joinpath(dir, "src")
		local main = joinpath(src, "main.c")
		local editorconfig = joinpath(dir, ".editorconfig")
		local clangd = joinpath(dir, ".clangd")
		local gitignore = joinpath(dir, ".gitignore")
		local projectenv = joinpath(dir, "project.env")
		vim.ui.input({ prompt = "Application Name: " }, function(input) AppName = input end)
		vim.ui.input({ prompt = "Application Version: " }, function(input) AppVer = input end)
		writefile(common_files.c.justfile, justfile)
		writefile({ "-Wall -Wextra" }, compile_flags)
		mkdir(src, "p")
		writefile({
			"#include <stdio.h>",
			"",
			"int main(int argc, char **argv) {",
			"    printf(\"Hello, \");",
			"    printf(APP_NAME);",
			"    printf(\"!\\n\");",
			"    return 0;",
			"}",
		}, main)
		writefile(common_files.c.editorconfig, editorconfig)
		writefile(common_files.c.clangd, clangd)
		writefile(common_files.c.gitignore, gitignore)
		writefile({
			"NAME="..AppName,
			"VERSION="..AppVer,
		}, projectenv)
	end,
	["C noBuild Raylib application"] = function(dir)
		AppName = "app_name"
		AppVer = "app_ver"
		local justfile = joinpath(dir, "Justfile")
		local compile_flags = joinpath(dir, "compile_flags.txt")
		local src = joinpath(dir, "src")
		local resources = joinpath(dir, "resources")
		local main = joinpath(src, "main.c")
		local common = joinpath(src, "common.h")
		local editorconfig = joinpath(dir, ".editorconfig")
		local clangd = joinpath(dir, ".clangd")
		local gitignore = joinpath(dir, ".gitignore")
		local projectenv = joinpath(dir, "project.env")
		vim.ui.input({ prompt = "Application Name: " }, function(input) AppName = input end)
		vim.ui.input({ prompt = "Application Version: " }, function(input) AppVer = input end)
		writefile(common_files.c.justfile, justfile)
		writefile({ "-lraylib -Wall -Wextra" }, compile_flags)
		mkdir(src, "p")
		mkdir(resources, "p")
		writefile({
			"#include \"common.h\"",
			"",
			"#define WINDOW_TITLE APP_NAME \" v\" APP_VERSION",
			"",
			"int main(int argc, char **argv)",
			"{",
			"	InitWindow(1280, 720, WINDOW_TITLE);",
			"",
			"	while (!WindowShouldClose())",
			"	{",
			"		BeginDrawing();",
			"			ClearBackground(RAYWHITE);",
			"			DrawText(APP_NAME, 190, 200, 20, LIGHTGRAY);",
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
		writefile({
			"NAME="..AppName,
			"VERSION="..AppVer,
		}, projectenv)
	end,
}

local function get_setup_names()
	local project_setup_names = {}
	for k, _ in pairs(project_setups) do
		table.insert(project_setup_names, k)
	end
	table.sort(project_setup_names, function(a, b)
		return a:lower() < b:lower()
	end)
	return project_setup_names
end

local function run_setup(setup_name)
	local setup = project_setups[setup_name]
	local setup_path = vim.cmd.pwd()
	if setup == nil then
		error("Setup not found")
	else
		print("RUNNING "..setup_name)
		setup(setup_path)
	end
end

vim.keymap.set('n', "<leader>S", function()
	vim.ui.select(get_setup_names(), {}, run_setup)
	vim.cmd "!just update-compiler-defines"
	vim.cmd.pwd()
	require "oil.actions".refresh.callback({})
end, { desc = "Project setup wizard" })
