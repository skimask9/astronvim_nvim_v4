-- example configuration
return {
  "Hashino/doing.nvim",
  -- enabled = false,
  config = function()
    require("doing").setup {
      message_timeout = 2000,
      doing_prefix = "Doing: ",

      -- doesn"t display on buffers that match filetype/filename to entries
      -- can be either an array or a function that returns an array
      ignored_buffers = { "NvimTree" },
      show_remaining = true,

      -- if plugin should manage the winbar
      winbar = { enabled = false },
      edit_win_config = {
        width = 50,
        height = 15,
        border = "rounded",
      },

      store = {
        -- name of tasks file
        file_name = ".tasks",
        -- automatically create a task file when openning directories
        auto_create_file = false,
      },
    }
    -- example on how to change the winbar highlight
    vim.api.nvim_set_hl(0, "WinBar", { link = "Search" })

    local doing = require "doing"
    --
    vim.keymap.set("n", "<leader>Da", doing.add, { desc = "[D]oing: [A]dd" })
    vim.keymap.set("n", "<leader>De", doing.edit, { desc = "[D]oing: [E]dit" })
    vim.keymap.set("n", "<leader>Dn", doing.done, { desc = "[D]oing: Do[n]e" })
    vim.keymap.set("n", "<leader>Dt", doing.toggle, { desc = "[D]oing: [T]oggle" })
  end,
}
