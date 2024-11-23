return {
  "f-person/auto-dark-mode.nvim",
  -- enabled = false,
  opts = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option_value("background", "dark", {})
      vim.cmd "colorscheme jellybeans"
      -- vim.cmd "colorscheme tokyonight"
      -- vim.cmd "colorscheme flexoki-moon"
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {})
      -- vim.cmd "colorscheme tokyonight-day"
      -- vim.cmd "colorscheme github_light"
      vim.cmd "colorscheme flexoki"
    end,
  },
}
