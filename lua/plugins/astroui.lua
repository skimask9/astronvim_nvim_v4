-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme

    -- colorscheme = "solarized-osaka-night",
    -- colorscheme = "astrodark",
    colorscheme = "tokyonight",
    -- colorscheme = "github_",
    -- colorscheme = "jellybeans",
    -- colorscheme = "nightfly",
    -- colorscheme = "tokyonight-day",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      -- set highlights for all themes
      -- use a function override to let us use lua to retrieve
      -- colors from highlight group there is no default table
      -- so we don't need to put a parameter for this function
      init = function()
        local get_hlgroup = require("astroui").get_hlgroup
        -- get highlights from highlight groups
        local normal = get_hlgroup "Normal"
        local fg, bg = normal.fg, normal.bg
        local bg_alt = get_hlgroup("Visual").bg
        local green = get_hlgroup("String").fg
        --jellybeans
        local red = get_hlgroup("Error").bg
        local red_tokyo = get_hlgroup("Error").fg
        --tokyonight
        -- local red = get_hlgroup("Error").fg
        local yellow = get_hlgroup("Folded").fg
        -- Set TelescopePromptTitle based on the active colorscheme
        local prompt_title_fg, prompt_title_bg
        if vim.o.background == "dark" then
          if vim.g.colors_name == "jellybeans" then
            prompt_title_fg = bg_alt
            prompt_title_bg = red
          elseif vim.g.colors_name == "tokyonight-day" then
            prompt_title_fg = bg_alt
            prompt_title_bg = red_tokyo
          else
            prompt_title_fg = bg_alt
            prompt_title_bg = red_tokyo
          end
        else
          if vim.g.colors_name == "jellybeans" then
            prompt_title_fg = bg_alt
            prompt_title_bg = red
          elseif vim.g.colors_name == "tokyonight-day" then
            prompt_title_fg = bg_alt
            prompt_title_bg = red_tokyo
          else
            prompt_title_fg = bg_alt
            prompt_title_bg = red_tokyo
          end
        end
        -- return a table of highlights for telescope based on
        -- colors gotten from highlight groups
        return {
          -- CmpNormal = { bg = bg, fg = bg },

          -- BackGround = { bg = "#ffffff" },
          LspInlayHint = { bg = "none", fg = "#545c7e" },
          -- FoldColumn = { bg = "#011627" },
          -- StatusLine = { bg = "none" },
          -- TabLine
          TabLine = { bg = "none" },
          TabLineSel = { bg = "none" },
          TabLineFill = { bg = "none" },
          -- NormalFloat = { bg = folded_bg, fg = fg },
          -- BufferLine
          BufferLine = { bg = "none" },
          BufferLineSel = { bg = "none" },
          BufferLineFill = { bg = "none" },
          -- WinBar
          WinBar = { bg = "none" },
          WinBarNC = { bg = "none" },
          --Telescope
          TelescopeBorder = { fg = fg, bg = bg },
          TelescopeNormal = { bg = bg },
          TelescopePreviewBorder = { fg = fg },
          TelescopePreviewNormal = { bg = bg },
          TelescopePreviewTitle = { fg = bg_alt, bg = green },
          TelescopePromptBorder = { fg = fg },
          TelescopePromptNormal = { fg = fg },
          TelescopePromptPrefix = { fg = red },
          TelescopePromptTitle = { fg = prompt_title_fg, bg = prompt_title_bg },
          --now
          -- TelescopePromptTitle = { fg = bg_alt, bg = red },
          -- TelescopeResultsBorder = { fg = bg, bg = bg },
          TelescopeResultsBorder = { fg = fg },
          TelescopeResultsNormal = { bg = bg, fg = fg },
          TelescopeResultsTitle = { fg = bg_alt, bg = yellow },
          --nvchad telescope
          -- TelescopeBorder = { fg = bg_alt, bg = bg },
          -- TelescopeNormal = { bg = bg },
          -- TelescopePreviewBorder = { fg = bg, bg = bg },
          -- TelescopePreviewNormal = { bg = bg },
          -- TelescopePreviewTitle = { fg = bg, bg = green },
          -- TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
          -- TelescopePromptNormal = { fg = fg, bg = bg_alt },
          -- TelescopePromptPrefix = { fg = red, bg = bg_alt },
          -- TelescopePromptTitle = { fg = bg, bg = red },
          -- TelescopeResultsBorder = { fg = bg, bg = bg },
          -- TelescopeResultsNormal = { bg = bg },
          -- TelescopeResultsTitle = { fg = bg, bg = bg },
          --Diagnostics
          -- DiagnosticVirtualTextError = { bg = "none", fg = "#c53b53" },
          -- DiagnosticVirtualTextWarn = { bg = "none", fg = "##ffc777" },
          -- DiagnosticVirtualTextInfo = { bg = "none", fg = "#0db9d7" },
          -- DiagnosticVirtualTextHint = { bg = "none", fg = "#1abc9c" },
        }
      end,
    }, -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
