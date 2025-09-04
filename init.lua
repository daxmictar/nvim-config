--[ NATIVE OPTIONS ]--
vim.g.mapleader = " "
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.winborder = "double"
vim.o.wrap = false
-- vim.o.list = true -- List mode: By default, show tabs as ">", trailing spaces as "-", and non-breakable space characters as "+".
-- vim.o.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Replaces certain characters in the editor
vim.o.splitbelow = true
vim.o.splitright = true

--[ NATIVE KEYMAPS ]--
vim.keymap.set('n', '<leader>so', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--[ PACKAGES ]--
vim.pack.add({
	{ src = 'https://github.com/echasnovski/mini.pick.git' },     -- simpler fuzzy finder
	{ src = 'https://github.com/stevearc/oil.nvim.git' },         -- a better file system plugin
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' }, -- treesitter...
	{ src = 'https://github.com/neovim/nvim-lspconfig.git' },     -- defaults for LSP configurations
	{ src = 'https://github.com/folke/lazydev.nvim.git' },        -- resolves annoying warnings when writing nvim-lua
	{ src = 'https://github.com/nyoom-engineering/oxocarbon.nvim' }, -- current colorscheme
})

-- Hook for autocomplete using omnicomplete
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
		if client and client:supports_method('textDocument/inlayHint') then
			vim.keymap.set('n', '<leader>th', function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
			end, { desc = '[T]oggle Inlay [H]ints' })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

--[ HighLightOnYank ]--
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--[ LANGUAGE SERVERS ]--
vim.lsp.enable({ 'lua_ls', 'basedpyright', 'nil_ls', 'nushell', 'rust_analyzer', 'zls' })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Run a formatter on the current buffer.' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
	{ desc = 'Open a floating diagnostic message under the cursor.' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
	{ desc = 'Open the diagnostics list buffer underneath the current buffer.' })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
	{ desc = 'Go to the previous diagnostic message' })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename the variable under your cursor.' })
vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action,
	{ desc = 'Selects a code action (LSP: "textDocument/codeAction" request) available at the cursor position.' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Jumps to the declaration of the symbol under the cursor.' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Jumps to the definition of the symbol under the cursor.' })

--[ Mini.pick ]--
require 'mini.pick'.setup()
vim.keymap.set('n', '<leader>s', ':Pick files<CR>') -- mnemonic for 'search'
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')  -- mnemonic for 'help'

--[ Oil.nvim ]--
require 'oil'.setup()
vim.keymap.set('n', '<leader>fs', ':Oil<CR>') -- mnemonic for 'file-system'

--[ Treesitter ]--
require 'nvim-treesitter.configs'.setup({
	auto_install = false,
	ensure_installed = { 'bash', 'c', 'cpp', 'cmake', 'svelte', 'typescript', 'javascript', 'nu', 'python', 'markdown', 'nix', 'ruby', 'rust', 'starlark', 'zig' },
	highlight = { enable = true },
	ignore_install = {},
	modules = {},
	sync_install = true
})

--[ Lazydev.nvim ]--
require 'lazydev'.setup()

--[ COLORSCHEME ]--
-- require 'oxocarbon'.setup()
vim.cmd('colorscheme oxocarbon')
vim.cmd(':hi statusline guibg=NONE')
