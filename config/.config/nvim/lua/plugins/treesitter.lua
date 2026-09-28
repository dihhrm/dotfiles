vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
})

require("nvim-treesitter").setup({})
require("nvim-treesitter").install({
	"bash",
	"blade",
	"c",
	"comment",
	"css",
	"diff",
	"dockerfile",
	"fish",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"html",
	"ini",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"luap",
	"make",
	"markdown",
	"markdown_inline",
	"nginx",
	"nix",
	"proto",
	"python",
	"query",
	"regex",
	"rust",
	"scss",
	"sql",
	"terraform",
	"toml",
	"tsx",
	"typescript",
	"vue",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
	"zig",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "*" },
	callback = function()
		local filetype = vim.bo.filetype
		if filetype and filetype ~= "" then
			local success = pcall(function()
				vim.treesitter.start()
			end)
			if not success then
				return
			end

			-- Only set expr foldes when treesitter successfully started
			vim.wo[0].foldmethod = "expr"
			vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end
	end,
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
