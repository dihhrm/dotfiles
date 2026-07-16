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

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("man_unlisted", { clear = true }),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("json_conceal", { clear = true }),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Set filetype for .toml files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("toml_filetype", { clear = true }),
	pattern = { "*.tomg-config*" },
	callback = function()
		vim.opt_local.filetype = "toml"
	end,
})

-- Soft-wrap prose so long lines break at the window edge instead of scrolling
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("prose_wrap", { clear = true }),
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true
		vim.opt_local.breakindentopt = "shift:2"
		vim.opt_local.showbreak = "↳ "
	end,
})
