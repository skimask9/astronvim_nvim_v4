return {
  "benomahony/uv.nvim",
  config = function()
    require("uv").setup {
      -- Auto-activate virtual environments when found
      auto_activate_venv = false,
      keymaps = {
        prefix = "<leader>U", -- Change prefix to <leader>u
        -- Disable specific keymaps
      },
      -- Execution options
      execution = {
        -- Python run command template
        run_command = "uv run fastapi dev",

        -- Show output in notifications
        notify_output = true,

        -- Notification timeout in ms
        notification_timeout = 10000,
      },
    }
  end,
}
