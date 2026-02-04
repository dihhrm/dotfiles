-- Terminal from Tjdevries
-- https://github.com/tjdevries/config.nvim/blob/master/plugin/terminal.lua
--
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.scrolloff = 0

		vim.bo.buftype = "terminal"
	end,
})

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("t", "qq", "<cmd>close<CR>", { desc = "Hide terminal" })

vim.keymap.set("n", ",st", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end)
