vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
})

require("gitsigns").setup({
	word_diff = false,
	current_line_blame = true,
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end)
		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end)

		-- Actions
		map("n", "<leader>hp", gs.preview_hunk)
		map("n", "<leader>hi", gs.preview_hunk_inline)

		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end)

		map("n", "<leader>hd", gs.diffthis)

		-- Toggles
		map("n", "<leader>tb", gs.toggle_current_line_blame)
		map("n", "<leader>tw", gs.toggle_word_diff)
	end,
})
