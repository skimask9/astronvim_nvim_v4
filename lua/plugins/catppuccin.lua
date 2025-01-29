local mocha = require("catppuccin.palettes").get_palette "mocha"
return {

  "catppuccin/nvim",
  name = "catppuccin",
  lazy = true,
  ---@type CatppuccinOptions
  opts = {
    flavour = "mocha",
    -- flavour = "macchiato",
    -- transparent_background = true, -- disables setting the background color.
    highlight_overrides = {
      mocha = function(mocha)
        return {
          jDiagnosticUnderlineError = { undercurl = true }, -- Used to underline "Error" diagnostics
          jDiagnosticUnderlineWarn = { undercurl = true }, -- Used to underline "Warning" diagnostics
          jDiagnosticUnderlineInfo = { undercurl = true }, -- Used to underline "Information" diagnostics
          jDiagnosticUnderlineHint = { undercurl = true }, -- Used to underline "Hint" diagnostics
          NoiceCmdlinePopupTitleCmdline = { bg = mocha.peach, fg = mocha.crust },
          TelescopeBorder = { fg = mocha.subtext0, bg = mocha.none },
          TelescopeNormal = { fg = mocha.text, bg = mocha.none },
          TelescopePromptBorder = { fg = mocha.peach, bg = mocha.none },
          TelescopePromptTitle = { fg = mocha.crust, bg = mocha.peach },
          TelescopePreviewBorder = { fg = mocha.green, bg = mocha.none },
          TelescopeResultsBorder = { fg = mocha.sky, bg = mocha.none },
          TelescopePromptPrefix = { fg = mocha.peach, bg = mocha.none },
          TelescopeMatching = { fg = mocha.sapphire, bg = mocha.none },
          TelescopeSelection = { fg = mocha.flamingo, bg = mocha.none, bold = true },
          TelescopePromptCounter = { fg = mocha.subtext1, bg = mocha.none },
          TelescopeSelectionCaret = { fg = mocha.blue, bg = mocha.none },
          TelescopePreviewTitle = { bg = mocha.green, fg = mocha.crust },
          TelescopeResultsTitle = { bg = mocha.sky, fg = mocha.crust },
        }
      end,
    },
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = { "italic" },
      keywords = { "bold" },
      strings = {},
      variables = {},
      numbers = { "bold" },
      booleans = { "bold" },
      properties = {},
      types = { "italic" },
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      dap = true,
      dap_ui = true,
      gitsigns = true,
      illuminate = true,
      indent_blankline = true,
      markdown = true,
      mason = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        semantic_tokens = true,
        treesitter = true,
        treesitter_context = true,
      },
      neotree = true,
      notify = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = true,
      treesitter = true,
      ts_rainbow = false,
      ufo = true,
      dadbod_ui = true,
      harpoon = true,
      noice = true,
      blink_cmp = true,
      dashboard = true,
      which_key = true,
      window_picker = true,
      colorful_winsep = { enabled = true, color = "lavender" },
    },
  },
  specs = {
    {
      "akinsho/bufferline.nvim",
      optional = true,
      opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
          highlights = require("catppuccin.groups.integrations.bufferline").get(),
        })
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      optional = true,
      opts = {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      },
    },
  },
}
