return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- local cmp = require "cmp"
    -- vim.o.pumblend = 30
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local astrocore, astroui = require "astrocore", require "astroui"
    if not opts.formatting then opts.formatting = {} end
    opts.formatting.format = astrocore.patch_func(opts.formatting.format, function(format, ...)
      -- get item from original formatting function
      local vim_item = format(...)

      -- truncate label to maximum of 25% of the window
      local label = vim_item.abbr
      local truncated_label = vim.fn.strcharpart(label, 0, math.floor(0.25 * vim.o.columns))
      if truncated_label ~= label then vim_item.abbr = truncated_label .. astroui.get_icon "Ellipsis" end

      -- truncate menu to maximum of 25% of the window
      local menu = vim_item.menu or ""
      local truncated_menu = vim.fn.strcharpart(menu, 0, math.floor(0.25 * vim.o.columns))
      if truncated_menu ~= menu then vim_item.menu = truncated_menu .. astroui.get_icon "Ellipsis" end

      return vim_item
    end)
    -- local utils = require "astrocore"
    -- modify the mapping part of the table
    -- cmp.setup(opts)
    -- cmp.setup.filetype({ "sql" }, {
    --   sources = {
    --     { name = "vim-dadbod-completion" },
    --     { name = "buffer" },
    --   },
    -- })
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
