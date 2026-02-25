vim.g.lazydev_enabled = true

local servers = {
	"lua_ls",
	"nil_ls",
	"nushell",
	"rust_analyzer",
	"zls",
}

vim.iter(servers)
	:map(function(server)
		vim.lsp.enable(server)
	end)

