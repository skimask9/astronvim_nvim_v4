-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
          "htmldjango",
          "html",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      htmx = {
        filetypes = { "html", "templ", "htmldjango" },
      },
      djlint = {
        filetypes = { "htmldjango", "django" },
      },
      -- html = {
      --   filetypes = { "htmldjango", "html", "django" },
      -- },

      -- cssls = {
      --   filetypes = { "htmldjango" },
      -- },
      gopls = {
        templateExtensions = { "templ", "tmpl" },
        -- hints = {
        --   assignVariableTypes = true,
        --   compositeLiteralFields = true,
        --   compositeLiteralTypes = true,
        --   constantValues = true,
        --   functionTypeParameters = true,
        --   parameterNames = true,
        --   rangeVariableTypes = true,
        -- },
      },
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            disableLanguageServices = false,
            analysis = {
              -- ignore = { "*" },
              autoImportCompletions = true,
              autoSearchPaths = true,
              reportUnusedVariable = false,
              diagnosticMode = "openFilesOnly",
              reportMissingTypeStubs = false,
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      },
      -- jinja_lsp = {
      --   filetypes = { "jinja", "python" },
      --   init_options = {
      --     templates = "./templates",
      --     backend = { "./src" },
      --     lang = "python",
      --   },
      -- },
      pyright = { enabled = false },
      -- python = {
      --   analysis = {
      --     -- Ignore all files for analysis to exclusively use Ruff for linting
      --     ignore = { "*" },
      --   },
      -- },
      -- pyright = {
      --   -- Using Ruff's import organizer
      --   -- enabled = false,
      --   disableOrganizeImports = true,
      --   -- settings = {
      --   --   python = {
      --   --     analysis = {
      --   --       typeCheckingMode = "off",
      --   --     },
      --   --   },
      --   -- },
      -- },
      -- basedpyright = {
      --   analysis = {
      --     autoSearchPaths = true,
      --     diagnosticMode = "openFilesOnly",
      --     useLibraryCodeForTypes = true,
      --   },
      -- },
      -- ruff_lsp = {
      -- on_attach = on_attach,
      -- on_attach = function(client, bufnr)
      --   if client.name == "ruff_lsp" then
      --     -- Disable hover in favor of Pyright
      --     client.server_capabilities.hoverProvider = false
      --   end
      -- end,
      -- },
      tailwindcss = {
        root_dir = function(fname)
          local util = require "lspconfig.util"
          return util.root_pattern(
            "tailwind.config.js",
            "config/tailwind.config.js",
            "tailwind.config.ts",
            "./theme/static_src/tailwind.config.js"
          )(fname) or util.root_pattern("postcss.config.js", "postcss.config.ts")(fname) or util.find_package_json_ancestor(
            fname
          ) or util.find_node_modules_ancestor(fname) or util.find_git_ancestor(fname)
        end,
        userLanguages = {
          htmldjango = "html",
          templ = "html",
        },
      },
      -- templ = {
      --   filetypes = { "html" },
      -- },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
