vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'blink.cmp' and (kind == 'install' or kind == 'update') then
      vim.system(
        { 'cargo', 'build', '--release' },
        { cwd = ev.data.path }
      )
    end
  end,
})


require('blink.cmp').setup({
	keymap = { preset = 'default' },

	appearance = {
		nerd_font_variant = 'mono'
	},

	completion = {
		documentation = { auto_show = false }
	},

	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},

	fuzzy = {
		implementation = "prefer_rust_with_warning"
	}
})
