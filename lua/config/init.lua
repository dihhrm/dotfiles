vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.termguicolors = true

require("config.autocmds")
require("config.options")
require("config.keymaps")
require("config.lsp")
require("config.lazy")
