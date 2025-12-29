return {
  {
    "rcarriga/nvim-notify",
    config = function() 
      require("notify").setup {
        background_colour = function() 
          local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
          if normal_hl and normal_hl.background then
            return string.format("#%06x", normal_hl.background)
          else
            return "#000000"
          end
        end,
        fps = 30,
        timeout = 3000,
        render = "wrapped-compact",
        stages = "fade_in_slide_out",
        minimum_width = 50,
        level = 2,
        top_down = true
      }
    end
  }
}
