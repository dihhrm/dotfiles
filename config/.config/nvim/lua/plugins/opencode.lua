vim.pack.add({
	{ src = "https://github.com/NickvanDyke/opencode.nvim.git" },
	{ src = "https://github.com/folke/snacks.nvim" },
})

-- Opencode
vim.g.opencode_opts = {
	provider = {
		enabled = "tmux",
		tmux = {
			focus = false, -- Focus the opencode pane when created (default: false)
			disable_passthrough = true, -- Disable allow-passthrough on the pane (default: true)
		},
	},
}

vim.o.autoread = true

-- vim.keymap.set({ "n", "x" }, "<C-a>", function()
-- require("opencode").ask("@this: ", { submit = true })
-- end, { desc = "Ask opencode…" })
--
-- vim.keymap.set({ "n", "x" }, "<C-x>", function()
-- require("opencode").select()
-- end, { desc = "Execute opencode action…" })
--
vim.keymap.set({ "n", "t" }, "<leader>.", function()
	require("opencode").toggle()
end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })

vim.keymap.set("n", "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<S-C-u>", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll opencode up" })

vim.keymap.set("n", "<S-C-d>", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll opencode down" })

-- remaps para não perder incremento/decremento
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
