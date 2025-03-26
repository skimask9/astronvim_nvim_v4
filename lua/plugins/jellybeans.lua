return {
  "wtfox/jellybeans.nvim",
  priority = 1000,
  -- enabled = false,
  config = function()
    require("jellybeans").setup {
      style = "dark", -- "dark" or "light"
      transparent = false,
      italics = true,

      flat_ui = true,

      plugins = {
        all = false,
        auto = true, -- will read lazy.nvim and apply the colors for plugins that are installed
      },
      on_highlights = function(hl, c)
        -- Customize Telescope colors
        hl.NeoTreeFloatBorder = { bg = c.background, fg = c.grey_three }
        hl.TelescopeBorder = { fg = c.grey_three, bg = c.grey_three }
        hl.NoiceCmdlinePopupTitleCmdline = { bg = c.biloba_flower, fg = c.background }
        hl.NoiceCmdlinePopupBorderCmdLine = { bg = c.none, fg = c.biloba_flower }
      end,
    }
    vim.cmd.colorscheme "jellybeans"
  end,
}
