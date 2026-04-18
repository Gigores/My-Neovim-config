local COLORS = {
	bg = "#191A1C",
	fg = "#BCBEC4",
	cursorline = "#1F2024",
	selection  = "#214283",
	linenr     = "#4B5059",
	comment    = "#7A7E85",
	whitespace = "#2F333A",

	keyword      = "#CF8E6D",
	Function     = "#BCBEC4",
	string       = "#6AAB73",
	constant     = "#C77DBB",
	type         = "#CF8E6D",
	number       = "#2AACB8",
	boolean      = "#CF8E6D",
	operator     = "#BCBEC4",
	variable     = "#BCBEC4",
	func_dec     = "#56A8F5",
	metadata     = "#B3AE60",
	struct_field = "#9373A5",

	macro_name = "#908B25",
	c_thing    = "#B5B6E3",

	rust_struct   = "#86985D",
	rust_lifetime = "#20999D",

	cursor     = "#CED0D6",
	visual     = "#214283",
	search     = "#2D543F",
	statusline = "#393B40",
	menu_bg    = "#26272A",
	menu_sel   = "#36383D",
	fold       = "#393B40",
	split      = "#393B40",

	diag_error = "#D64D5B",
	diag_warn  = "#C29E4A",
	diag_info  = "#5E5339",
	diag_hint  = "#1582A4"
}

