-- Plugins are managed by vim.pack (neovim 0.12+):
-- :lua vim.pack.update() to update them.

vim.g.mapleader = ' '

-- options --
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.number = true
vim.o.autoindent = true
vim.o.list = false
vim.o.shell = 'sh'
vim.o.wrap = false
vim.o.sidescroll = 1
vim.o.sidescrolloff = 5
vim.o.termguicolors = true
vim.o.showmode = false

vim.cmd.colorscheme('caelus')

-- plugins --
vim.pack.add({
	'https://github.com/nvim-mini/mini.nvim',
	'https://github.com/ibhagwan/fzf-lua',
	'https://github.com/catgoose/nvim-colorizer.lua',
})

require('mini.pairs').setup({
	mappings = {
		['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },
		['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },
	},
})
require('mini.statusline').setup()
require('fzf-lua').setup()
require('colorizer').setup({
	user_default_options = { names = false, RGB = true, RRGGBB = true, RRGGBBAA = true },
})

-- keys --
local map = vim.keymap.set
map('n', '<leader>pv', vim.cmd.Explore, { desc = 'file browser' })
map('n', '<leader>ff', function() require('fzf-lua').files() end, { desc = 'find file' })
map('n', '<leader>lf', function() vim.lsp.buf.format() end, { desc = 'format file' })

vim.lsp.config('clangd', {
	cmd = { 'clangd' },
	filetypes = { 'c', 'cpp' },
	root_markers = { 'compile_commands.json', '.clangd', '.clang-format' },
})
vim.lsp.config('csharp_ls', {
	cmd = { 'csharp-ls' },
	filetypes = { 'cs' },
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, function(name)
			return name:match('%.slnx?$') ~= nil or name:match('%.csproj$') ~= nil
		end)
		if root then on_dir(root) end
	end,
})
vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.git' },
	settings = {
		Lua = { diagnostics = { globals = { 'vim' } }, telemetry = { enable = false } },
	},
})
vim.lsp.config('nil_ls', {
	cmd = { 'nil' },
	filetypes = { 'nix' },
	root_markers = { 'flake.nix', '.git' },
	settings = { ['nil'] = { formatting = { command = { 'nixfmt' } } } },
})
vim.lsp.enable({ 'clangd', 'csharp_ls', 'lua_ls', 'nil_ls' })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = false })
		local function bmap(mode, lhs, rhs, desc)
			map(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
		end
		bmap('i', '<C-Space>', vim.lsp.completion.get, 'completion')
		bmap('n', 'gd', vim.lsp.buf.definition, 'definition')
		bmap('n', 'gD', vim.lsp.buf.declaration, 'declaration')
		bmap('n', 'gi', vim.lsp.buf.implementation, 'implementation')
		bmap('n', 'gr', vim.lsp.buf.references, 'references')
		bmap('n', '<leader>D', vim.lsp.buf.type_definition, 'type definition')
		bmap('n', '<leader>e', vim.diagnostic.open_float, 'line diagnostics')
		bmap('n', '<leader>n', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'next diagnostic')
		bmap('n', '<leader>N', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'previous diagnostic')
		bmap('n', '<C-k>', vim.lsp.buf.signature_help, 'signature help')
		bmap('n', '<leader>o', function() require('fzf-lua').lsp_document_symbols() end, 'symbols')
	end,
})
