return {
  "nuvic/flexoki-nvim",
  name = "flexoki",
  opts = {
    variant = "dawn", -- auto, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,
    styles = {
      bold = true,
      italic = false,
      transparency = false,
    },
    groups = {
      border = "muted",
      link = "purple_two",
      panel = "surface",

      error = "red_one",
      hint = "purple_one",
      info = "cyan_one",
      ok = "green_one",
      warn = "orange_one",
      note = "blue_one",
      todo = "magenta_one",

      git_add = "green_one",
      git_change = "yellow_one",
      git_delete = "red_one",
      git_dirty = "yellow_one",
      git_ignore = "muted",
      git_merge = "purple_one",
      git_rename = "blue_one",
      git_stage = "purple_one",
      git_text = "magenta_one",
      git_untracked = "subtle",

      h1 = "purple_two",
      h2 = "cyan_two",
      h3 = "magenta_two",
      h4 = "orange_two",
      h5 = "blue_two",
      h6 = "cyan_two",
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
