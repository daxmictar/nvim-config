vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim",                  name = "catppuccin" },
	{ src = 'https://github.com/nyoom-engineering/oxocarbon.nvim', name = 'oxocarbon' }
})

require("catppuccin").setup({
	flavour = "mocha",
	background = {
		dark = "mocha",
	},
	integrations = {
		blink_cmp = {
			style = 'bordered'
		},
		gitsigns = true,
		notify = true,
	}
})

vim.cmd('colorscheme catppuccin')
vim.cmd(':hi statusline guibg=NONE')
