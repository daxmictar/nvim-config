vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

local gitsigns = require('gitsigns')

gitsigns.setup({
	current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
	signs = {
		add = { text = "" },
		change = { text = "" },
		delete = { text = "" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		vim.keymap.set(
			"n",
			"<leader>hp",
			gitsigns.preview_hunk,
			{ buffer = bufnr, desc = "Preview git hunk" }
		)

		vim.keymap.set({ "n", "v" }, "]c", function()
			if vim.wo.diff then
				return "]c"
			end

			vim.schedule(function()
				gs.next_hunk()
			end)

			return "<Ignore>"
		end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })

		vim.keymap.set({ "n", "v" }, "[c", function()
			if vim.wo.diff then
				return "[c"
			end

			vim.schedule(function()
				gs.prev_hunk()
			end)

			return "<Ignore>"
		end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
	end
})
