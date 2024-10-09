return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  event = "User AstroFile",
  keys = {
    { "<C-q>", function() require("harpoon"):list():select(1) end, desc = "Nav file 1" },
    { "<C-e>", function() require("harpoon"):list():select(2) end, desc = "Nav file 2" },
    { "<C-f>", function() require("harpoon"):list():select(3) end, desc = "Nav file 3" },
    { "<C-t>", function() require("harpoon"):list():select(4) end, desc = "Nav file 4" },
    { "s", function() require("harpoon"):list():next() end, desc = "next" },
    { "S", function() require("harpoon"):list():prev() end, desc = "prev" },
  },
}
