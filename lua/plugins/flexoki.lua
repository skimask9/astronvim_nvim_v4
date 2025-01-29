return {
  "nuvic/flexoki-nvim",
  name = "flexoki",
  opts = {
    styles = {
      bold = true,
      italic = true,
      transparency = true,
    },
    highlight_groups = {
      -- Comment = { fg = "subtle" },
      -- VertSplit = { fg = "muted", bg = "muted" },
      Folded = { fg = "base", bg = "muted" },
      TelescopeBorder = { bg = "none" },
      TelescopeNormal = { bg = "none" },
      -- TelescopePromptBorder = { fg = },
      TelescopePromptTitle = { bg = "#da702c", fg = "#fffdf5" },
      TelescopeResultsTitle = { fg = "#fffdf5", bg = "#d14d41" },
      TelescopePreviewTitle = { fg = "#fffdf5", bg = "#879a39" },
      NoiceCmdlinePopupTitleCmdline = { bg = "#879a39", fg = "#fffdf5" },

      -- Normal = { fg = "#f2f0e5" },
    },
  },
}
