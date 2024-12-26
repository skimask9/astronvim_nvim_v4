local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
local pal = require("nightfly").palette
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nightfly",
  callback = function()
    vim.api.nvim_set_hl(0, "FoldColumn", { bg = pal.bg })
    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = pal.orange, fg = "#d6deeb", bold = true })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = pal.kashmir_blue })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = pal.kashmir_blue })
    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = pal.cyan_blue, fg = "#d6deeb", bold = true })
    vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = pal.red, fg = "#d6deeb", bold = true })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = pal.kashmir_blue })
  end,
  group = custom_highlight,
})
return {
  "bluz71/vim-nightfly-colors",
  name = "nightfly",
  lazy = true,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        options = {
          g = {
            nightflyCursorColor = true,
            nightflyNormalFloat = true,
            nightflyUnderlineMatchParen = true,
            nightflyVirtualTextColor = true,
            nightflyWinSeparator = 2,
            nightflyTransparent = true,
          },
        },
      },
    },
  },
}
