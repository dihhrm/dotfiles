-- highlight when yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- Set filetype for .env and .env.* files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("env_filetype", { clear = true }),
	pattern = { "*.env", ".env.*" },
	callback = function()
		vim.opt_local.filetype = "sh"
	end,
})
