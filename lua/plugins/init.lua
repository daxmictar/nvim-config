--[ PLUGINS ]--

vim.pack.add({
	{ src = 'https://github.com/Saghen/blink.cmp', name = "blink.cmp" },
	{ src = 'https://github.com/stevearc/oil.nvim.git', name = "oil.nvim" },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter', name = "treesitter.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig.git', name = "lspconfig.nvim" },
	{ src = 'https://github.com/folke/lazydev.nvim.git', name = "lazydev.nvim" },
	{ src = 'https://github.com/nyoom-engineering/oxocarbon.nvim', name = "colorscheme.oxocarbon.nvim" },
})

require "plugins.colorscheme"
require "plugins.lazydev"
require "plugins.oil"
require "plugins.treesitter"
require "plugins.lspconfig"
require "plugins.blink"
