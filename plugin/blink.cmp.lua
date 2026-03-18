vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		vim.print(name)
		if name == 'blink.cmp' and (kind == 'install' or kind == 'update') then
			vim.system(
				{ 'cargo', 'build', '--release' },
				{ cwd = ev.data.path }
			):wait()
		end
	end,
})

vim.pack.add({ 'https://github.com/Saghen/blink.cmp' })

require('blink.cmp').setup({
	keymap = { preset = 'default' },

	appearance = {
		nerd_font_variant = 'mono'
	},

	completion = {
		documentation = { auto_show = false },
		ghost_text = {
			enabled = true,
		},
	},

	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},

	fuzzy = {
		implementation = "prefer_rust_with_warning"
	}
})
