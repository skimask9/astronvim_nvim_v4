-- local NeoCodeium = {
--   static = {
--     symbols = {
--       status = {
--         [0] = "󰚩", -- Enabled
--         [1] = "󱚧", -- Disabled Globally
--         [2] = "󱙻", -- Disabled for Buffer
--         [3] = "󱙺", -- Disabled for Buffer filetype
--         [4] = "󱙺", -- Disabled for Buffer with enabled function
--         [5] = "󱚠", -- Disabled for Buffer encoding
--       },
--       server_status = {
--         [0] = "󰣺", -- Connected
--         [1] = "󰣻", -- Connecting
--         [2] = "󰣽", -- Disconnected
--       },
--     },
--   },
--   update = {
--     "User",
--     pattern = { "NeoCodeiumServer*", "NeoCodeium*{En,Dis}abled" },
--     callback = function() vim.cmd.redrawstatus() end,
--   },
--   on_click = {
--     callback = function()
--       -- Safely execute the NeoCodeium chat command
--       local success, result = pcall(function() vim.cmd "NeoCodeium chat" end)
--       if not success then print("Failed to execute NeoCodeium chat: " .. result) end
--       return success
--     end,
--     name = "chat",
--   },
--   provider = function(self)
--     local symbols = self.symbols
--     local status, server_status = require("neocodeium").get_status()
--     local separator = " |" -- you can customize this separator (space, pipe, etc.)
--     return symbols.status[status] .. separator .. symbols.server_status[server_status]
--   end,
--   hl = { fg = "harpoon_fg" },
-- }
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      -- add new user interface icon
      icons = {
        VimIcon = "",
        ScrollText = "",
        GitBranch = "",
        GitDiff = "",
        -- GitBranch = " ",
        GitAdd = "",
        -- GitAdd = "",
        -- GitChange = "",
        -- GitChange = "",
        GitChange = "",
        GitDelete = "",
        -- GitDelete = "",
        FolderClosed = "",
        FolderOpened = "",
        Codeium = "󰭻", -- define a UI icon for Codeium
      },
      -- modify variables used by heirline but not defined in the setup call directly
      status = {
        -- define the separators between each section
        separators = {
          left_test = { "", "" }, -- separator for the left side of the statusline
          left = { "", "" }, -- separator for the left side of the statusline
          right = { "", "" }, -- separator for the right side of the statusline
          center = { "  ", "  " },
          -- tab = { "", "" },
          -- tab = { "", "" },
          tab = { "", "" },
          tabs = { "", "" },
          breadcrumbs = "  ",
          path = "  ",
        },
        -- add new colors that can be used by heirline
        colors = function(hl)
          local get_hlgroup = require("astroui").get_hlgroup
          -- use helper function to get highlight group properties
          local comment_fg = get_hlgroup("Comment").bg
          hl.git_branch_fg = comment_fg
          -- hl.git_branch_bg = get_hlgroup("Visual").bg
          -- TO HIDE BACKGROUND OF GIT
          -- hl.git_branch_bg = get_hlgroup("Normal").bg
          -- WITHOUT FILE INFO
          hl.git_branch_bg = get_hlgroup("Folded").bg
          hl.venv_bg = get_hlgroup("Normal").bg
          hl.lsp_fg = comment_fg
          hl.harpoon_fg = get_hlgroup("DiagnosticHint").fg
          -- green
          hl.virtual_env_fg = get_hlgroup("String").fg
          hl.codium_fg = get_hlgroup("GitSignsChange").fg
          -- TO HIDE BG OF LSP
          hl.lsp_bg = get_hlgroup("Normal").bg
          hl.git_added = get_hlgroup("String").fg
          -- hl.git_changed = get_hlgroup("E").fg
          hl.git_removed = get_hlgroup("GitSignsDelete").fg
          hl.git_diff = get_hlgroup("Folded").bg
          hl.blank_bg = get_hlgroup("Folded").fg
          hl.none_text = get_hlgroup("NonText").fg
          hl.file_info_bg = get_hlgroup("Folded").bg
          -- for default astro theme
          -- hl.file_info_bg = get_hlgroup("Folded").fg
          hl.git_diff_bg = get_hlgroup("Visual").bg
          hl.file_info_fg = comment_fg
          hl.nav_icon_bg = get_hlgroup("String").fg
          hl.nav_fg = hl.nav_icon_bg
          hl.folder_icon_bg = get_hlgroup("Error").fg
          hl.diagnostics_bg = get_hlgroup("Normal").bg
          hl.test_fg = get_hlgroup("Normal").fg

          -- hl.diagnostics_bg = get_hlgroup("String").bg
          return hl
        end,
        attributes = {
          -- mode = { bold = true },
          lsp = { italic = true },
          buffer_active = { bold = true, italic = true },
          buffer_picker = { bold = true },
          macro_recording = { bold = true },
          git_branch = { italic = true },
          git_diff = {},
          mode_text = { bold = true },
        },
        icon_highlights = {
          file_icon = {
            statusline = true,
            winbar = true,
          },
        },
      },
    },
  },
  {
    "rebelot/heirline.nvim",
    -- dependencies = { "abeldekat/harpoonline" },
    opts = function(_, opts)
      local status = require "astroui.status"
      local conditions = require "heirline.conditions"
      -- local WordCount = status.component.builder {
      --   provider = function() return tostring(vim.fn.wordcount().words) .. " words " end,
      -- }
      --
      -- local GrappleComponent = status.component.builder {
      --   provider = function()
      --     local available, grapple = pcall(require, "grapple")
      --     if available then return grapple.statusline() end
      --   end,
      --   hl = function()
      --     return {
      --       fg = "harpoon_fg",
      --     }
      --   end,
      -- }
      local GitBlameComponent = status.component.builder {
        {
          provider = function()
            local git_blame = require "gitblame"
            if git_blame.is_blame_text_available() then
              -- return " " .. git_blame.get_current_blame_text() .. " "
              return " " .. git_blame.get_current_blame_text()
            else
              return " "
            end
          end,
          hl = function()
            local git_blame = require "gitblame"
            if git_blame.is_blame_text_available() then
              return {
                fg = "none_text",
                -- fg = "test_fg",
              }
            end
          end,
        },
      }
      local DoingComponent = status.component.builder {
        {
          provider = function()
            local status_doing = require("doing").status()
            --   return " " .. status_doing .. " +" .. tostring(require("doing").tasks_left())
            -- end,
            if not conditions.width_percent_below(#status_doing, 0.3) then
              local max_len = vim.api.nvim_win_get_width(0) * 0.3
              status_doing = status_doing:sub(0, max_len) .. "..."
            end
            if status_doing then
              return " " .. status_doing
            else
              return " "
            end
          end,

          hl = function()
            local doing_api = require "doing"
            if doing_api.status() then
              return {
                fg = "none_text",
                italic = true,

                -- fg = "test_fg",
                -- bg = "tabline_bg", -- Uncommented for potential future use
              }
            end
          end,
        },
        update = { "BufEnter", "User", pattern = "TaskModified" },
      }
      opts.tabline = nil
      opts.winbar = nil

      -- }
      -- opts.winboar = status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } }

      -- opts.winbar = {
      -- hl = {
      --   bg = "tabline_bg",
      -- },

      opts.statusline = {
        -- default highlight for the entire statusline
        hl = {
          fg = "blank_bg",

          -- bg = "bg",
        },
        -- each element following is a component in astroui.status module

        -- add the vim mode component

        -- Mode component

        status.component.mode {

          mode_text = {
            icon = {
              kind = "VimIcon",
              padding = { right = 1, left = 0 },
            },
          },
          --
          surround = {

            separator = "tabs",
            -- separator = "left",
            -- separator = "right",
            -- color = function()
            --   return {
            --     main = status.hl.mode_bg(),
            --     right = "file_info_bg",
            --     -- right = "git_branch_bg",
            --   }
            -- end,
            -- color = function()
            --   local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match "^true" ~= nil
            --
            --   return {
            --     main = status.hl.mode_bg(),
            --     right = is_git_repo and vim.fn.system "git status --porcelain" ~= "" and "file_info_bg" or nil,
            --   }
            -- end,
            color = function()
              local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match "^true" ~= nil
              return {
                main = status.hl.mode_bg(),
                right = is_git_repo and "file_info_bg", -- Adds right separator for Git repos
                -- Keeps the existing conditional logic for checking uncommitted changes
              }
            end,
            -- color = function()

            --   local is_git_repo = conditions.is_git_repo()
            --
            --   return {
            --     main = status.hl.mode_bg(),
            --     right = is_git_repo and "file_info_bg" or nil,
            --     tabs = "file_info_bg",
            --   }
            -- end,
            -- color = function()
            --               if conditions.is_git_repo() then
            --     vim.cmd.redrawstatus()
            --     return {
            --       main = status.hl.mode_bg(),
            --       right = "file_info_bg", -- Only show right separator for Git
            --     }
            --   else
            --     return {
            --       main = status.hl.mode_bg(),
            --       right = nil,
            --     }
            --   end
            -- end,

            -- padding = { left = 1, right = 1 }, -- Control padding explicitly
          },
          -- padding = { left = 0, right = 1 }, -- Control padding explicitly
          hl = function()
            if vim.o.background == "light" then return { fg = "blank_bg" } end
            return { fg = "bg" }
          end,
        },
        -- status.component.builder {
        --   { provider = "" },
        --   -- define the surrounding separator and colors to be used inside of the component
        --   -- and the color to the right of the separated out section
        --   surround = {
        --     separator = "tabs",
        --     color = function()
        --       return {
        --         main = "file_info_bg",
        --         right = "file_info_bg",
        --         -- right = "git_branch_bg",
        --       }
        --     end,
        --   },
        --   padding = { left = 0, right = 0 },
        -- },
        {
          condition = conditions.is_git_repo,
          init = function(self) self.has_git = vim.b.gitsigns_status_dict ~= nil end,
          status.component.builder {
            { provider = "" },
            -- define the surrounding separator and colors to be used inside of the component
            -- and the color to the right of the separated out section
            surround = {
              separator = "left_test",
              color = {
                main = "file_info_bg",
                left = "file_info_bg",
                right = "file_info_bg",
              },
            },
          },
          {
            status.component.git_branch {
              surround = {
                -- separator = "none",

                separator = "left",
                -- color = {
                -- main = "file_info_bg",
                --   -- right = "venv_bg",
                -- right = "git_diff_bg",
                -- left = "git_diff_bg",
                -- },
                color = function()
                  local stats = vim.b.gitsigns_status_dict or { added = 0, removed = 0, changed = 0 }
                  local has_changes = stats.added ~= 0 or stats.removed ~= 0 or stats.changed ~= 0
                  if has_changes then
                    return {
                      main = "file_info_bg",
                      right = "git_diff_bg",
                      -- right = "file_info_bg",
                      left = "file_info_bg",
                    }
                  else
                    return {
                      main = "file_info_bg",
                      right = "git_diff_bg",
                      -- left = "file_info_bg",
                      -- tabs = "file_info_bg",
                    }
                  end
                end,
                padding = { left = 0, right = 0 }, -- Control padding
              },
              -- hl = { bg = "venv_bg" },
              padding = { left = 0, right = 0 }, -- Control padding
              git_branch = {
                icon = {
                  kind = "GitBranch",
                  padding = { left = 0, right = 1 }, -- Explicit padding for icon
                },
              },
            },
          },
          -- status.component.builder {
          --   { provider = "" },
          --   -- define the surrounding separator and colors to be used inside of the component
          --   -- and the color to the right of the separated out section
          --   surround = {
          --     separator = "left",
          --     color = {
          --       main = "file_info_bg",
          --       -- left = "file_info_bg",
          --       -- right = "git_diff_bg",
          --     },
          --   },
          -- },
        },
        -- status.component.builder {
        --   { provider = "" },
        --   -- define the surrounding separator and colors to be used inside of the component
        --   -- and the color to the right of the separated out section
        --   surround = {
        --     separator = "left",
        --     color = {
        --       left = "file_info_bg",
        --       -- right = "git_diff_bg",
        --       main = "file_info_bg",
        --     },
        --   },
        -- },
        {
          condition = function() return vim.b.gitsigns_status_dict ~= nil end,
          -- condition = conditions.is_git_repo,
          status.component.git_diff {

            surround = {
              separator = "none",
              -- separator = "left",
              padding = { left = 0, right = 0 }, -- Control padding
              -- color = "git_diff_bg",
              color = {
                main = "git_diff_bg",
                -- main = "file_info_bg",
                -- left = "git_diff_bg",
                -- right = "git_diff_bg",
              },
            },
            padding = { left = 0, right = 0 }, -- Control padding
            added = { icon = { kind = "GitAdd", padding = { left = 1, right = 1 } } },
            -- changed = { icon = { kind = "GitChange", padding = { left = 0, right = 1 } } },
            -- removed = { icon = { kind = "GitDelete", padding = { left = 1, right = 1 } } },
            -- removed = {
            --   hl = { fg = "git_removed" },
            --   icon = {
            --     kind = "GitDelete",
            --     padding = { left = 1, right = 1 }, -- Explicit padding for icon
            --   },
            -- },
          },
          status.component.builder {
            GitBlameComponent,
            { provider = "" },
            -- define the surrounding separator and colors to be used inside of the component
            -- and the color to the right of the separated out section
            padding = { left = 0, right = 0 },
            surround = {
              separator = "left",
              color = {
                left = "git_diff_bg",
                -- right = "git_diff_bg",
                main = "git_diff_bg",
              },
              padding = { left = 0, right = 0 },
            },
          },
        },

        -- status.component.breadcrumbs {
        --   icon = { hl = true },
        --   prefix = false,
        --   padding = { left = 0 },
        -- },
        -- status.component.breadcrumbs {
        --
        --   icon = { hl = true },
        --   hl = {
        --     bg = "none",
        --   },
        --   -- hl = status.hl.get_attributes("winbar", true),
        --   prefix = true,
        --   padding = { left = 0 },
        -- },

        -- the elements after this will appear in the middle of the statusline
        -- status.component.fill(),
        -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
        -- status.component.lsp {
        --   lsp_client_names = false,
        --   surround = { separator = "none", color = "bg" },
        -- },
        -- fill the rest of the statusline
        -- the elements after this will appear on the right of the statusline
        status.component.fill(),
        -- HarpoonComponent,
        -- GrappleComponent,
        DoingComponent,
        -- NeoCodeium,
        -- status.component.builder {
        --
        --   {
        --     provider = function(self) -- define a function that displays the status with an icon with padding
        --       return status.utils.stylize(self.codeium_status, {
        --         icon = { kind = "Codeium", padding = { right = 1 } }, -- add Codeium icon defined in AstroUI
        --         show_empty = true, -- allow empty status
        --       })
        --     end,
        --   },
        --   hl = {
        --     fg = "virtual_env_fg",
        --   },
        --
        --   on_click = {
        --     callback = function()
        --       -- Use pcall to safely call the Codeium chat function
        --       local result = pcall(vim.api.nvim_call_function, "codeium#Chat", {})
        --       return result
        --     end,
        --     name = "chat",
        --   },
        --   surround = {
        --     -- surround the component
        --     separator = "center",
        --     condition = function(self)
        --       local codeium_avail, codeium_status = pcall(vim.api.nvim_call_function, "codeium#GetStatusString", {})
        --       if codeium_avail then
        --         self.codeium_status = vim.trim(codeium_status)
        --         if self.codeium_status == "ON" then self.codeium_status = "" end -- don't display the "ON"
        --         return self.codeium_status ~= "OFF"
        --       end
        --     end,
        --   },
        -- },
        status.component.cmd_info(),
        status.component.fill(),

        -- add a component for the current diagnostics if it exists and use the right separator for the section
        status.component.diagnostics {
          padding = { right = 1 },
          surround = { separator = "none" },
          ERROR = { icon = { kind = "DiagnosticError", padding = { left = 1, right = 1 } } },
          WARN = { icon = { kind = "DiagnosticWarn", padding = { left = 1, right = 1 } } },
          INFO = { icon = { kind = "DiagnosticInfo", padding = { left = 1, right = 1 } } },
          HINT = { icon = { kind = "DiagnosticHint", padding = { left = 1, right = 1 } } },
        },
        -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
        status.component.lsp {
          lsp_progress = false,
          surround = { separator = "none" },
          padding = { right = 1 },
        },
        status.component.virtual_env {
          virtual_env = { icon = { kind = "Environment" }, env_names = {} },
          padding = { right = 1 },
          surround = { separator = "none", color = { main = "venv_bg" } },
          hl = { fg = "virtual_env_fg" },
        },
        -- WordCount,
        -- NvChad has some nice icons to go along with information, so we can create a parent component to do this
        -- all of the children of this table will be treated together as a single component
        {
          -- define a simple component where the provider is just a folder icon
          status.component.builder {
            -- astronvim.get_icon gets the user interface icon for a closed folder with a space after it
            { provider = require("astroui").get_icon "FolderOpened" },
            -- add padding after icon
            padding = { right = 1 },
            -- set the foreground color to be used for the icon
            -- hl = { fg = "blank_bg" },
            -- hl = { fg = "bg" },
            hl = function()
              if vim.o.background == "light" then return { fg = "blank_bg" } end
              return { fg = "bg" }
            end,
            -- use the right separator and define the background color
            surround = {
              separator = "tabs",
              color = function()
                return {
                  main = status.hl.mode_bg(),
                  right = "file_info_bg",
                }
              end,
            },
          },
          -- add a file information component and only show the current working directory name
          status.component.file_info {
            -- we only want filename to be used and we can change the fname
            -- function to get the current working directory name
            filename = {
              fname = function(nr) return vim.fn.getcwd(nr) end,
              padding = { left = 1, right = 1 },
            },
            -- disable all other elements of the file_info component
            filetype = false,
            file_icon = false,
            file_modified = false,
            file_read_only = false,
            -- use no separator for this part but define a background color
            surround = {
              separator = "none",
              -- color = "file_info_bg",
              condition = false,
            },
          },
        },
        -- the final component of the NvChad statusline is the navigation section
        -- this is very similar to the previous current working directory section with the icon
        { -- make nav section with icon border
          -- define a custom component with just a file icon
          status.component.builder {
            { provider = require("astroui").get_icon "ScrollText" },
            -- add padding after icon
            padding = { right = 1 },
            -- set the icon foreground
            -- hl = {
            --   -- fg = "blank_bg",
            --   fg = "bg",
            -- },
            hl = function()
              if vim.o.background == "light" then return { fg = "blank_bg" } end
              return { fg = "bg" }
            end,
            -- use the right separator and define the background color
            -- as well as the color to the left of the separator
            surround = {
              separator = "tabs",
              color = function() return { main = status.hl.mode_bg(), right = "file_info_bg", left = "file_info_bg" } end,
            },
          },

          -- add a navigation component and just display the percentage of progress in the file
          status.component.nav {
            -- add some padding for the percentage provider
            percentage = { padding = { right = 0, left = 0 } },
            -- disable all other providers
            ruler = false,
            scrollbar = false,
            -- use no separator and define the background color
            surround = { separator = "tabs", color = { left = "file_info_bg", main = "file_info_bg" } },
          },
        },
      }
    end,
  },
}
