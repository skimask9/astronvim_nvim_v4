return {
  "wallpants/github-preview.nvim",
  cmd = { "GithubPreviewToggle" },
  opts = {
    -- config goes here
  },
  config = function(_, opts)
    local gpreview = require "github-preview"
    gpreview.setup(opts)
  end,
}
