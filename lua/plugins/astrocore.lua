-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
-- Function to toggle inlay hints

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 2, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      undercurl = true,
      virtual_text = true,
      -- underline = true,
    },
    autocmds = {
      -- lock terminal
      lock_terminal = {
        {
          event = "TermOpen",
          pattern = "*",
          callback = function() vim.wo.winfixbuf = true end,
          desc = "Lock terminal buffers to their windows",
        },
      }, -- Set filetype to htmldjango if 'manage.py' exists in the current working directory
      -- html_filetype_cmd = {
      --   cond = function()
      --     -- Check if the current working directory has a 'manage.py' file
      --     return vim.fn.glob(vim.fn.getcwd() .. "/manage.py") ~= ""
      --   end,
      --   {
      --     event = { "BufRead", "BufNewFile" },
      --     pattern = "*.html",
      --     callback = function() vim.bo.filetype = "htmldjango" end,
      --     desc = "Set filetype to htmldjango for HTML files in Django projects",
      --   },
      -- },
      -- e disable_auto_comment = {
      --   {
      --     event = "FileType",
      --     pattern = "*",
      --     callback = function()
      --       vim.opt.formatoptions:remove "c"
      --       vim.opt.formatoptions:remove "r"
      --       vim.opt.formatoptions:remove "o"
      --     end,
      --     desc = "Disable auto-commenting on new line",
      --   },
      -- },
      --   harpoon_auto_cmd = {
      --     cond = function()
      --       -- Check if Harpoon is available
      --       return pcall(require, "harpoon")
      --     end,
      --     {
      --       event = "VimEnter",
      --       desc = "Harpoon list and select",
      --       callback = function()
      --         -- Delay the execution using a timer
      --         vim.defer_fn(function() require("harpoon"):list():select(1) end, 150)
      --       end,
      --     },
      --   },
    },

    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        showtabline = 1, -- disable tabline
        number = true, -- sets vim.opt.number
        -- background = "light",
        spell = true, -- sets vim.opt.spell
        path = vim.opt.path + "**",
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        mousemoveevent = true,
        linebreak = true, -- linebreak soft wrap at words
        breakindent = true,
        list = true, -- show whitespace characters
        listchars = {
          tab = "|→",
          extends = "⟩",
          precedes = "⟨",
          trail = "·",
          nbsp = "␣",
          eol = "↵",
        },
        showbreak = "↪ ",
        wrap = true, -- sets vim.opt.wrap
        colorcolumn = "89",
        cmdheight = 0,
        pumblend = 0, -- for cmp menu
        winblend = 0, -- for documentation popup
        rnu = true,
        scrolloff = 10,
        -- clipboard = "unnamedplus",
        sidescrolloff = 8,
        -- guicursor = "n-v-c-sm-ve:block,i-ci:ver20,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- navigate buffer tabs with `H` and `L`
        L = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },

        -- second key is the lefthand side of the map

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
        ["<F1>"] = { ":w|!python3  %<cr>", desc = "Run python file" },
        ["<F3>"] = { ":w|!go run %<cr>", desc = "Run go file" },
        ["<TAB>"] = { "<cmd>:Telescope buffers<cr>", desc = "buffers" },
        ["<F2>"] = { ":ToggleTerm direction=horizontal<cr>", desc = "ToggleTerm" },
        [",m"] = { "<cmd>lua vim.cmd('%s/\\r//g')<cr>", desc = "Remove carriage return" },
        ["<leader>Go"] = { "<cmd>:GitBlameOpenFileURL<cr>", desc = "Open File in Github.com" },
        ["<leader>Gy"] = { "<cmd>:GitBlameCopyFileURL<cr>", desc = "To copy url link github" },
        ["<leader>Gt"] = { "<cmd>:GitBlameToggle<cr>", desc = "To toggle git blame" },
        -- ["<C-x>"] = { "<cmd>:Telescope buffers<cr>" },
        ["<leader>Mt"] = { "<cmd>:GithubPreviewToggle<cr>", desc = "Toggle GithubPreviewToggle" },
        ["<leader>fA"] = { "<cmd>:Telescope tmux windows<cr>", desc = "Tmux switcher" },
        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<leader>b"] = { name = "Buffers" },
        ["<leader>v"] = { name = "Venv" },
        ["<leader>G"] = { name = " Git links" },
        ["<leader>T"] = { name = " LazyClip" },
        ["<leader>D"] = { name = " Tasks" },
        ["<leader>M"] = { name = " MarkDown Preview" },
        -- quick save
        ["<c-c>"] = { '"+y', desc = "" },
        ["<c-v>"] = { '"+p', desc = "" },
        ["<S-Down>"] = { "<cmd>t.<cr>", desc = "" },
        ["<S-Up>"] = { "<cmd>t -1<cr>", desc = "" },
        -- ["<M-J>"] = { "<cmd>t.<cr>", desc = "" },
        -- ["<M-K>"] = { "<cmd>t -1<cr>", desc = "" },
        ["<M-Down>"] = { "<cmd>m+<cr>", desc = "" },
        ["<M-Up>"] = { "<cmd>m-2<cr>", desc = "" },
        -- ["<M-j>"] = { "<cmd>m+<cr>", desc = "" },
        -- ["<M-k>"] = { "<cmd>m-2<cr>", desc = "" },
        ["q"] = { "<cmd>q<cr>", desc = "" },
      },
      i = {
        ["<c-c>"] = { '"+y', desc = "" },
        ["<c-v>"] = { "<c-r>+", desc = "" },
        ["<S-Down>"] = { "<cmd>t.<cr>", desc = "" },
        ["<M-Down>"] = { "<cmd>m+<cr>", desc = "" },
        ["<S-Up>"] = { "<cmd>t -1<cr>", desc = "" },
        ["<M-Up>"] = { "<cmd>m-2<cr>", desc = "" },
        ["<C-s>"] = { "<cmd>w<cr>", desc = "" },
      },
      v = {
        ["p"] = { '"_dP', desc = "" },
        ["<c-c>"] = { '"+y', desc = "" },
        ["<c-v>"] = { '"+p', desc = "" },
        ["<A-Down>"] = { ":move '>+1<CR>gv-gv", desc = "" },
        ["<A-Up>"] = { ":move '<-2<CR>gv-gv", desc = "" },
        ["<S-Down>"] = { ":'<,'>t'><cr>", desc = "" },
      },

      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
        --       -- extra mappings for terminal navigaton
        ["<Leader><esc>"] = "<c-\\><c-n>",
        ["<Esc><esc>"] = "<c-\\><c-n>:ToggleTerm<CR>",
      },
    },
  },
}
