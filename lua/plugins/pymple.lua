return {

  "alexpasmantier/pymple.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- optional (nicer ui)
    "stevearc/dressing.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  build = ":PympleBuild",
  config = function()
    require("pymple").setup {
      keymaps = {
        resolve_import_under_cursor = {
          desc = "Resolve import under cursor",
          keys = "<leader>lx", -- feel free to change this to whatever you like
        },
      },
    }
  end,
}
