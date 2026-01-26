local caps = vim.lsp.protocol.make_client_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true

--- @type vim.lsp.Config
return {
	name = "emmet_ls",
	cmd = { "emmet-language-server", "--stdio" },
	capabilities = caps,
	filetypes = {
		"astro",
		"css",
		"eruby",
		"html",
		"htmlangular",
		"htmldjango",
		"javascriptreact",
		"less",
		"pug",
		"sass",
		"scss",
		"svelte",
		"templ",
		"typescriptreact",
		"vue",
	},
	init_options = {
		html = { options = { ["bem.enabled"] = true } },
	},
	root_markers = {
		".git",
		"package.json",
		"bun.lock",
		"bun.lockb",
	},
}
