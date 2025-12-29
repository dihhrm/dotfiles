return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    require("lualine").setup({
      theme = "sonokai",
      options = {
        icons_enabled = false,
      },
    })
  end,
}
