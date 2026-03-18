vim.lsp.enable({
	'clangd',
	'cssls',
	'html',
	'lua_ls',
	'nil_ls',
	'nushell',
	'ruff', -- python formatter / lsp
	'rust_analyzer',
	'svelte',
	'ty', -- python typechecker
	'ts_ls',
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, { desc = "[T]oggle Inlay [H]ints" })
    end

    -- Change diagnostic symbols in the sign column (gutter)
    if vim.g.have_nerd_font then
      local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config({ signs = { text = diagnostic_signs } })
    end
  end,
})

vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })

vim.api.nvim_create_user_command('LspLog', function()
	vim.cmd(string.format('tabnew %s', vim.lsp.log.get_filename()))
end, {
	desc = 'Opens the Nvim LSP client log.',
})

vim.api.nvim_create_user_command('LspStart', function(info)
  local servers = info.fargs

  -- Default to enabling all servers matching the filetype of the current buffer.
  -- This assumes that they've been explicitly configured through `vim.lsp.config`,
  -- otherwise they won't be present in the private `vim.lsp.config._configs` table.
  if #servers == 0 then
    local filetype = vim.bo.filetype
    for name, _ in pairs(vim.lsp.config._configs) do
      local filetypes = vim.lsp.config[name].filetypes
      if filetypes and vim.tbl_contains(filetypes, filetype) then
        table.insert(servers, name)
      end
    end
  end

  vim.lsp.enable(servers)
end, {
  desc = 'Enable and launch a language server',
  nargs = '?',
  complete = function(arg)
  return vim
      .iter(vim.api.nvim_get_runtime_file(('lsp/%s*.lua'):format(arg), true))
      :map(function(path)
        local file_name = path:match('[^/]*.lua$')
        return file_name:sub(0, #file_name - 4)
      end)
      :totable()
end
,
})

vim.api.nvim_create_user_command('LspRestart', function(info)
	local client_names = info.fargs
	if #client_names == 0 then
		client_names = vim
			.iter(vim.lsp.get_clients())
			:map(function(client)
				return client.name
			end)
			:totable()
	end

	for name in vim.iter(client_names) do
		if vim.lsp.config[name] == nil then
			vim.notify(("Invalid server name '%s'"):format(name))
		else
			vim.lsp.enable(name, false)
			if info.bang then
				vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
					client:stop(true)
				end)
			end
		end
	end

	local timer = assert(vim.uv.new_timer())
	timer:start(500, 0, function()
		for name in vim.iter(client_names) do
			vim.schedule_wrap(vim.lsp.enable)(name)
		end
	end)
end, {
	desc = 'Restart the given client',
	nargs = '?',
	bang = true,
	complete = function(arg)
		return vim
			.iter(vim.lsp.get_clients())
			:map(function(client)
				return client.name
			end)
			:filter(function(name)
				return name:sub(1, #arg) == arg
			end)
			:totable()
	end,
})

vim.api.nvim_create_user_command('LspStop', function(info)
	local client_names = info.fargs
	if #client_names == 0 then
		client_names = vim
			.iter(vim.lsp.get_clients())
			:map(function(client)
				return client.name
			end)
			:totable()
	end

	for name in vim.iter(client_names) do
		if vim.lsp.config[name] == nil then
			vim.notify(("Invalid server name '%s'"):format(name))
		else
			vim.lsp.enable(name, false)
			if info.bang then
				vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
					client:stop(true)
				end)
			end
		end
	end
end, {
	desc = 'Disable and stop the given client',
	nargs = '?',
	bang = true,
	complete = function(arg)
		return vim
			.iter(vim.lsp.get_clients())
			:map(function(client)
				return client.name
			end)
			:filter(function(name)
				return name:sub(1, #arg) == arg
			end)
			:totable()
	end,
})

