return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  enabled = vim.fn.executable "fd" == 1 or vim.fn.executable "fdfind" == 1 or vim.fn.executable "fd-find" == 1,
  dependencies = {
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>lv"] = { "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv" },
          },
        },
      },
    },
  },
  opts = {
    settings = {
      options = {

        on_venv_activate_callback = nil, -- callback function for after a venv activates
        enable_cached_venvs = true, -- use cached venvs that are activated automatically when a python file is registered with the LSP.
        cached_venv_automatic_activation = true, -- if set to false, the VenvSelectCached command becomes available to manually activate them.
        activate_venv_in_terminal = true, -- activate the selected python interpreter in terminal windows opened from neovim
      },
    },
  },
  cmd = "VenvSelect",
}
