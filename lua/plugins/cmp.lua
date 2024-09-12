return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- vim.o.pumblend = 30
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    -- local utils = require "astrocore"
    -- modify the mapping part of the table
    cmp.setup(opts)
    cmp.setup.filetype({ "sql" }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      },
    })
    -- return utils.extend_tbl(opts, {
    --
    --   window = {
    --     documentation = {
    --       winhighlight = "Normal:CmpNormal",
    --       winblend = vim.o.pumblend,
    --       border = "rounded",
    --     },
    --     completion = {
    --       winhighlight = "Normal:CmpNormal",
    --       winblend = vim.o.pumblend,
    --       border = "rounded",
    --     },
    --   },
    -- })
  end,
}
