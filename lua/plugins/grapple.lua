return {
  "cbochs/grapple.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "AstroNvim/astroui", opts = { icons = { Grapple = "󰛢" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local prefix = "<Leader><Leader>"
        maps.n[prefix] = { desc = require("astroui").get_icon("Grapple", 1, true) .. "Grapple" }
        maps.n[prefix .. "a"] = { "<Cmd>Grapple toggle<CR>", desc = "Add file" }
        maps.n[prefix .. "d"] = { "<Cmd>Grapple untag<CR>", desc = "Remove file" }
        maps.n[prefix .. "e"] = { "<Cmd>Grapple toggle_tags<CR>", desc = "Toggle tags menu" }
        maps.n[prefix .. "t"] = { "<Cmd>Grapple toggle_scopes<CR>", desc = "Select from tags" }
        maps.n[prefix .. "s"] = { "<Cmd>Grapple toggle_loaded<CR>", desc = "Select a project scope" }
        maps.n[prefix .. "x"] = { "<Cmd>Grapple reset<CR>", desc = "Clear tags from current project" }
        -- maps.n["<C-n>"] = { "<Cmd>Grapple cycle forward<CR>", desc = "Select next tag" }
        -- maps.n["<C-p>"] = { "<Cmd>Grapple cycle backward<CR>", desc = "Select previous tag" }
      end,
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
  },
  keys = {

    { "<c-q>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
    { "<c-e>", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
    { "<c-f>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
    { "<c-t>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },

    { "<c-s-n>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
    { "<c-s-p>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
  },
  cmd = { "Grapple" },
}
