-- example configuration
return {
  "Hashino/doing.nvim",
  config = function()
    require("doing").setup {
      message_timeout = 2000,
      doing_prefix = "Doing: ",

      -- doesn"t display on buffers that match filetype/filename to entries
      -- can be either an array or a function that returns an array
      ignored_buffers = { "NvimTree" },

      -- if plugin should manage the winbar
      winbar = { enabled = false },

      store = {
        -- name of tasks file
        file_name = ".tasks",
        -- automatically create a task file when openning directories
        auto_create_file = false,
      },
    }
    -- example on how to change the winbar highlight
    vim.api.nvim_set_hl(0, "WinBar", { link = "Search" })

    local api = require "doing.api"
    --
    vim.keymap.set("n", "<leader>De", api.edit, { desc = "[E]dit what tasks you`re [D]oing" })
    vim.keymap.set("n", "<leader>Dn", api.done, { desc = "[D]o[n]e with current task" })
  end,
}
