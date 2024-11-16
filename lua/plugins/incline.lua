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
        -- local folded = vim.api.nvim_get_hl(0, { name = "Folded" })
        -- local bg_folded = folded.bg
        -- local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        -- local fg_folded = normal.fg
        local modified = vim.bo[props.buf].modified
        return {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
          guibg = "#44406e",
          -- guibg = bg_folded,
          -- guifg = fg_folded,
        }
      end,
    }
  end,
  event = "VeryLazy",
}
