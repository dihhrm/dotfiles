return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local fb_actions = require("telescope").extensions.file_browser.actions

      require("telescope").setup({
        pickers = {
          find_files = {
            theme = "ivy",
          },
        },
        defaults = {
          file_ignore_patterns = { "node_modules" },
          wrap_results = true,
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
        },
        extensions = {
          fzf = {},
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            mappings = {
              ["n"] = {
                ["N"] = fb_actions.create,
                ["h"] = fb_actions.goto_parent_dir,
                ["/"] = function()
                  vim.cmd("startinsert")
                end,
              },
            },
          },
        },
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")

      vim.keymap.set("n", ";f", function()
        require("telescope.builtin").find_files({
          no_ignore = false,
          hidden = true,
        })
      end)
      vim.keymap.set("n", ";r", require("telescope.builtin").live_grep)
      vim.keymap.set("n", ";t", require("telescope.builtin").help_tags)
      vim.keymap.set("n", "fb", function()
        local path = "%:p:h"
        require("telescope").extensions.file_browser.file_browser({
          path = path,
          cwd = vim.fn.expand(path),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
      end)
      vim.keymap.set("n", ";s", require("telescope.builtin").treesitter)
    end,
  },
}
