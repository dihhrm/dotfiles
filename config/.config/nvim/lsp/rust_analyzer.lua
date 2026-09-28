--- @type vim.lsp.Config
---
return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json" },
	settings = {
		["rust-analyzer"] = {
			check = { command = "clippy" }, -- Use clippy for linting
			inlayHints = {
				chainingHints = { enable = false },
				-- bindingModeHints = { enabled = true },
				-- closureReturnTypeHints = { enable = "always" },
			},
		},
	},
}