local fields = {
	-- base UI
	["Normal"]       = { fg = COLORS.fg, bg = COLORS.bg },
	["NormalFloat"]  = { fg = COLORS.fg, bg = COLORS.menu_bg },
	["CursorLine"]   = { bg = COLORS.cursorline },
	["CursorLineNr"] = { fg = COLORS.fg, bold = true },
	["LineNr"]       = { fg = COLORS.linenr },
	["Cursor"]       = { fg = COLORS.bg, bg = COLORS.cursor },
	["Visual"]       = { bg = COLORS.visual },
	["Search"]       = { bg = COLORS.search },
	["IncSearch"]    = { bg = COLORS.search, bold = true },
	["Whitespace"]   = { fg = COLORS.whitespace },

	["StatusLine"]   = { fg = COLORS.fg, bg = COLORS.statusline },
	["StatusLineNC"] = { fg = COLORS.linenr, bg = COLORS.statusline },
	["VertSplit"]    = { fg = COLORS.split },
	["WinSeparator"] = { fg = COLORS.split },

	["Pmenu"]        = { fg = COLORS.fg, bg = COLORS.menu_bg },
	["PmenuSel"]     = { fg = COLORS.fg, bg = COLORS.menu_sel },
	["PmenuSbar"]    = { bg = COLORS.fold },
	["PmenuThumb"]   = { bg = COLORS.linenr },

	["Folded"]       = { fg = COLORS.comment, bg = COLORS.fold },
	["FoldColumn"]   = { fg = COLORS.linenr, bg = COLORS.bg },

	-- syntax
	["Comment"]    = { fg = COLORS.comment, italic = true },
	["Keyword"]    = { fg = COLORS.keyword },
	["Function"]   = { fg = COLORS.Function },
	["String"]     = { fg = COLORS.string },
	["Constant"]   = { fg = COLORS.constant },
	["Type"]       = { fg = COLORS.type },
	["Number"]     = { fg = COLORS.number },
	["Boolean"]    = { fg = COLORS.boolean },
	["Operator"]   = { fg = COLORS.operator },
	["Identifier"] = { fg = COLORS.variable },
	["Delimiter"]  = { fg = COLORS.fg },

	-- common extras
	["Statement"]  = { fg = COLORS.keyword },
	["Conditional"]= { fg = COLORS.keyword },
	["Repeat"]     = { fg = COLORS.keyword },
	["Exception"]  = { fg = COLORS.keyword },
	["PreProc"] = { fg = COLORS.metadata },
	["Special"]    = { fg = COLORS.constant },
	["Directory"] = { fg = COLORS.fg },

	-- diagnostics
	["DiagnosticError"] = { fg = COLORS.diag_error },
	["DiagnosticWarn"]  = { fg = COLORS.diag_warn },
	["DiagnosticInfo"]  = { fg = COLORS.diag_info },
	["DiagnosticHint"]  = { fg = COLORS.diag_hint },

	["DiagnosticUnderlineError"] = { undercurl = true, sp = COLORS.diag_error },
	["DiagnosticUnderlineWarn"]  = { undercurl = true, sp = COLORS.diag_warn },
	["DiagnosticUnderlineInfo"]  = { undercurl = true, sp = COLORS.diag_info },
	["DiagnosticUnderlineHint"]  = { undercurl = true, sp = COLORS.diag_hint },
	["DiagnosticDeprecated"]     = { strikethrough = true, sp = COLORS.diag_error },

	-- tree-sitter
	["@comment"]   = { fg = COLORS.comment, italic = true },
	["@keyword"]   = { fg = COLORS.keyword },
	["@string"]    = { fg = COLORS.string },
	["@number"]    = { fg = COLORS.number },
	["@boolean"]   = { fg = COLORS.boolean },
	["@constant"]  = { fg = COLORS.constant },
	["@type"]      = { fg = COLORS.fg },
	["@operator"]  = { fg = COLORS.operator },
	["@variable"]  = { fg = COLORS.variable },
	["@function"]  = { fg = COLORS.Function },
	["@method"]    = { fg = COLORS.Function },

	-- Oil
	["OilDir"] = { fg = COLORS.fg },
	["OilFile"] = { fg = COLORS.fg },
	["OilDirHidden"] = { fg = COLORS.comment },
	["OilFileHidden"] = { fg = COLORS.comment },

	-- Markdown
	["ColorColumn"] = { bg = COLORS.menu_bg },
	["@markup.list.checked.markdown"] = { fg = COLORS.string },
	["@markup.list.checked"] = { fg = COLORS.string },
	["@markup.list.unchecked"] = { fg = COLORS.comment },

	-- lua
	["@constructor.lua"] = { fg = COLORS.fg },
	["@constant.lua"] = { fg = COLORS.constant },
	["@lsp.typemod.function.declaration.lua"] = { fg = COLORS.func_dec },
	["@lsp.mod.defaultLibrary.lua"] = { fg = COLORS.constant },
	["@lsp.type.variable.lua"] = {},

	-- java
	["javaExternal"] = { fg = COLORS.keyword },
	["javaAnnotation"] = { fg = COLORS.metadata },
	["@lsp.type.annotation.java"] = { fg = COLORS.metadata },
	["@lsp.type.modifier.java"] = { fg = COLORS.keyword },
	["@lsp.typemod.property.readonly.java"] = { fg = COLORS.constant },
	["@lsp.typemod.method.declaration.java"] = { fg = COLORS.func_dec },
	["@lsp.typemod.class.constructor.java"] = { fg = COLORS.func_dec },
	["@lsp.type.namespace.java"] = { fg = COLORS.fg },

	-- C
	["@lsp.typemod.function.declaration.c"] = { fg = COLORS.func_dec },
	["@lsp.typemod.function.definition.c"] = { fg = COLORS.func_dec },
	["@lsp.type.property.c"] = { fg = COLORS.struct_field },
	["@lsp.type.macro.c"] = { fg = COLORS.macro_name },
	["@lsp.typemod.enum.declaration.c"] = { fg = COLORS.c_thing },
	["@lsp.typemod.union.declaration.c"] = { fg = COLORS.c_thing },
	["@lsp.typemod.struct.declaration.c"] = { fg = COLORS.c_thing },

	-- C++
	["@lsp.typemod.function.declaration.cpp"] = { fg = COLORS.func_dec },
	["@lsp.typemod.function.definition.cpp"] = { fg = COLORS.func_dec },
	["@lsp.type.property.cpp"] = { fg = COLORS.struct_field },
	["@lsp.type.macro.cpp"] = { fg = COLORS.macro_name },
	["@lsp.typemod.enum.declaration.cpp"] = { fg = COLORS.c_thing },
	["@lsp.typemod.union.declaration.cpp"] = { fg = COLORS.c_thing },
	["@lsp.typemod.class.declaration.cpp"] = { fg = COLORS.c_thing },
	["@lsp.typemod.struct.declaration.cpp"] = { fg = COLORS.c_thing },

	-- JavaScript
	["@lsp.type.namespace.javascript"] = { fg = COLORS.fg },
	["@lsp.type.property.javascript"] = { fg = COLORS.constant },
	["@lsp.typemod.function.declaration.javascript"] = { fg = COLORS.func_dec },
	["@lsp.type.member.javascript"] = { fg = COLORS.func_dec },

	-- Rust
	["@lsp.type.namespace.rust"] = { fg = COLORS.fg },
	["@lsp.type.enum.rust"] = { fg = COLORS.rust_struct },
	["@lsp.type.struct.rust"] = { fg = COLORS.rust_struct },
	["rustSigil"] = { fg = COLORS.fg },
	["@lsp.type.builtinType.rust"] = { fg = COLORS.keyword },
	["rustLifetime"] = { fg = COLORS.rust_lifetime },
	["@lsp.type.property.rust"] = { fg = COLORS.constant },
	["@lsp.typemod.function.declaration.rust"] = { fg = COLORS.func_dec },
	["@lsp.type.method.rust"] = { fg = COLORS.func_dec },
}

for k, v in pairs(fields) do
	vim.api.nvim_set_hl(0, k, v)
end
