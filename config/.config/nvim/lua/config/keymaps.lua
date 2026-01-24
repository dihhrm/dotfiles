local opts = { silent = true, noremap = true }
local map = vim.keymap.set

-- Buffer navigation
-- Tab\S Tab navigation
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Delete a word backwards
map("n", "dw", 'vb"_d')

-- Quick switch to last edited file (super useful!)
--
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to other buffer" })
map("n", "<leader>`", "<cmd>e #<CR>", { desc = "Switch to other buffer" })

-- Move between windows with Ctrl+hjkl (like tmux)
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize windows with Ctrl+Shift+arrows (macOS friendly)
map("n", "<C-S-Up>", "<cmd>resize +5<CR>", opts)
map("n", "<C-S-Down>", "<cmd>resize -5<CR>", opts)
map("n", "<C-S-Left>", "<cmd>vertical resize -5<CR>", opts)
map("n", "<C-S-Right>", "<cmd>vertical resize +5<CR>", opts)

-- Better line start/end (more comfortable than $ and ^)
map("n", "gl", "$", { desc = "Go to end of line" })
map("n", "gh", "^", { desc = "Go to start of line" })

-- Select all
map("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Auto-close pairs (simple, no plugin needed)
map("i", "`", "``<left>")
map("i", '"', '""<left>')
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "<", "<><left>")

-- File operations
map({ "i", "x", "n", "s" }, "<leader>w", "<cmd>w<CR><esc>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit all" })
map("n", "<leader>Q", ":q!<CR>", { desc = "Quit all!" })
map("n", "<leader>fo", ":lua vim.lsp.buf.format()<CR>", opts) -- Format the current buffer using LSP

-- quickfix list
map("n", "<leader>fi", function()
	local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Quickfix List" })

-- vim.pack keymaps
map("n", "<leader>pu", "<cmd>lua vim.pack.update()<CR>")
map("n", "<leader>pd", function()
	vim.ui.input({ prompt = "Plugin name to delete: " }, function(input)
		if input and input ~= "" then
			pcall(vim.pack.del, { input })
		end
	end)
end, { desc = "Delete Plugin" })
