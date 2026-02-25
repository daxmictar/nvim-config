local set = vim.keymap.set

--[ NATIVE KEYMAPS ]--
set("n", "<leader>so", ":update<CR> :source<CR>", { desc = "Source the current file buffer." })
set("n", "<leader>w", ":write<CR>", { desc = "Write to the current buffer." })
set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Cancel the current highlight group." })
set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
set("n", "<C-u>", "<Nop>")

--[ LSP KEYMAPS ]--
set("n", "<leader>f", vim.lsp.buf.format, { desc = "Run a formatter on the current buffer." })

set(
  "n",
  "<leader>d",
  vim.diagnostic.open_float,
  { desc = "Open a floating diagnostic message under the cursor." }
)
set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open the diagnostics list buffer underneath the current buffer." }
)

set("n", "[d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to the previous diagnostic message" })

set("n", "]d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to next diagnostic message" })

set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename the variable under your cursor." })

set(
  { "n", "x" },
  "<leader>ca",
  vim.lsp.buf.code_action,
  { desc = 'Selects a code action (LSP: "textDocument/codeAction" request) available at the cursor position.' }
)

set(
  "n",
  "gD",
  vim.lsp.buf.declaration,
  { desc = "Jumps to the declaration of the symbol under the cursor." }
)

-- Remap for dealing with word wrap
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- For opening oil
set(
  "n",
  "<leader>e",
  "<CMD>Oil<CR>",
  { desc = "Open the file [e]xplorer in the current working directory." }
)


