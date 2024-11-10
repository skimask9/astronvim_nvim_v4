return {
  "wtfox/jellybeans.nvim",
  priority = 1000,
  -- enabled = false,
  config = function()
    require("jellybeans").setup()
    -- vim.cmd.colorscheme "jellybeans"
  end,
}
