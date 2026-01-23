vim.opt.mouse = ""

-- globals editor
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.list = true
vim.opt.linebreak = true
vim.opt.scrolloff = 10 -- keep 10 line above/below cursor
vim.opt.sidescrolloff = 8 -- keep 8 columns r/l of cursor
vim.opt.jumpoptions = "view"
vim.opt.laststatus = 3 -- global statusline

--indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

--visual settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true -- highlight matching brackets
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.pumheight = 10 --popup menu height
vim.opt.pumblend = 10 -- transparency
vim.opt.winblend = 0 -- floating win transparency
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.concealcursor = "" -- Don't hide cursor line markup
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.ruler = false -- disable default ruler
vim.opt.virtualedit = "block" --  Allow cursor to move where there is no text in visual block mode
vim.opt.winminwidth = 5

--file handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undolevels = 10000
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = true -- auto save

--behavior settings
vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error bells
vim.opt.backspace = "indent,eol,start" -- better backspace behavior
vim.opt.autochdir = false -- dont auto change directory
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.path:append("**") -- include subdirectories in search
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.opt.modifiable = true -- allow buffers modifications
vim.opt.encoding = "utf-8"

--folding settings
vim.opt.smoothscroll = true
vim.wo.foldmethod = "expr"
vim.opt.foldlevel = 99
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"

--split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"

--command line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

--better diff options
vim.opt.diffopt:append("linematch:60")

--performace improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

--coding & globals
--
vim.g.autoformat = true
vim.g.trouble_lualine = true

vim.opt.fillchars = {
	foldopen = "-",
	foldclose = "+",
	fold = " ",
	foldsep = " ",
	diff = "/",
	eob = " ",
}

vim.g.markdown_recommended_style = 0

vim.filetype.add({
	extension = {
		env = "dotenv",
	},
	filename = {
		[".env"] = "dotenv",
		["env"] = "dotenv",
	},
	pattern = {
		["[jt]sconfig.*.json"] = "jsonc",
		["%.env%.[%w_.-]+"] = "dotenv",
	},
})
