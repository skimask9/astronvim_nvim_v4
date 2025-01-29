-- local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
-- local pal = require("nightfly").palette
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "nightfly",
--   callback = function()
--     vim.api.nvim_set_hl(0, "FoldColumn", { bg = pal.bg })
--     vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = pal.orange, fg = "#d6deeb", bold = true })
--     vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = pal.kashmir_blue })
--     vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = pal.kashmir_blue })
--     vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = pal.cyan_blue, fg = "#d6deeb", bold = true })
--     vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = pal.red, fg = "#d6deeb", bold = true })
--     vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = pal.kashmir_blue })
--     vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleCmdline", { bg = pal.orange, fg = "#d6deeb" })
--     -- vim.api.nvim_set_hl(0, "NotifyBackground", { bg = pal.none })
--   end,
--   group = custom_highlight,
-- })
return {
  "bluz71/vim-nightfly-colors",
  name = "nightfly",
  lazy = false,
  priority = 1000,
  config = function()
    -- Theme configurations
    vim.g.nightflyCursorColor = true -- Enable cursor color
    vim.g.nightflyNormalFloat = true -- Enable consistent floating window background
    vim.g.nightflyUnderlineMatchParen = true -- Underline matching parentheses
    vim.g.nightflyVirtualTextColor = true -- Enable distinct virtual text color
    vim.g.nightflyWinSeparator = 2 -- Enable window separators
    vim.g.nightflyTransparent = true -- Enable transparent background

    -- Set colorscheme
    -- vim.cmd [[colorscheme nightfly]]
    -- Custom highlights setup
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
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleCmdline", { bg = pal.orange, fg = "#d6deeb" })
        vim.api.nvim_set_hl(0, "LspInlayHint", { bg = pal.none, fg = "#4b6479" })
      end,
      group = custom_highlight,
    })
  end,
}
