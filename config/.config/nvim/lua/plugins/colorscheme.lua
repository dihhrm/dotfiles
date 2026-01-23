vim.pack.add({
  {
    src = "https://github.com/ellisonleao/gruvbox.nvim"
  }
})

require("gruvbox").setup({
})

vim.cmd("colorscheme gruvbox")
