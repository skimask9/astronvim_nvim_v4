return {
  "monkoose/neocodeium",
  enabled = false,
  event = "BufEnter",
  opts = {
    filetypes = {
      TelescopePrompt = false,
      ["dap-repl"] = false,
      help = false,
      -- gitcommit = true,
      -- gitrebase = true,
      ["."] = false,
    },
    -- priority = 0,
  },
  -- enabled = false,
  -- enabled = false,
  config = function()
    local neocodeium = require "neocodeium"
    neocodeium.setup()
    vim.keymap.set("i", "<C-g>", neocodeium.accept)
    vim.keymap.set("i", "<A-w>", function() require("neocodeium").accept_word() end)
    -- vim.keymap.set("i", "<A-a>", function() require("neocodeium").accept_line() end)
    vim.keymap.set("i", "<C-e>", function() require("neocodeium").cycle_or_complete() end)
    vim.keymap.set("i", "<C-y>", function() require("neocodeium").cycle_or_complete(-1) end)
    vim.keymap.set("i", "<C-x>", function() require("neocodeium").clear() end)
  end,
}
