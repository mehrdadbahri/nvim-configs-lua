-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd     -- execute Vim commands
local exec = vim.api.nvim_exec       -- execute Vimscript
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
w.foldmethod = 'marker'     -- enable folding (default 'foldmarker')
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
cmd([[au BufWritePre * :%s/\s\+$//e]])

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
cmd([[colorscheme molokai]])    -- set colorscheme

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
b.expandtab = true      -- use spaces instead of tabs
b.shiftwidth = 4        -- shift 4 spaces when tab
b.tabstop = 4           -- 1 tab == 4 spaces
b.smartindent = true    -- autoindent new lines
b.copyindent = true     -- persist on indent types

-- don't auto commenting new lines
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- remove line lenght marker for selected filetypes
cmd([[
  autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0
]])

-- 2 spaces for selected filetypes
cmd([[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua setlocal shiftwidth=2 tabstop=2
]])

-----------------------------------------------------------
-- Python
-----------------------------------------------------------
cmd[[autocmd filetype python setlocal foldmethod=indent
  setlocal foldlevelstart=99]]

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
o.completeopt = 'menuone,noselect,noinsert' -- completion options
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
