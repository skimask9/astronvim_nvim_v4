return {
  "theHamsta/nvim-dap-virtual-text",
  opts = {
    virt_text_pos = "eol",
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,
  },
}
