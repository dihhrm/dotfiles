vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "Podfile",
  callback = function()
    vim.bo.filetype = "ruby"
  end,
})

-- Highlight when yanking text
--
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Gitsigns show inline changes
--
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd([[
    hi GitSignsChangeInline gui=reverse
    hi GitSignsAddInline gui=reverse
    hi GitSignsDeleteInline gui=reverse
   ]])
  end,
})
