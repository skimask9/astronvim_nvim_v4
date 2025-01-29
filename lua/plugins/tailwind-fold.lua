return {
  "razak17/tailwind-fold.nvim",
  -- enabled = false,
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "VeryLazy",
  config = function() require("tailwind-fold").setup { ft = { "html", "htmldjango", "django", "templ" } } end,
}
