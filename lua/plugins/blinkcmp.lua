local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local function get_icon_provider()
  local _, mini_icons = pcall(require, "mini.icons")
  if _G.MiniIcons then return function(kind) return mini_icons.get("lsp", kind or "") end end
  local lspkind_avail, lspkind = pcall(require, "lspkind")
  if lspkind_avail then return function(kind) return lspkind.symbolic(kind, { mode = "symbol" }) end end
end
---@type function|false|nil
local icon_provider = false

local function get_icon(ctx)
  ctx.kind_hl_group = "BlinkCmpKind" .. ctx.kind
  if ctx.item.source_name == "LSP" then
    local item_doc, color_item = ctx.item.documentation, nil
    if item_doc then
      local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
      color_item = highlight_colors_avail and highlight_colors.format(item_doc, { kind = ctx.kind })
    end
    if icon_provider == false then icon_provider = get_icon_provider() end
    if icon_provider then
      local icon = icon_provider(ctx.kind)
      if icon then ctx.kind_icon = icon end
    end
    if color_item and color_item.abbr and color_item.abbr_hl_group then
      ctx.kind_icon, ctx.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
    end
  end
  return ctx
end
local copilot = require "copilot.suggestion"
return {

  "Saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "0.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "zbirenbaum/copilot.lua",
    "kristijanhusak/vim-dadbod-completion",
    "giuxtaposition/blink-cmp-copilot",
  },
  opts_extend = { "sources.default", "sources.cmdline" },
  opts = {
    -- remember to enable your providers here
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "dadbod", "copilot" },
      providers = {
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
          score_offset = 85, -- the higher the number, the higher the priority
        },
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
      },
      min_keyword_length = function(ctx)
        if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then return 2 end
        return 0
      end,
    },
    keymap = {
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-N>"] = { "select_next", "show" },
      ["<C-P>"] = { "select_prev", "show" },
      ["<C-J>"] = { "select_next", "fallback" },
      ["<C-K>"] = { "select_prev", "fallback" },
      ["<C-U>"] = { "scroll_documentation_up", "fallback" },
      ["<C-D>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_next()
          elseif copilot.is_visible() then
            return copilot.accept()
          elseif cmp.snippet_active { direction = 1 } then
            return cmp.snippet_forward()
          elseif has_words_before() then
            return cmp.show()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_prev()
          elseif cmp.snippet_active { direction = -1 } then
            return cmp.snippet_backward()
          end
        end,
        "fallback",
      },
    },
    completion = {
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
        end,
        border = "rounded",
        -- border = "none",
        -- border = (vim.o.background == "light") and "rounded" or "none",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        draw = {
          --
          align_to_component = "label", -- or 'none' to disable
          padding = 1,
          gap = 1,
          -- columns = {
          --   { "label", "label_description", gap = 1 },
          --   { "kind_icon", "kind", gap = 1 },
          -- },

          columns = { { "kind_icon" }, { "label", "label_description", "kind", gap = 1 } },
          components = {
            kind_icon = {
              text = function(ctx)
                get_icon(ctx)
                return ctx.kind_icon .. ctx.icon_gap
              end,
              highlight = function(ctx) return get_icon(ctx).kind_hl_group end,
            },
          },
        },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      },
    },
    signature = {
      window = {
        -- border = "rounded",
        -- border = "none",
        border = (vim.o.background == "light") and "rounded" or "none",
        min_width = 1,
        max_width = 100,
        max_height = 10,
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      },
    },
    appearance = {
      -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
      kind_icons = {
        Copilot = "",
      },
    },
  },
  specs = {
    {
      "AstroNvim/astrolsp",
      optional = true,
      opts = function(_, opts)
        opts.capabilities =
          require("astrocore").extend_tbl(opts.capabilities, require("blink.cmp").get_lsp_capabilities())
      end,
    },
    {
      "folke/lazydev.nvim",
      optional = true,
      specs = {
        {
          "Saghen/blink.cmp",
          opts = function(_, opts)
            if pcall(require, "lazydev.integrations.blink") then
              return require("astrocore").extend_tbl(opts, {
                sources = {
                  -- add lazydev to your completion providers
                  default = { "lazydev" },
                  providers = {
                    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
                  },
                },
              })
            end
          end,
        },
      },
    },
    -- disable built in completion plugins
    { "hrsh7th/nvim-cmp", enabled = false },
    { "rcarriga/cmp-dap", enabled = false },
    { "petertriho/cmp-git", enabled = false },
    { "L3MON4D3/LuaSnip", enabled = false },
    { "onsails/lspkind.nvim", enabled = false },
  },
}