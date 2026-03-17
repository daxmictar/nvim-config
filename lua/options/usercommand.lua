vim.api.nvim_create_user_command('PackUpdate', function(info)
	local args = info.fargs
	if #args == 0 then
		vim.pack.update({}, { force = true })
		return
	end

	vim.iter(args):each(function(package)
		vim.pack.update({ package }, { force = true })
	end)
end, {
	desc = 'Delete the packages provided.',
	nargs = '?',
})

vim.api.nvim_create_user_command('PackDelete', function(info)
	local fargs = info.fargs
	if #fargs == 0 then
		vim.print("No package provided")
		return
	end

	local args = {}
	for arg in string.gmatch(fargs[1], "[^%s]+") do
		table.insert(args, arg)
	end

	vim.pack.del(args, { force = true })
end, {
	desc = 'Delete the packages provided.',
	nargs = '?',
})
