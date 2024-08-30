-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "lua_ls",
        -- add more arguments for adding more language servers
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "stylua",
        -- add more arguments for adding more null-ls sources
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "python",
        -- add more arguments for adding more debuggers
      })
      opts.handlers = {
        python = function(config)
          config.adapters = {
            type = "executable",
            command = vim.fn.exepath "debugpy-adapter",
          }
          config.configurations = {
            {
              type = "python",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              pythonPath = "python",
            },
            {
              type = "python",
              request = "launch",
              name = "Django",
              program = vim.fn.getcwd() .. "/manage.py", -- NOTE: Adapt path to manage.py as needed
              args = { "runserver" },
              pythonPath = "python",
              django = true,
              console = "integratedTerminal",
            },
            {
              type = "python",
              request = "launch",
              name = "Django SSH",
              program = vim.fn.getcwd() .. "/manage.py", -- NOTE: Adapt path to manage.py as needed
              args = { "runserver", "0.0.0.0:3000" },
              pythonPath = "python",
              django = true,
              console = "integratedTerminal",
            },
            {
              type = "python",
              request = "launch",
              name = "FastAPI",
              module = "fastapi",
              pythonPath = "python",
              args = {
                "dev",
                "main.py",
              },
            },
            {
              type = "python",
              request = "launch",
              name = "FastAPI module",
              module = "uvicorn",
              args = {
                "main:app",
                "--use-colors",
                -- "--reload", -- doesn't work
              },
              pythonPath = "python",
              console = "integratedTerminal",
            },
          }
          require("mason-nvim-dap").default_setup(config) -- don't forget this!
        end,
      }
    end,
  },
}
