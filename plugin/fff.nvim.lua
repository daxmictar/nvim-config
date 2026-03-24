vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
			vim.system(
				{ 'cargo', 'build', '--release' },
				{ cwd = ev.data.path }
			):wait()
		end
	end
})

vim.pack.add({ 'https://github.com/dmtrKovalenko/fff.nvim' })

-- the plugin will automatically lazy load
vim.g.fff = {
	lazy_sync = true, -- start syncing only when the picker is open
	debug = {
		enabled = true,
		show_scores = true,
	},
}

vim.keymap.set(
	'n',
	'ff',
	function() require('fff').find_files() end,
	{ desc = 'FFFind files' }
)
