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
w.colorcolumn = '80'        -- line lenght marker at 80 columns
o.splitright = true         -- vertical split to the right
o.splitbelow = true         -- orizontal split to the bottom
o.ignorecase = true         -- ignore case letters when search
o.smartcase = true          -- ignore lowercase for the whole pattern
o.scrolloff = 15            -- keep active line in center
o.laststatus = 2            -- always show status line
o.diffopt = o.diffopt .. ',vertical'

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
  command = "%s/\s\+$//e"
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
require('telescope').load_extension('fzy_native')
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "platforms",
      "plugins",
      "dist",
      "lib",
      "uploads",
      "www",
      "i18n",
      "tests",
      "*.po"
    },
  },
}
require('telescope').load_extension('git_worktree')
require('telescope').load_extension('flutter')

-- treesitter configs
require'nvim-treesitter.configs'.setup {
	ensure_installed = "all",
	highlight = { enable = true, disable = {"javascript", "python", "xml"} },
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
	}
}

-- actiate colors preview plugin
o.termguicolors = true
require'colorizer'.setup()

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
o.hidden = true         -- enable background buffers
o.history = 100         -- remember n lines in history
o.lazyredraw = true     -- faster scrolling
b.synmaxcol = 240       -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
o.termguicolors = true          -- enable 24-bit RGB colors
cmd([[colorscheme gruvbox]])    -- set colorscheme
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

-- 2 spaces for selected filetypes
autocmd("FileType", {
  pattern = {"xml","html", "htmldjango","xhtml","css","scss","javascript","typescript","lua","dart"},
  command = "setlocal shiftwidth=2 tabstop=2"
})

-----------------------------------------------------------
-- Python
-----------------------------------------------------------
autocmd("FileType", {
  pattern = "python",
  command = "setlocal foldlevelstart=99"
})
autocmd("BufWritePre", {
  pattern = {"*.py"},
  command = "Yapf"
})

-----------------------------------------------------------
-- Go
-----------------------------------------------------------
autocmd("FileType", {
  pattern = "go",
  command = "setlocal shiftwidth=4 tabstop=4"
})

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
o.completeopt = 'menu,menuone,noselect' -- completion options
o.shortmess = 'c'       -- don't show completion messages

-----------------------------------------------------------
-- Lualine
-----------------------------------------------------------
require('lualine').setup {
  options = {
    theme = 'molokai',
    icons_enabled = true
  };
}

require'nvim-tree'.setup {}

-----------------------------------------------------------
-- CodeActionMenu
-----------------------------------------------------------
g.code_action_menu_show_diff = false

require('yapf').setup {}
