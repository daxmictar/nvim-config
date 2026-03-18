return {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
		"--log=verbose",
		"--query-driver=/nix/store/*-clang-wrapper-*/bin/clang*",
	},
	root_markers = {
		'.clangd',
		'.clang-tidy',
		'.clang-format',
		'compile_commands.json'
	}
}
