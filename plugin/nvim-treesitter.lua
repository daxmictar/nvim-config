vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'nvim-treesitter' and kind == 'update' then
			if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
			vim.cmd('TSUpdate')
		end
	end
})

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

local treesitter = require('nvim-treesitter')
treesitter.install({
	'bash',
	'c',
	'cmake',
	'cpp',
	'css',
	'elixir',
	'erlang',
	'fennel',
	'html',
	'java',
	'javascript',
	'markdown',
	'nix',
	'nu',
	'python',
	'ruby',
	'rust',
	'starlark',
	'svelte',
	'typescript',
	'vim',
	'vimdoc',
	'zig'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function() pcall(vim.treesitter.start) end,
})

