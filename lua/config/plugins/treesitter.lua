return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,

    config = function()
      require("nvim-treesitter").install({
          "lua",
          "vim",
          "tsx",
          "vimdoc",
          "javascript",
          "typescript",
          "css",
          "gitignore",
          "vue",
          "python",
          "ruby",
          "go",
          "gowork",
          "gomod",
          "gosum",
          "sql",
          "scss",
          "http",
          "json"
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact"
        },
        callback = function()
          vim.treesitter.start()
        end
      })
    end
  }
}
