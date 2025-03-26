return {
  "sphamba/smear-cursor.nvim",
  dependencies = {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      mappings = { -- Keys to be mapped to their corresponding default scrolling animation
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-y>",
        "zt",
        "zz",
        "zb",
      },
    },
  },

  opts = {
    -- cursor_color = "#d3cdc3",
    smear_between_buffers = true,

    smear_between_neighbor_lines = true,

    scroll_buffer_space = true,

    -- legacy_computing_symbols_support = true,

    smear_insert_mode = true,
    stiffness = 0.8, -- 0.6      [0, 1]
    trailing_stiffness = 0.5, -- 0.3      [0, 1]
    distance_stop_animating = 0.5, -- 0.1      > 0
    -- hide_target_hack = false, -- true     boolean
  },
}
