-- ============================================================================
-- Modern Neovim Configuration
-- ============================================================================
-- Inspired by kickstart.nvim: A single-file config with extensive comments
-- that teaches you how Neovim works while providing a fully-featured IDE.
--
-- This config uses lazy.nvim for plugin management and follows a declarative
-- plugin specification pattern. All plugins are configured inline with
-- comments explaining their purpose.

-- ============================================================================
-- Bootstrap lazy.nvim Plugin Manager
-- ============================================================================
-- Auto-install lazy.nvim if not present. This ensures the config works
-- on first run without manual plugin installation.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Leader Keys
-- ============================================================================
-- CRITICAL: Set leader keys BEFORE lazy.setup() or plugin keybindings will
-- use the wrong leader. Space is a comfortable leader key for thumb access.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Core Editor Settings
-- ============================================================================
-- These settings establish the baseline editor behavior before any plugins
-- are loaded. Each setting is explained inline.

-- [[ Line Numbers ]]
vim.opt.number = true -- Show absolute line number on current line
vim.opt.relativenumber = true -- Show relative line numbers for easy jumps (5j, 10k)

-- [[ Interface ]]
vim.opt.mouse = "a" -- Enable mouse in all modes (useful for scrolling/clicking)
vim.opt.showmode = false -- Don't show mode in command line (lualine shows it)
vim.opt.signcolumn = "yes" -- Always show sign column for git signs and diagnostics
vim.opt.cursorline = true -- Highlight the current line for easy orientation

-- [[ Clipboard ]]
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all yank/put operations

-- [[ Text Display ]]
vim.opt.breakindent = true -- Wrapped lines respect indentation level
vim.opt.scrolloff = 10 -- Keep 10 lines visible above/below cursor when scrolling

-- [[ Persistence ]]
vim.opt.undofile = true -- Save undo history to file for persistence across sessions

-- [[ Search ]]
vim.opt.ignorecase = true -- Case-insensitive search by default
vim.opt.smartcase = true -- Override ignorecase if search contains uppercase

-- [[ Timing ]]
vim.opt.updatetime = 250 -- Faster CursorHold events (affects git signs, diagnostics)
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence completion (affects which-key)

-- [[ Splits ]]
vim.opt.splitright = true -- Open vertical splits to the right (natural reading order)
vim.opt.splitbelow = true -- Open horizontal splits below (natural reading order)

-- [[ Colors ]]
vim.opt.termguicolors = true -- Enable 24-bit RGB colors (REQUIRED for Catppuccin and bufferline)

-- [[ Indentation ]]
vim.opt.tabstop = 2 -- Display tabs as 2 spaces
vim.opt.shiftwidth = 2 -- Indent by 2 spaces when using >>, <<, ==
vim.opt.expandtab = true -- Insert spaces instead of tab character

-- ============================================================================
-- Diagnostic Configuration
-- ============================================================================
-- Configure how LSP diagnostics are displayed. Per user decision: inline
-- virtual text at the end of lines, always visible, with distinguishing icon.
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Icon prefix for diagnostic messages
    source = "if_many", -- Show source name only if multiple sources
  },
  signs = true, -- Show signs in the gutter
  underline = true, -- Underline diagnostic ranges
  update_in_insert = false, -- Don't update diagnostics while typing
  severity_sort = true, -- Sort diagnostics by severity (errors first)
})

-- ============================================================================
-- Basic Keybindings
-- ============================================================================
-- These are vim-native keybindings that don't depend on any plugins.
-- Plugin-specific keybindings are defined in their config functions below.

-- Clear search highlight on pressing Escape in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation with Ctrl+hjkl (faster than <C-w>h, <C-w>j, etc.)
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Focus lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Focus upper window" })

-- Better indenting in visual mode (stay in visual mode after indent)
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ============================================================================
-- Plugin Specifications
-- ============================================================================
-- All plugins are defined in the lazy.setup() call below. Each plugin spec
-- includes inline configuration and comments explaining its purpose.

