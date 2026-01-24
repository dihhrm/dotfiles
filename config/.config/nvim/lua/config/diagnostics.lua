local map = vim.keymap.set
local pallete = {
	err = "#51202A",
	warn = "#3B3B1B",
	info = "#1F3342",
	hint = "#1E2E1E",
}

vim.api.nvim_set_hl(0, "DiagnosticErrorLine", { bg = pallete.err, blend = 20 })
vim.api.nvim_set_hl(0, "DiagnosticWarnLine", { bg = pallete.warn, blend = 15 })
vim.api.nvim_set_hl(0, "DiagnosticInfoLine", { bg = pallete.info, blend = 10 })
vim.api.nvim_set_hl(0, "DiagnosticHintLine", { bg = pallete.hint, blend = 10 })
vim.api.nvim_set_hl(0, "DapBreakpointSign", { bg = nil, fg = "#FF0000", bold = true })
vim.fn.sign_define("DapBreakpoint", {
	text = "●", -- a large dot; change as desired
	texthl = "DapBreakpointSign", -- the highlight group you just defined
	linehl = "", -- no full-line highlight
	numhl = "", -- no number-column highlight
})

local severity = vim.diagnostic.severity

vim.diagnostic.config({
	-- keep underline and severity_sort  on for quick scanning
	underline = true,
	severity_sort = true,
	update_in_insert = false,

	float = {
		border = "rounded",
		source = true,
	},

	-- keep signs & virtual text
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.INFO] = " ",
			[severity.HINT] = "󰌵 ",
		},
	},
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	linehl = {
		[severity.ERROR] = "DiagnosticErrorLine",
		[severity.WARN] = "DiagnosticWarnLine",
		[severity.INFO] = "DiagnosticInfoLine",
		[severity.HINT] = "DiagnosticHintLine",
	},
})

-- diagnostic keymaps
local diagnostic_goto = function(next, severity)
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		vim.diagnostic.jump({ count = next and 1 or -1, float = true, severity = severity })
	end
end

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostic" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
