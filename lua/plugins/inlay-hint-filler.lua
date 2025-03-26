return {
  "Davidyz/inlayhint-filler.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<Leader>I", -- Use whatever keymap you want.
      function() require("inlayhint-filler").fill() end,
      desc = "Insert the inlay-hint under cursor into the buffer.",
    },
  },
}
