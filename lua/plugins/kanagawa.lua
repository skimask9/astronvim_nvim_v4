return {
  "rebelot/kanagawa.nvim",
  lazy = true,
  opts = {
    transparent = false,
    styles = {
      sidebars = "dark",
      floats = "dark",
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      NormalFloat = { bg = "none" },
      TelescopeTitle = { fg = theme.ui.special, bold = true },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
    }
  end,
}
