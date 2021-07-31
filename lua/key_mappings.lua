local map = vim.api.nvim_set_keymap
local cmd = vim.cmd     -- execute Vim commands

-- setting , as leader key
map('n', ',', '<NOP>', { noremap = true, silent = true })

-- close buffer
map('n', '<Leader>x', [[<Cmd>bd<CR>]], { noremap = true, silent = true })

-- moving between windows
map('n', '<C-J>', '<C-W><C-J>', { noremap = true, silent = true })
map('n', '<C-K>', '<C-W><C-K>', { noremap = true, silent = true })
map('n', '<C-L>', '<C-W><C-L>', { noremap = true, silent = true })
map('n', '<C-H>', '<C-W><C-H>', { noremap = true, silent = true })

-- smart tab
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end

map('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})

-- enable folding with the spacebar
map('n', ' ', 'za', { noremap = true, silent = true })

-- fold all and unfold all
map('n', '<Leader>z', 'zR', { noremap = true, silent = true })
map('n', '<Leader>Z', 'zM', { noremap = true, silent = true })

-- unfold all levels of current fold
map('n', '<Leader>u', 'zA', { noremap = true, silent = true })

-- reindent whole file
map('n', '<Leader>ai', 'mzgg=G`z', { noremap = true, silent = true })

-- copy to and paset from system clipboard
map('n', '<Leader>y', '"+y', { noremap = true, silent = true })
map('v', '<Leader>y', '"+y', { noremap = true, silent = true })
map('n', '<Leader>p', '"+p', { noremap = true, silent = true })
map('v', '<Leader>p', '"+p', { noremap = true, silent = true })
map('n', '<Leader>P', '"+P', { noremap = true, silent = true })
map('v', '<Leader>P', '"+P', { noremap = true, silent = true })

-- delete but keep current default buffer
map('n', '<Leader>d', '"_d', { noremap = true, silent = true })

-- go to end of line
map('n', '<Leader>e', '$', { noremap = true, silent = true })
map('v', '<Leader>e', '$', { noremap = true, silent = true })

-- quit vim
map('n', '<Leader>q', '<Cmd>qa<CR>', { noremap = true, silent = true })

--  quit buffer
map('n', '<Leader>x', '<Cmd>bd<CR>', { noremap = true, silent = true })

-- easily insert ; and ,
map('n', ';', 'A;<Esc>', { noremap = true, silent = true })
map('n', '<Leader>,', 'A,<Esc>', { noremap = true, silent = true })

-- CtrlSF mappings
map('n', '<C-F>f', '<Plug>CtrlSFPrompt', { noremap = true, silent = true })
map('v', '<C-F>f', '<Plug>CtrlSFVwordPath', { noremap = true, silent = true })
map('v', '<C-F>F', '<Plug>CtrlSFVwordExec', { noremap = true, silent = true })
map('n', '<C-F>n', '<Plug>CtrlSFCwordPath', { noremap = true, silent = true })
map('n', '<C-F>p', '<Plug>CtrlSFPwordPath', { noremap = true, silent = true })
map('n', '<C-F>o', '<Cmd>CtrlSFOpen<CR>', { noremap = true, silent = true })
map('n', '<C-F>t', '<Cmd>CtrlSFToggle<CR>', { noremap = true, silent = true })

-- check python syntax
map('n', '<F3>', '<Cmd>PymodeLint<CR>', { noremap = true, silent = true })

-- show git status
map('n', '<C-G>', '<Cmd>Gstatus<CR>', { noremap = true, silent = true })

-- run the current file in bash
map('n', '<Leader>r', '<Cmd>!"%:p"<CR>', { noremap = true, silent = true })
-- make current file executable
map('n', '<Leader>ch', '<Cmd>!chmod +x %<CR>', { noremap = true, silent = true })

--  nvim-tree shortcuts
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
map('n', '<leader>r', ':NvimTreeRefresh<CR>', {noremap = true, silent = true})
map('n', '<leader>n', ':NvimTreeFindFile<CR>', {noremap = true, silent = true})

-- format python file with yapf
function _G.run_yapf_current_file()
    return vim.bo.filetype == 'python' and t'<Cmd>0,$!yapf<CR>' or ''
end
map('n', '<leader>=', '<Cmd>0,$!yapf<CR>', {noremap = true, silent = true})

-- Telescope mappings
map('n', '<leader>f', '<Cmd>Telescope find_files<CR>', {noremap = true, silent = true})
map('n', '<leader>g', '<Cmd>Telescope live_grep<CR>', {noremap = true, silent = true})
map('n', '<leader>b', '<Cmd>Telescope buffers<CR>', {noremap = true, silent = true})
map('n', '<leader>h', '<Cmd>Telescope help_tags<CR>', {noremap = true, silent = true})

-- insert !important css option
function _G.insert_css_option_important()
    return (vim.bo.filetype == 'css' or vim.bo.filetype == 'scss' or vim.bo.filetype == 'less') and '$i !important' or ''
end
map('n', '!', ':lua.insert_css_option_important()', {noremap = true, silent = true})

-- terminal mappings
map('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})

-- lsp key mappings
map('n', '<F3>', '<Cmd>TroubleToggle<CR>', {noremap = true, silent = true})

--------------------------------
-- vim-vsnip mappings
--------------------------------
-- Expand or jump forward
--map('i', '<C-j>', [[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>']], {expr=true})
--map('s', '<C-j>', [[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>']], {expr=true})
-- Expand or jump backward
--map('i', '<C-k>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>']], {expr=true})
--map('s', '<C-k>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>']], {expr=true})
cmd([[
" Expand or jump
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
]])
