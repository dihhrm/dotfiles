return {
  "folke/noice.nvim",
  event = "VeryLazy",
  config = function()
    require("noice").setup({
      routes = {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      },
      presets = {
        lsp_doc_border = true,
        inc_rename = true,
      },
      views = {
        cmdline_popup = {
          border = { style = "none", padding = { 2, 3 } },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
    })
  end,
}
