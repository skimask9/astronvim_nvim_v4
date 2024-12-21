return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    -- transparent = true, -- Enable this to disable setting the background color
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
      sidebars = "dark", -- style for sidebars, see below
      floats = "dark", -- style for floating windows
    },
    plugins = {
      all = true,
    },
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
    dim_inactive = true,
    on_colors = function(colors)
      -- colors.hint = colors.orange
      colors.bg = "#16161e"
      -- colors.error = "#ff0000"
    end,
    on_highlights = function(hl, c)
      ---@type table<string, boolean|{enabled:boolean}>

      hl.WinBar = {
        bg = c.none,
        fg = c.fg_dark,
      }
      hl.DiagnosticError = { fg = c.error, bg = c.none } -- Used as the base highlight group. Other Diagnostic highlights link to this by default
      hl.DiagnosticWarn = { fg = c.warning, bg = c.none } -- Used as the base highlight group. Other Diagnostic highlights link to this by default
      hl.DiagnosticInfo = { fg = c.info, bg = c.none } -- Used as the base highlight group. Other Diagnostic highlights link to this by default
      hl.DiagnosticHint = { fg = c.hint, bg = c.none } -- Used as the base highlight group. Other Diagnostic highlights link to this by default
      hl.DiagnosticUnnecessary = { fg = c.terminal_black } -- Used as the base highlight group. Other Diagnostic highlights link to this by default
      hl.LspInlayHint = { bg = "none", fg = "#545c7e" } -- Used to hide bg LspInlayHint
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
      hl.TelescopeBorder = { fg = c.border_highlight, bg = c.bg_float }
      hl.TelescopeNormal = { fg = c.fg, bg = c.bg_float }
      hl.TelescopePromptBorder = { fg = c.orange, bg = c.none }
      hl.TelescopePromptTitle = { fg = c.bg_dark, bg = c.orange }
      hl.TelescopePreviewBorder = { fg = c.error, bg = c.none }
      hl.TelescopeResultsBorder = { fg = c.info, bg = c.none }
      -- hl.TelescopeResultsComment = { fg = c.dark3 }

      -- hl.TelescopeNormal = {
      --   bg = c.bg_dark,
      --   fg = c.fg_dark,
      -- }
      -- hl.TelescopeBorder = {
      --   bg = c.bg_dark,
      --   fg = c.bg_dark,
      -- }
      -- hl.TelescopePromptNormal = {
      --   -- bg = c.bg_dark,
      -- }
      -- hl.TelescopePromptBorder = {
      --   fg = c.fg_dark,
      -- }
      -- hl.TelescopePromptTitle = {
      --   bg = c.error,
      --   fg = c.bg_dark,
      -- }
      hl.TelescopePreviewTitle = {
        bg = c.error,
        fg = c.bg_dark,
      }
      hl.TelescopeResultsTitle = {
        bg = c.info,
        fg = c.bg_dark,
      }
      -- lang-specific
      -- python
      hl["@string.documentation.python"] = {
        fg = c.comment,
      }
      hl["@lsp.typemod.function.defaultLibrary.python"] = {
        link = "@type.builtin",
      }

      -- json
      hl["@property.json"] = {
        fg = c.blue,
      }
      hl["@punctuation.bracket.json"] = {
        fg = c.comment,
      }
    end,
  },
}
