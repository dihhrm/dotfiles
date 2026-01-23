local completion = vim.g.completion_mode or "blink" -- native is an option

local default_keymaps = {
	{ keys = "<leader>ca", func = vim.lsp.buf.code_action, desc = "Code Actions" },
	{ keys = "<leader>cr", func = vim.lsp.buf.rename, desc = "Code Rename" },
	{ keys = "<leader>k", func = vim.lsp.buf.hover, desc = "Hover Documentation", has = "hoverProvider" },
	{ keys = "K", func = vim.lsp.buf.hover, desc = "Hover (alt)", has = "hoverProvider" },
	{ keys = "gd", func = vim.lsp.buf.definition, desc = "Goto Definition", has = "definitionProvider" },
}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local buf = args.buf
		if client then
			--built-in completion
			if completion == "native" and client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			end

			-- inlay hints
			if client:supports_method("textDocument/inlayHint") then
				vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
			end

			if client:supports_method("textDocument/documentColor") then
				vim.lsp.document_color.enable(true, args.buf, {
					style = "virtual",
				})
			end

			for _, km in ipairs(default_keymaps) do
				-- Only bind if there's no `has` requirement, or the server supports it
				if not km.has or client.server_capabilities[km.has] then
					vim.keymap.set(
						km.mode or "n",
						km.keys,
						km.func,
						{ desc = "LSP: " .. km.desc, buffer = buf, nowait = km.nowait }
					)
				end
			end
		end
	end,
})

local ts_server = vim.g.lsp_typescript_server or "vtsls"

vim.lsp.enable({
	ts_server,
	"cssls",
	"biome",
	"emmet_ls",
	"tailwindcss",
	"lua_ls",
	"yamlls",
	"jsonls",
	"vtsls",
	"vue_ls",
	"pyright",
	"gopls",
})
