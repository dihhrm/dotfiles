local vue_language_server_path = vim.fn.exepath("vue-language-server")

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
	enableForWorkspaceTypeScriptVersions = true,
}

---@type vim.lsp.Config
return {
	cmd = { "vtsls", "--stdio" },
	init_options = {
		hostInfo = "neovim",
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
	settings = {
		vtsls = { tsserver = { globalPlugins = { vue_plugin } } },
	},
	on_attach = function(client, bufnr)
		local ft = vim.bo[bufnr].filetype
		-- se vue desliga diagnostics do vtsls nesse buffer, pois o vue_ls cuida disto
		if ft == "vue" then
			local ns = vim.lsp.diagnostic.get_namespace(client.id)
			vim.diagnostic.enable(false, { bufnr = bufnr, ns_id = ns })

			-- desliga semantic tokens para evitar conflito visual do parser
			if client.server_capabilities.semanticTokensProvider then
				client.server_capabilities.semanticTokensProvider.full = true
			end
		end
	end,
	root_dir = function(bufnr, on_dir)
		-- The project root is where the LSP can be started from
		-- As stated in the documentation above, this LSP supports monorepos and simple projects.
		-- We select then from the project root, which is identified by the presence of a package
		-- manager lock file.
		local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
		-- Give the root markers equal priority by wrapping them in a table
		root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
			or vim.list_extend(root_markers, { ".git" })

		-- exclude deno
		if vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" }) then
			return
		end

		-- We fallback to the current working directory if no project root is found
		local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

		on_dir(project_root)
	end,
}
