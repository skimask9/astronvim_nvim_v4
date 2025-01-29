return {
  "wtfox/jellybeans.nvim",
  priority = 1000,
  enabled = false,
  config = function()
    require("jellybeans").setup {
      -- Your custom configuration
      style = "dark",
      transparent = true, -- If you want transparent background
      italics = true,
      plugins = {
        all = true, -- Enable highlighting for all plugins
        auto = true, -- Auto-detect and apply colors for installed plugins
      },
      -- Optional: customize specific highlights
      on_highlights = function(highlights, colors)
        -- Example: customize the background color of normal text
        highlights.Normal = {
          fg = colors.foreground,
          bg = colors.background,
        }
        -- You can add more custom highlights here
      end,
    }
    -- vim.cmd.colorscheme "jellybeans"
  end,
}
