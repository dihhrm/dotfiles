return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "typescript",
        "css",
        "gitignore",
        "http",
        "json",
        "scss",
        "sql",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "vim",
        "lua",
        "vue",
        "python",
        "ruby",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
