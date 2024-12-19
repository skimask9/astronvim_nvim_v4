return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",

  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- local cmp = require "cmp"
    -- opts.sources = cmp.config.sources {
    --   {
    --     name = "html-css",
    --     option = { style_sheets = { "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" } },
    --   },
    -- }
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

    -- option = {
    --   enable_on = { "html", "htmldjango" },
    --   notify = false,
    --   documentation = { auto_show = true },
    --   style_sheets = {
    --     "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
    --     "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css",
    --     "https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css",
    --   },
    -- },
    -- add new source
    -- -- local utils = require "astrocore"
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
