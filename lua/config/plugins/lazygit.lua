return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  keys = {
    {
      ";c",
      ":LazyGit<Return>",
      silent = true,
      noremap = true,
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
