-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd     -- execute Vim commands
local exec = vim.api.nvim_exec       -- execute Vimscript
local autocmd = vim.api.nvim_create_autocmd
--local map = vim.api.nvim_set_keymap  -- set global keymap
local fn = vim.fn       -- call Vim functions
local g = vim.g         -- global variables
local o = vim.o         -- global options
local b = vim.bo        -- buffer-scoped options
local w = vim.wo        -- windows-scoped options

-----------------------------------------------------------
-- General
-----------------------------------------------------------
g.mapleader = ','           -- change leader to a comma
o.mouse = 'a'               -- enable mouse support
o.clipboard = 'unnamed'
g.wildignore = '*.swp,*.bak,*.pyc,*.class,*/tmp/*,*.so,*.zip,*.tar.gz,*.tar'
o.title = true              -- change the terminal's title
g.noerrorbells = true       -- don't beep
g.pastetoggle = '<F2>'
g.closetag_filenames = '*.html,*.xml'

-- Neovim UI
o.syntax = 'enable'         -- enable syntax highlighting
w.number = true             -- show line number
w.relativenumber = true     -- show relative line numbers
o.showmatch = true          -- highlight matching parenthesis
w.foldmethod = 'indent'     -- enable folding (default 'marker')
o.foldlevelstart = 99        -- set start level for folding
w.colorcolumn = '80'        -- line lenght marker at 80 columns
o.splitright = true         -- vertical split to the right
o.splitbelow = true         -- orizontal split to the bottom
o.ignorecase = true         -- ignore case letters when search
o.smartcase = true          -- ignore lowercase for the whole pattern
o.scrolloff = 15            -- keep active line in center
o.laststatus = 2            -- always show status line
o.diffopt = o.diffopt .. ',vertical'
o.shortmess = 'acT'               -- avoid the "hit-enter" prompts caused by file messages
o.signcolumn = 'yes'
g.nostartofline = true      -- Preserve cursor position when switching between buffers

-- keep changes history
o.undofile = true
g.undodir = '~/.vim/.vimundo'

-- Ctrlsf options
g.ctrlsf_default_root = 'project'
g.ctrlsf_ignore_dir = {'www', 'i18n', 'tests', 'platforms'}
g.ctrlsf_regex_pattern = 1

-- remove whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]]
})

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-- don't list quick fix window in buffers list
exec([[
  augroup qf
      autocmd!
      autocmd FileType qf set nobuflisted
  augroup END
]], false)

-- listtoggle mapping change
g.lt_quickfix_list_toggle_map = '<Leader>s'

-- vimwiki options
g.vimwiki_list = {{syntax = 'markdown', ext = '.md'}}
g.vimwiki_ext2syntax = {['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown'}

-- CtrlP configs
g.ctrlp_map = '<C-p>'
g.ctrlp_cmd = 'CtrlP'

-- Telescope configs
local telescope = require('telescope')
telescope.load_extension('fzy_native')
--local mvnsearch = telescope.extensions.mvnsearch
telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules/",
      "platforms/",
      "plugins/",
      "dist/",
      "build/",
      "lib/",
      "uploads/",
      "www/",
      "i18n/",
      "*.po",
      "vendor/",
      "migrations/",
      "staticfiles/",
      "*.png",
      "*.jpg",
      "*.jpeg",
    },
  },
}
telescope.load_extension('git_worktree')
telescope.load_extension('flutter')
telescope.load_extension('dap')

-- treesitter configs
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = { enable = true, disable = {"javascript", "python", "xml", "help"} },
  --highlight = { enable = false },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["i="] = "@assignment.inner",
        ["a="] = "@assignment.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>na"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>pa"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  }
}

-- actiate colors preview plugin
o.termguicolors = true
require'colorizer'.setup {
  "*";
  user_default_options = {
    tailwind = true,
  }
}

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
o.hidden = true         -- enable background buffers
o.history = 100         -- remember n lines in history
--o.lazyredraw = true     -- faster scrolling
b.synmaxcol = 240       -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
g.termguicolors = true          -- enable 24-bit RGB colors
g.background = dark
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
cmd([[colorscheme gruvbox]])
--g.gruvbox_contrast_dark = 'hard'

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
g.expandtab = true      -- use spaces instead of tabs
g.shiftwidth = 4        -- shift 4 spaces when tab
g.tabstop = 4           -- 1 tab == 4 spaces
g.smartindent = true    -- autoindent new lines
g.copyindent = true     -- persist on indent types

-- don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o"
})

-- NerdComenter options
-- Align line-wise comment delimiters flush left instead of following code indentation
g.NERDDefaultAlign = 'left'
-- Enable trimming of trailing whitespace when uncommenting
g.NERDTrimTrailingWhitespace = 1

-- remove line lenght marker for selected filetypes
autocmd("FileType", {
  pattern = {"text","markdown","xml","html","xhtml"},
  command = "setlocal cc=0"
})

-- indent size settings
autocmd("FileType", {
  pattern = {"xml","html", "htmldjango","xhtml","css","scss","javascript","typescript","lua","dart", "vue", "typescriptreact", "javascriptreact", "json"},
  command = "setlocal shiftwidth=2 tabstop=2 expandtab"
})
autocmd("FileType", {
  pattern = {"php"},
  command = "setlocal shiftwidth=4 tabstop=4 expandtab autoindent smartindent"
})
autocmd("BufEnter", {
  pattern = {"*.tsx"},
  command = "setlocal shiftwidth=2 tabstop=2 expandtab"
})
autocmd("FileType", {
  pattern = {"kotlin", "java", "groovy"},
  command = "setlocal shiftwidth=4 tabstop=4 expandtab"
})

