vim.cmd('highlight clear')
vim.o.background = 'dark'
vim.g.colors_name = 'caelus'

local c = {
	black = '#0f0f0f', red = '#f16e65', green = '#7ec97e', yellow = '#ef934d',
	blue = '#71b4d6', magenta = '#e28dc6', cyan = '#7ec9a3', white = '#d9cdb5',
	lightyellow = '#efbf71', lightgray = '#9a9c8b', darkgray = '#1e1f1e', linenr = '#6c756f',
}

local groups = {
	Normal = { fg = c.white, bg = c.black },
	Comment = { fg = c.lightgray },
	Constant = { fg = c.cyan },
	['@constant.builtin'] = { fg = c.cyan },
	String = { fg = c.green },
	Number = { fg = c.magenta },
	Function = { fg = c.lightyellow },
	Statement = { fg = c.red },
	Type = { fg = c.cyan, bold = true },
	['@type.builtin'] = { link = 'Type' },
	Identifier = { fg = c.blue },
	['@variable'] = { fg = c.blue },
	Operator = { fg = c.white },
	PreProc = { fg = c.white },
	Special = { fg = c.white },
	Delimiter = { fg = c.white },
	Tag = { fg = c.white },
	Error = { fg = c.red },
	LineNr = { fg = c.linenr },
	CursorLineNr = { fg = c.lightyellow },
	CursorLine = { underline = true },
	ColorColumn = { bg = c.black },
	Cursor = { fg = c.black, bg = c.white },
	Visual = { fg = c.black, bg = c.yellow },
	StatusLine = { fg = c.darkgray, bg = c.lightgray, bold = true },
	StatusLineNC = { fg = c.lightgray, bg = c.darkgray },
	WinSeparator = { fg = c.white, bg = c.black },
	Pmenu = { fg = c.white, bg = c.darkgray },
	PmenuSel = { fg = c.darkgray, bg = c.lightgray, bold = true },
	NormalFloat = { fg = c.white, bg = c.darkgray },
	-- vis-modal mode colours
	MiniStatuslineModeNormal = { fg = c.black, bg = c.yellow, bold = true },
	MiniStatuslineModeInsert = { fg = c.black, bg = c.green, bold = true },
	MiniStatuslineModeVisual = { fg = c.black, bg = c.magenta, bold = true },
	MiniStatuslineModeReplace = { fg = c.black, bg = c.blue, bold = true },
	MiniStatuslineModeCommand = { fg = c.black, bg = c.blue, bold = true },
	MiniStatuslineModeOther = { fg = c.black, bg = c.blue, bold = true },
	MiniStatuslineFilename = { fg = c.lightgray, bg = c.darkgray },
	MiniStatuslineInactive = { fg = c.lightgray, bg = c.darkgray },
}

for name, spec in pairs(groups) do
	vim.api.nvim_set_hl(0, name, spec)
end
