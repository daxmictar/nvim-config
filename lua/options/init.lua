require "options.autocommand"
require "options.usercommand"
require "options.keymap"
require "options.lsp"

-- [ FILE ]--
vim.o.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.relativenumber = true
-- List mode: By default, show tabs as ">", trailing spaces as "-", and non-breakable space characters as "+".
-- vim.o.list = true
-- Replaces certain characters in the editor
-- vim.o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- [ WINDOW ]--
vim.o.splitbelow = true
vim.o.splitright = true

-- [ NATIVE ]--
vim.o.mouse = 'a'
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.winborder = "single"
vim.o.wrap = false

-- [ BUFFER ] --
vim.opt.updatetime = 1000 -- 1 second
vim.opt.autoread = true
