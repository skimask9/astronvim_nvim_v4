return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal`
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      -- comments = { italic = true },
      -- keywords = { bold = true },
      functions = { italic = true },
      -- variables = { bold = true },
      -- comments = { italic = true },
      -- keywords = { bold = true },
      -- functions = {},
      -- variables = {},
      -- variables = { italic = true },

      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "transparent", -- style for sidebars, see below
      floats = "transparent", -- style for floating windows
    },
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
    dim_inactive = true,
    on_colors = function(colors)
      -- colors.hint = colors.orange
      colors.bg = "#16161e"
      -- colors.error = "#ff0000"
    end,
    on_highlights = function(hl, c)
      -- local prompt = "#2d3149"
      hl.WinBar = {
        bg = c.none,
        fg = c.fg_dark,
      }
      hl.DiagnosticError = { fg = c.error, bg = c.none } -- Used as the base highlight group. Other Diagnostic highlights link to this by default
      hl.DiagnosticWarn = { fg = c.warning, bg = c.none } -- Used as the base highlight group. Other Diagnostic highlights link to this by default
      hl.DiagnosticInfo = { fg = c.info, bg = c.none } -- Used as the base highlight group. Other Diagnostic highlights link to this by default
      hl.DiagnosticHint = { fg = c.hint, bg = c.none } -- Used as the base highlight group. Other Diagnostic highlights link to this by default
      hl.DiagnosticUnnecessary = { fg = c.terminal_black } -- Used as the base highlight group. Other Diagnostic highlights link to this by default
      --
      hl.DiagnosticVirtualTextError = { bg = c.none, fg = c.error } -- Used for "Error" diagnostic virtual text
      hl.DiagnosticVirtualTextWarn = { bg = c.none, fg = c.warning } -- Used for "Warning" diagnostic virtual text
      hl.DiagnosticVirtualTextInfo = { bg = c.none, fg = c.info } -- Used for "Information" diagnostic virtual text
      hl.DiagnosticVirtualTextHint = { bg = c.none, fg = c.hint } -- Used for "Hint" diagnostic virtual text
      --
      hl.jDiagnosticUnderlineError = { undercurl = true, sp = c.error } -- Used to underline "Error" diagnostics
      hl.jDiagnosticUnderlineWarn = { undercurl = true, sp = c.warning } -- Used to underline "Warning" diagnostics
      hl.jDiagnosticUnderlineInfo = { undercurl = true, sp = c.info } -- Used to underline "Information" diagnostics
      hl.jDiagnosticUnderlineHint = { undercurl = true, sp = c.hint } -- Used to underline "Hint" diagnostics

      --   hl.TelescopeNormal = {
      --     bg = c.none,
      --     fg = c.fg_dark,
      --   }
      --   hl.TelescopeBorder = {
      --     bg = c.none,
      --     fg = c.fg_dark,
      --   }
      --   hl.TelescopePromptNormal = {
      --     bg = prompt,
      --   }
      --   hl.TelescopePromptBorder = {
      --     bg = prompt,
      --     fg = prompt,
      --   }
      --   hl.TelescopePromptTitle = {
      --     bg = prompt,
      --     fg = prompt,
      --   }
      --   hl.TelescopePreviewTitle = {
      --     bg = c.red,
      --     fg = c.bg_dark,
      --   }
      --   hl.TelescopeResultsTitle = {
      --     bg = c.green,
      --     fg = c.bg_dark,
      --   }
    end,
  },
}
