return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User AstroFile",
    -- enabled = false,
    opts = {
      suggestion = { auto_trigger = true, debounce = 350 },
      -- accept = "<M-CR>" alt enter to accept
      filetypes = { ["*"] = true },
    },
  },
}