-----------------------------------------------------------
-- Python
-----------------------------------------------------------
--autocmd("BufEnter", {
--  pattern = "python",
--  command = "setlocal foldlevelstart=1"
--})
-- Call yapf to format the file
--autocmd("BufWritePre", {
--  pattern = {"*.py"},
--  command = "Yapf"
--})


-----------------------------------------------------------
-- Go
-----------------------------------------------------------
autocmd("FileType", {
  pattern = "go",
  command = "setlocal shiftwidth=4 tabstop=4"
})
require("gopher").setup()

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
o.completeopt = 'menu,menuone,noselect' -- completion options

-----------------------------------------------------------
-- Lualine
-----------------------------------------------------------
require('lualine').setup {
  options = {
    theme = 'molokai',
    icons_enabled = true
  };
  sections = {
    lualine_a = {
      {
        'buffers',
      }
    },
    lualine_z = {
      "location",
      {
        function()
          local isVisualMode = fn.mode():find("[Vv]")
          if not isVisualMode then return "" end
          local starts = fn.line("v")
          local ends = fn.line(".")
          local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
          return tostring(lines) .. "L " .. tostring(fn.wordcount().visual_chars) .. "C"
        end,
        cond = function()
          return vim.fn.mode():find("[Vv]") ~= nil
        end,
      },
    },
  }
}

require'nvim-tree'.setup {}

-----------------------------------------------------------
-- CodeActionMenu
-----------------------------------------------------------
g.code_action_menu_show_diff = false

require('yapf').setup {
  command='yapf3'
}

-----------------------------------------------------------
-- setup mason plugin (package manager for installing lsp servers)
-----------------------------------------------------------
require("mason").setup()

-- autotag and autopairs configs
require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}
require("nvim-autopairs").setup {
  enable_check_bracket_line = false
}

-- formatter configs
local util = require("conform.util")
require("conform").setup({
  format = {
    timeout_ms = 3000,
    async = false, -- not recommended to change
    quiet = false, -- not recommended to change
  },
  formatters_by_ft = {
    php = { "pint" },
  },
  formatters = {
    pint = {
      meta = {
        url = "https://github.com/laravel/pint",
        description = "Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP-CS-Fixer and makes it simple to ensure that your code style stays clean and consistent.",
      },
      command = util.find_executable({
        vim.fn.stdpath("data") .. "/mason/bin/pint",
        "vendor/bin/pint",
      }, "pint"),
      args = { "$FILENAME" },
      stdin = false,
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = true,
  },
})

-- prettier
require('prettier').setup({
  bin = "prettierd",
  filetypes = {
    "vue"
  }
})


-- Java/Kotlin dependency
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java", "kotlin"},
  callback = function()
    telescope.load_extension('mvnsearch')
  end
})

-- database interface
--require("config.dadbod").setup()
g.db_ui_use_nerd_fonts = 1
g.db_ui_auto_execute_table_helpers = 1

-- UI for messages, cmdline and the popupmenu
require("notify").setup({
  --background_colour = "#000000",
})
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  routes = {
    {
      filter = {
        event = 'msg_show',
        any = {
          { find = '%d+L, %d+B' },
          { find = '; after #%d+' },
          { find = '; before #%d+' },
          { find = '%d fewer lines' },
          { find = '%d more lines' },
          { find = '%d+ lines? %-%-%d+%%%-%-' },
          { find = '%[LSP%]%[null%-ls%] timeout' },
          { find = 'lines? [><]ed' },
          { find = 'Workspace edit Apply source code transformation' },
          { find = '--No lines in buffer--' },
        },
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = 'notify',
        any = {
          { find = '%[LSP%]%[null%-ls%] timeout' },
          { find = 'No information available' },
        },
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = 'lsp',
        any = {
          { find = 'code_action null[-]ls' },
          { find = 'Resolving code actions phpactor' },
        },
      },
      opts = { skip = true },
    }
  },
})

-- Obsidian settigns
require("obsidian").setup({
  workspaces = {
    {
      name = "personal",
      path = "~/Documents/Notes/Personal",
    },
    {
      name = "work",
      path = "~/Documents/Notes/Work",
    },
    {
      name = "decimetr",
      path = "~/Documents/Notes/Decimetr",
    },
  },
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will be given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end,
  conceallevel = 1
})

-- Autocompletion for dadbod (database interface)
autocmd("FileType", {
  pattern = "sql,mysql,plsql",
  command = "lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })"
})

-- neotest configs
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      local message =
      diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
      return message
    end,
  },
}, neotest_ns)
require("neotest").setup({
  adapters = {
    require("neotest-go"),
  },
})

require("time-tracker").setup({
  data_file = vim.fn.stdpath("data") .. "/time-tracker_" .. os.date("%Y-%m-%d") .. ".db",
  --data_file = vim.fn.stdpath("data") .. "/time-tracker_2025-04-19.db",
  tracking_events = { "BufEnter", "BufWinEnter", "CursorMoved", "CursorMovedI", "WinScrolled" },
  tracking_timeout_seconds = 5 * 60, -- 5 minutes
})

-- edit your filesystem like a buffer
require("oil").setup()

-- file operations using built-in LSP
require("lsp-file-operations").setup()

-- Highlight, list and search todo comments in your projects
require("todo-comments").setup()

-- copilot chat
require("CopilotChat").setup {
  debug = false,
  mappings = {
    complete = {
      detail = 'Use @<Tab> or /<Tab> for options.',
      insert ='<S-Tab>',
    },
  },
  --window = {
  --  layout = 'float',
  --  relative = 'cursor',
  --  width = 1,
  --  height = 0.4,
  --  row = 1
  --}
}

-- Incremental LSP renaming
require("inc_rename").setup()

require("dap-python").setup(".venv/bin/python")
