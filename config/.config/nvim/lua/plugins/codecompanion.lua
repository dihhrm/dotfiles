vim.pack.add({
	{ src = "https://www.github.com/nvim-lua/plenary.nvim" },
	{ src = "https://www.github.com/olimorris/codecompanion.nvim", version = vim.version.range("^18.0.0") },
})

require("codecompanion").setup({
	interactions = {
		chat = {
			adapter = {
				name = "opencode",
				model = "claude-sonnet-4",
			},
		},
	},
})
