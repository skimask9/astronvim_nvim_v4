return {
  "b0o/incline.nvim",
  config = function()
    require("incline").setup {
      window = {
        padding = 0,
        margin = { vertical = 0, horizontal = 0 },
      },
      -- highlight = {
      --
      --   groups = {
      --     InclineNormal = {
      --       default = true,
      --       group = "NormalFloat",
      --     },
      --     InclineNormalNC = {
      --       default = true,
      --       group = "NormalFloat",
      --     },
      --   },
      -- },
      render = function(props)
        local helpers = require "incline.helpers"
        local devicons = require "nvim-web-devicons"
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")
        if filename == "" then filename = "[No Name]" end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          { "", guifg = ft_color },

          ft_icon and { ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          -- " ",

          {
            " ",
            filename,
            gui = modified and "bold,italic" or "bold",
            guibg = vim.o.background == "light" and "#b7b5ac" or "#3b4261",
          },
          { "", guifg = vim.o.background == "light" and "#b7b5ac" or "#3b4261" },
          -- guibg = "#44406e",
        }
      end,
    }
  end,
  event = "VeryLazy",
}
