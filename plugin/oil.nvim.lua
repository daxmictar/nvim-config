--[ Oil.nvim ]--
vim.pack.add({ 'https://github.com/stevearc/oil.nvim.git' })

require('oil').setup()

-- mnemonic for 'explore'
vim.keymap.set('n', '<leader>e', ':Oil<CR>', { desc = "Open the file [e]xplorer in the current working directory." })
