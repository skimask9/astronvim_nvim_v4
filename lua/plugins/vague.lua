return {
  "vague2k/vague.nvim",
  config = function()
    require("vague").setup {
      -- optional configuration here
      -- transparent = true, -- don't set background
      style = {
        -- "none" is the same thing as default. But "italic" and "bold" are also valid options
        comments = "italic",
        conditionals = "none",
        functions = "none",
        keywords = "none",
        headings = "bold", -- markdown headings
        operators = "none",
        keyword_return = "none",
        strings = "italic",
        variables = "none",
      },
    }
  end,
}