require("lazy").setup({
  -- ==========================================================================
  -- Colorscheme: Catppuccin Mocha
  -- ==========================================================================
  -- Warm pastel colorscheme with comprehensive plugin integrations.
  -- Priority 1000 ensures it loads before other plugins that depend on colors.
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load before other plugins
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Warm dark theme (latte, frappe, macchiato, mocha)
        integrations = {
          -- Enable Catppuccin colors for all major plugins used in this config
          cmp = true, -- nvim-cmp completion menu
          gitsigns = true, -- Git diff signs in gutter
          neotree = true, -- Neo-tree file explorer
          treesitter = true, -- Treesitter syntax highlighting
          telescope = { enabled = true }, -- Telescope fuzzy finder
          which_key = true, -- Which-key keybinding hints
          indent_blankline = { enabled = true }, -- Indent guides
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          mini = { enabled = true }, -- mini.nvim modules (pairs, surround)
        },
      })
      -- Apply the colorscheme after setup completes
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ==========================================================================
  -- Syntax Highlighting: Treesitter
  -- ==========================================================================
  -- AST-based syntax highlighting with language-specific parsers.
  -- IMPORTANT: lazy = false because Treesitter does not support lazy-loading.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Auto-update parsers after install
    lazy = false, -- CRITICAL: Treesitter does not support lazy-loading
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup()

      -- Install parsers for these languages
      ts.install({
        "typescript", -- TypeScript language
        "javascript", -- JavaScript language
        "tsx", -- TypeScript React (JSX)
        "lua", -- Lua (for Neovim config)
        "json", -- JSON configuration files
        "yaml", -- YAML configuration files
        "bash", -- Shell scripts
        "markdown", -- Markdown documentation
        "markdown_inline", -- Inline markdown code
        "html", -- HTML files
        "css", -- CSS stylesheets
        "vim", -- Vim script
        "vimdoc", -- Vim help files
      })

      -- Enable Treesitter-based highlighting and indentation via FileType autocmd
      local languages = {
        "typescript", "javascript", "typescriptreact", "javascriptreact",
        "lua", "json", "yaml", "bash", "sh",
        "markdown", "html", "css", "vim", "help",
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- ==========================================================================
  -- Completion Engine: nvim-cmp
  -- ==========================================================================
  -- Auto-completion framework with LSP, buffer, path, and snippet sources.
  -- CRITICAL: This must be defined BEFORE typescript-tools so that we can
  -- pass cmp_nvim_lsp.default_capabilities() to the LSP server.
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- Lazy-load when entering insert mode
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completion source
      "hrsh7th/cmp-buffer", -- Buffer word completion source
      "hrsh7th/cmp-path", -- File path completion source
      "L3MON4D3/LuaSnip", -- Snippet engine (required for LSP snippets)
      "saadparwaiz1/cmp_luasnip", -- LuaSnip completion source
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        -- Snippet engine integration: Use LuaSnip to expand LSP snippets
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- Auto-popup completion menu as user types, pre-select first item
        completion = { completeopt = "menu,menuone,noinsert" },
        -- Keybindings for completion menu navigation and selection
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(), -- Next item (Ctrl+n)
          ["<C-p>"] = cmp.mapping.select_prev_item(), -- Previous item (Ctrl+p)
          ["<C-d>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
          ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll docs down
          ["<Tab>"] = cmp.mapping.select_next_item(), -- Tab to next item (VSCode-like)
          ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Shift+Tab to previous item
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter to confirm selection
          ["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger completion
        }),
        -- Completion sources in priority order: LSP first, then snippets, then buffer/path
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP completion (highest priority)
          { name = "luasnip" }, -- Snippet completions
        }, {
          { name = "buffer" }, -- Words from current buffer (fallback)
          { name = "path" }, -- File path completions (fallback)
        }),
      })
    end,
  },

  -- ==========================================================================
  -- TypeScript Language Server: typescript-tools.nvim
  -- ==========================================================================
  -- Full-featured TypeScript LSP with auto-imports, format on save, and
  -- vim-native keybindings (gd, K, gr, ]d, [d) plus leader-prefixed LSP actions.
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      -- CRITICAL: Wire up nvim-cmp capabilities to enable LSP-powered completion
      -- This allows the LSP server to provide completion candidates to nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      require("typescript-tools").setup({
        capabilities = capabilities, -- Pass cmp capabilities to LSP server
        -- on_attach: Called when LSP attaches to a buffer, sets up keybindings and autocmds
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr }

          -- Vim-native LSP keybindings (no leader prefix)
          -- These follow Neovim's built-in conventions for discoverability
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))

          -- Leader-prefixed LSP actions (namespaced under <leader>l for "LSP")
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "[L]SP [R]ename" }))
          vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "[L]SP Code [A]ction" }))
          vim.keymap.set("n", "<leader>ld", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "[L]SP Type [D]efinition" }))

          -- Auto-format on save: Keep code style consistent without manual intervention
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
        -- TypeScript server preferences and features
        settings = {
          -- Expose common refactorings as code actions (accessible via <leader>la)
          expose_as_code_action = {
            "add_missing_imports", -- Auto-import missing symbols
            "organize_imports", -- Sort and remove unused imports
            "remove_unused", -- Remove unused variables
          },
          -- TypeScript compiler preferences for better completions
          tsserver_file_preferences = {
            includeCompletionsForModuleExports = true, -- Suggest exports from other modules
            quotePreference = "auto", -- Match existing quote style in file
          },
          complete_function_calls = true, -- Auto-add parentheses after function completion
        },
      })
    end,
  },

  -- ==========================================================================
  -- Fuzzy Finder: Telescope
  -- ==========================================================================
  -- Powerful fuzzy finder with live preview, file search, grep, LSP integration.
  -- Layout: horizontal with top prompt, 50% preview width, 87% screen coverage.
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make", -- Compile native FZF for faster sorting
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          -- Horizontal layout: prompt at top, results left, preview right
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top", -- Prompt at top (natural reading flow)
              preview_width = 0.5, -- 50% width for preview pane
            },
            width = 0.87, -- 87% of screen width
            height = 0.80, -- 80% of screen height
          },
          sorting_strategy = "ascending", -- Results flow down from prompt
          mappings = {
            i = {
              -- Insert mode: Ctrl+j/k for navigation (vim-native)
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })

      -- Load FZF native extension for faster sorting and matching
      telescope.load_extension("fzf")

      -- Keybindings: leader-prefixed search commands
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume (last picker)" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch recent files" })

      -- LSP integration: search symbols in current file and workspace
      vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "[L]SP Document [S]ymbols" })
      vim.keymap.set("n", "<leader>lw", builtin.lsp_dynamic_workspace_symbols, { desc = "[L]SP [W]orkspace Symbols" })

      -- VSCode-familiar keybindings for users transitioning from VSCode
      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files (VSCode-style)" })
      vim.keymap.set("n", "<C-S-f>", builtin.live_grep, { desc = "Live grep (VSCode-style)" })
    end,
  },

  -- ==========================================================================
  -- File Explorer: neo-tree
  -- ==========================================================================
  -- Visual file tree sidebar with git status, icons, and folder navigation.
  -- Position: left sidebar, 30 chars wide, toggle with <leader>e.
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- File icons (requires Nerd Font)
      "MunifTanjim/nui.nvim", -- UI component library
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true, -- Auto-close if neo-tree is last window
        enable_git_status = true, -- Show git status indicators (modified, staged, etc.)
        enable_diagnostics = true, -- Show LSP diagnostics in tree
        window = {
          position = "left", -- Left sidebar position
          width = 30, -- 30 characters wide (compact but readable)
        },
        filesystem = {
          -- Auto-reveal current file when opening neo-tree
          follow_current_file = { enabled = true },
          -- Watch filesystem for external changes (file added/deleted outside Neovim)
          use_libuv_file_watcher = true,
          filtered_items = {
            visible = false, -- Don't show hidden files by default
            hide_dotfiles = false, -- But DO show dotfiles (config files are important)
            hide_gitignored = true, -- Hide gitignored files (node_modules, dist, etc.)
          },
        },
        default_component_configs = {
          git_status = {
            -- Git status symbols (compact single-character indicators)
            symbols = {
              added = "+", -- New file
              modified = "~", -- Modified file
              deleted = "x", -- Deleted file
              renamed = "r", -- Renamed file
              untracked = "?", -- Untracked file
              ignored = "i", -- Gitignored file
              unstaged = "u", -- Unstaged changes
              staged = "s", -- Staged changes
              conflict = "!", -- Merge conflict
            },
          },
        },
      })

      -- Keybindings: leader+e to toggle, leader+fe to reveal current file
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file [E]xplorer" })
      vim.keymap.set("n", "<leader>fe", "<cmd>Neotree reveal<cr>", { desc = "[F]ile [E]xplorer (reveal current)" })
    end,
  },

  -- ==========================================================================
  -- Statusline: lualine
  -- ==========================================================================
  -- Information-dense statusline showing mode, git branch, diagnostics count,
  -- file encoding, line/col, LSP status, and filetype. Uses Catppuccin theme
  -- for consistent visual integration. globalstatus makes one statusline
  -- for all windows instead of per-window statuslines.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin", -- Match Catppuccin Mocha colorscheme
          component_separators = { left = "|", right = "|" }, -- Simple separators
          section_separators = { left = "", right = "" }, -- No fancy powerline separators
          globalstatus = true, -- One statusline for entire editor (cleaner look)
        },
        sections = {
          lualine_a = { "mode" }, -- Left: current mode (NORMAL, INSERT, VISUAL)
          lualine_b = { "branch", "diff", "diagnostics" }, -- Git info and diagnostics count
          lualine_c = { { "filename", path = 1 } }, -- Relative path to current file
          lualine_x = { "encoding", "fileformat", "filetype" }, -- File metadata
          lualine_y = { "progress" }, -- Percentage through file
          lualine_z = { "location" }, -- Right: line:column number
        },
      })
    end,
  },

  -- ==========================================================================
  -- Buffer Tabs: bufferline
  -- ==========================================================================
  -- Visual buffer tabs at top of editor showing all open buffers with
  -- LSP diagnostics indicators, file icons, and Catppuccin integration.
  -- Shift+H/L to cycle buffers, leader+bp to pin, leader+bc to close.
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- Show buffers (not tabs)
          diagnostics = "nvim_lsp", -- Show LSP diagnostics in buffer tabs
          -- Custom diagnostic indicator: show icon and count for errors/warnings
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          -- Offset bufferline when neo-tree is open (prevent overlap)
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
          show_buffer_close_icons = false, -- No close icons (use :bd instead)
          show_close_icon = false, -- No global close icon
          separator_style = "thin", -- Thin separator lines between buffers
        },
        -- Apply Catppuccin colors to bufferline for consistent theme
        highlights = require("catppuccin.special.bufferline").get_theme(),
      })

      -- Keybindings: Shift+H/L to cycle buffers (like tabs in VSCode)
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
      -- Leader+b namespace for buffer operations
      vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "[B]uffer [P]in toggle" })
      vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "[B]uffer [C]lose" })
    end,
  },

  -- ==========================================================================
  -- Git Integration: gitsigns
  -- ==========================================================================
  -- Git diff signs in the gutter showing added/modified/deleted lines.
  -- Hunk navigation with ]c/[c, stage/reset hunks, preview, blame.
  -- All git actions namespaced under <leader>g for "Git".
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        -- Git status signs in the gutter (sign column)
        signs = {
          add = { text = "+" }, -- New line added
          change = { text = "~" }, -- Line modified
          delete = { text = "_" }, -- Line deleted
          topdelete = { text = "‾" }, -- Top line of deleted block
          changedelete = { text = "~" }, -- Line changed then deleted
        },
        -- on_attach: Called when gitsigns attaches to a git-tracked buffer
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          -- Hunk navigation: ]c to next hunk, [c to previous hunk (follows vim convention)
          map("n", "]c", gs.next_hunk, "Next git hunk")
          map("n", "[c", gs.prev_hunk, "Previous git hunk")

          -- Leader+g namespace for git operations
          map("n", "<leader>gs", gs.stage_hunk, "[G]it [S]tage hunk")
          map("n", "<leader>gr", gs.reset_hunk, "[G]it [R]eset hunk")
          map("n", "<leader>gS", gs.stage_buffer, "[G]it [S]tage buffer")
          map("n", "<leader>gu", gs.undo_stage_hunk, "[G]it [U]ndo stage hunk")
          map("n", "<leader>gp", gs.preview_hunk, "[G]it [P]review hunk")
          map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "[G]it [B]lame line")
          map("n", "<leader>gd", gs.diffthis, "[G]it [D]iff this")
        end,
      })
    end,
  },

  -- ==========================================================================
  -- Keybinding Hints: which-key
  -- ==========================================================================
  -- Displays a popup with available keybindings when you press leader and wait.
  -- Groups are organized by action type: Search, Git, LSP, Buffer, File.
  -- 300ms delay before popup appears (configured via timeoutlen in core settings).
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Lazy-load after startup
    config = function()
      local wk = require("which-key")
      wk.setup({
        delay = 300, -- Delay before popup appears (matches timeoutlen)
      })

      -- Register keybinding groups with descriptive names
      -- These organize the which-key popup into logical sections
      wk.add({
        { "<leader>s", group = "Search" }, -- Telescope search commands
        { "<leader>g", group = "Git" }, -- Git operations (gitsigns)
        { "<leader>l", group = "LSP" }, -- LSP actions (rename, code action, etc.)
        { "<leader>b", group = "Buffer" }, -- Buffer management (pin, close)
        { "<leader>f", group = "File" }, -- File operations (neo-tree)
      })
    end,
  },

  -- ==========================================================================
  -- Auto-Closing Pairs: mini.pairs
  -- ==========================================================================
  -- Automatically close brackets, quotes, and parentheses when typing.
  -- Example: typing `(` auto-inserts `)` and positions cursor between them.
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter", -- Lazy-load when entering insert mode
    config = function()
      require("mini.pairs").setup()
    end,
  },

  -- ==========================================================================
  -- Surround Operations: mini.surround
  -- ==========================================================================
  -- Add/delete/replace surrounding characters (quotes, brackets, tags).
  -- Default mappings: sa (add), sd (delete), sr (replace)
  -- Example: sa2w" surrounds 2 words with quotes
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup()
    end,
  },

  -- ==========================================================================
  -- Comment Toggling: Comment.nvim
  -- ==========================================================================
  -- Toggle comments with gcc (line) and gc (visual selection).
  -- Language-aware: Uses // for JS/TS, -- for Lua, # for Python, etc.
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },

  -- ==========================================================================
  -- Indent Guides: indent-blankline.nvim
  -- ==========================================================================
  -- Visual indent guide lines showing scope levels.
  -- Helps navigate nested code structures (especially in Python, YAML, JSX).
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    config = function()
      require("ibl").setup({
        indent = { char = "│" }, -- Vertical line character for indent guides
        scope = {
          enabled = true, -- Highlight current scope (function, block, etc.)
          show_start = true, -- Show start of scope
          show_end = false, -- Don't show end of scope (reduces visual noise)
        },
      })
    end,
  },

  -- ==========================================================================
  -- Fast Escape: better-escape.nvim
  -- ==========================================================================
  -- Fast jj/jk escape from insert mode without timeout lag.
  -- No more waiting after typing 'j' in insert mode.
  -- 150ms timeout for the second keystroke (fast enough for typing speed).
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        timeout = 150, -- 150ms timeout for jj/jk sequence
        default_mappings = true, -- Enable default jj and jk mappings
      })
    end,
  },
})

-- ============================================================================
-- Additional Configuration
-- ============================================================================

-- Highlight on yank (built-in Neovim feature)
-- Briefly flash the yanked text to provide visual feedback
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ============================================================================
-- End of Configuration
-- ============================================================================
