local NeoCodeium = {
  static = {
    symbols = {
      status = {
        [0] = "󰚩", -- Enabled
        [1] = "󱚧", -- Disabled Globally
        [2] = "󱙻", -- Disabled for Buffer
        [3] = "󱙺", -- Disabled for Buffer filetype
        [4] = "󱙺", -- Disabled for Buffer with enabled function
        [5] = "󱚠", -- Disabled for Buffer encoding
      },
      server_status = {
        [0] = "󰣺", -- Connected
        [1] = "󰣻", -- Connecting
        [2] = "󰣽", -- Disconnected
      },
    },
  },
  update = {
    "User",
    pattern = { "NeoCodeiumServer*", "NeoCodeium*{En,Dis}abled" },
    callback = function() vim.cmd.redrawstatus() end,
  },
  on_click = {
    callback = function()
      -- Safely execute the NeoCodeium chat command
      local success, result = pcall(function() vim.cmd "NeoCodeium chat" end)
      if not success then print("Failed to execute NeoCodeium chat: " .. result) end
      return success
    end,
    name = "chat",
  },
  provider = function(self)
    local symbols = self.symbols
    local status, server_status = require("neocodeium").get_status()
    local separator = " |" -- you can customize this separator (space, pipe, etc.)
    return symbols.status[status] .. separator .. symbols.server_status[server_status]
  end,
  hl = { fg = "virtual_env_fg" },
}
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      -- add new user interface icon
      icons = {
        VimIcon = "",
        ScrollText = "",
        -- GitBranch = "",
        GitBranch = " ",
        GitAdd = "",
        GitChange = "",
        GitDelete = "",
        FolderClosed = "",
        FolderOpened = "",
        Codeium = "󰭻", -- define a UI icon for Codeium
      },
      -- modify variables used by heirline but not defined in the setup call directly
      status = {
        -- define the separators between each section
        separators = {
          -- left = { "", "" }, -- separator for the left side of the statusline
          left = { "", " " }, -- separator for the left side of the statusline
          right = { " ", "" }, -- separator for the right side of the statusline
          center = { "  ", "  " },
          -- left_for_scroll = { "", "" },
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
          hl.git_branch_bg = get_hlgroup("Normal").bg
          hl.lsp_fg = comment_fg
          hl.virtual_env_fg = get_hlgroup("DiagnosticHint").fg
          -- TO HIDE BG OF LSP
          hl.lsp_bg = get_hlgroup("Normal").bg
          hl.git_added = get_hlgroup("String").fg
          -- hl.git_changed = get_hlgroup("E").fg
          hl.git_removed = get_hlgroup("Error").fg
          hl.blank_bg = get_hlgroup("Folded").fg
          hl.file_info_bg = get_hlgroup("Folded").bg
          -- hl.file_info_bg = get_hlgroup("Visual").bg
          hl.file_info_fg = comment_fg
          hl.nav_icon_bg = get_hlgroup("String").fg
          hl.nav_fg = hl.nav_icon_bg
          hl.folder_icon_bg = get_hlgroup("Error").fg
          hl.diagnostics_bg = get_hlgroup("Normal").bg

          -- hl.diagnostics_bg = get_hlgroup("String").bg
          return hl
        end,
        attributes = {
          mode = { bold = true },
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
    dependencies = { "abeldekat/harpoonline" },
    opts = function(_, opts)
      local status = require "astroui.status"
      local Harpoonline = require "harpoonline"
      -- local WordCount = status.component.builder {
      --   provider = function() return tostring(vim.fn.wordcount().words) .. " words " end,
      -- }
      --
      Harpoonline.setup {
        on_update = function() vim.cmd.redrawstatus() end,
      }

      local HarpoonComponent = status.component.builder {
        {
          provider = function()
            if Harpoonline.is_buffer_harpooned() then
              return "  " .. Harpoonline.format() .. " "
            else
              return " "
            end
          end,
          hl = function()
            -- if Harpoonline.is_buffer_harpooned() then return { fg = "git_changed" } end
            if Harpoonline.is_buffer_harpooned() then
              return {
                fg = "virtual_env_fg",
                -- bg = "tabline_bg",
              }
            end
          end,
        },
      }

      -- opts.tabline = nil
      -- opts.winbar = nil

      -- }
      -- opts.winboar = status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } }

      -- opts.winbar = {
      -- hl = {
      --   bg = "tabline_bg",
      -- },

      opts.statusline = {
        -- default highlight for the entire statusline
        hl = {
          fg = "fg",--[[  bg = "bg"  ]]
        },
        -- each element following is a component in astroui.status module

        -- add the vim mode component

        status.component.mode {
          -- enable mode text with padding as well as an icon before it
          mode_text = {
            icon = { kind = "VimIcon", padding = { right = 1, left = 0 } },
            -- padding = { right = 0, left = 0 },
          },
          -- surround the component with a separators
          surround = {
            -- it's a left element, so use the left separator
            separator = "tabs",
            -- set the color of the surrounding based on the current mode using astronvim.utils.status module
            color = function() return { main = status.hl.mode_bg(), right = "file_info_bg" } end,
          },
        },
        -- we want an empty space here so we can use the component builder to make a new section with just an empty string
        -- status.component.builder {
        --   { provider = "" },
        --   -- define the surrounding separator and colors to be used inside of the component
        --   -- and the color to the right of the separated out section
        --   surround = {
        --     separator = "left",
        --     color = { main = "blank_bg", right = "file_info_bg" },
        --   },
        -- },
        -- add a section for the currently opened file information
        --    -- add a section for the currently opened file information
        status.component.file_info {
          -- enable the file_icon and disable the highlighting based on filetype
          filename = {--[[  fallback = "Empty"  ]]
            modify = ":.",
          },
          file_icon = { padding = { left = 1 } },
          -- disable some of the info
          filetype = false,
          file_read_only = false,
          -- add padding
          padding = { right = 1 },
          -- define the section separator
          surround = { separator = "left", condition = false },
        },
        -- add a component for the current git branch if it exists and use no separator for the sections
        status.component.git_branch {
          surround = { separator = "none", color = "git_branch_bg" },
          git_branch = { icon = { kind = "GitBranch" } },
        },
        -- add a component for the current git diff if it exists and use no separator for the sections
        status.component.git_diff {
          padding = { left = 0 },
          surround = { separator = "none", color = "git_branch_bg" },
          added = { icon = { kind = "GitAdd", padding = { left = 1, right = 1 } } },
          changed = { icon = { kind = "GitChange", padding = { left = 1, right = 1 } } },
          removed = { icon = { kind = "GitDelete", padding = { left = 1, right = 1 } } },
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
        HarpoonComponent,

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
        NeoCodeium,
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
          surround = { separator = "none", color = { main = "git_branch_bg" } },
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
            hl = { fg = "bg" },
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
            hl = { fg = "bg" },
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
