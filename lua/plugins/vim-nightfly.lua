-- Lua initialization file
local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nightfly",
  callback = function() vim.api.nvim_set_hl(0, "FoldColumn", { bg = "#011627" }) end,
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
            nightflyUndercurls = true,
            nightflyTransparent = true,
            nightflyNormalFloat = true,
            nightflyUnderlineMatchParen = true,
            nightflyVirtualTextColor = true,
            nightflyWinSeparator = 2,
          },
        },
      },
    },
  },
}
