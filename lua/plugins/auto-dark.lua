return {
  "f-person/auto-dark-mode.nvim",
  -- enabled = false,
  opts = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option_value("background", "dark", {})
      vim.cmd "colorscheme jellybeans"
      -- vim.cmd "colorscheme vague"
      -- vim.cmd "colorscheme tokyonight"
      -- vim.cmd "colorscheme catppuccin"
      -- vim.cmd "colorscheme nightfly"
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {})
      -- vim.cmd "colorscheme tokyonight-day"
      vim.cmd "colorscheme flexoki"
      -- vim.cmd "colorscheme jellybeans"
    end,
  },
}
