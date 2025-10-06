local map = vim.api.nvim_set_keymap
local cmd = vim.cmd     -- execute Vim commands

-- setting , as leader key
map('n', ',', '<NOP>', { noremap = true, silent = true })

-- close buffer
map('n', '<Leader>x', [[<Cmd>BD<CR>]], { noremap = true, silent = true })

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

-- copy to and paste from system clipboard
map('n', '<Leader>y', '"+y', { noremap = true, silent = true })
map('v', '<Leader>y', '"+y', { noremap = true, silent = true })
map('n', '<Leader>p', '"+p', { noremap = true, silent = true })
map('v', '<Leader>p', '"+p', { noremap = true, silent = true })
map('n', '<Leader>P', '"+P', { noremap = true, silent = true })
map('v', '<Leader>P', '"+P', { noremap = true, silent = true })

-- paste from 0 register
map('n', '<Leader>0', '"0p', { noremap = true, silent = true })
map('v', '<Leader>0', '"0p', { noremap = true, silent = true })


-- delete but keep current default buffer
map('v', '<Leader>d', '"_d', { noremap = true, silent = true })

-- go to end of line
map('n', '<Leader>e', '$', { noremap = true, silent = true })
map('v', '<Leader>e', '$', { noremap = true, silent = true })

-- quit vim
map('n', '<Leader>q', '<Cmd>qa<CR>', { noremap = true, silent = true })

-- easily insert ; and ,
map('n', ';', 'A;<Esc>', { noremap = true, silent = true })
map('n', '<Leader>,', 'A,<Esc>', { noremap = true, silent = true })

-- show git status
map('n', '<leader>lg', '<Cmd>Git<CR>', { noremap = true, silent = true })
map('n', '<leader>ll', '<Cmd>Git log<CR>', {noremap = true, silent = true})

-- git conflict 3 window diffget
map('n', '<leader>dc', '<Cmd>Gvdiffsplit!<CR>', { noremap = true, silent = true })
map('n', '<leader>dr', '<Cmd>diffget //3<CR>', { noremap = true, silent = true })
map('n', '<leader>dl', '<Cmd>diffget //2<CR>', { noremap = true, silent = true })

--  nvim-tree shortcuts
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
map('n', '<C-f>', ':NvimTreeFindFile<CR>', {noremap = true, silent = true})

-- format python file with yapf
map('n', '<leader>=', '<Cmd>Yapf<CR>', {noremap = true, silent = true})

-- Telescope mappings
map('n', '<leader>f', '<Cmd>Telescope find_files<CR>', {noremap = true, silent = true})
map('n', '<leader>g', '<Cmd>Telescope live_grep<CR>', {noremap = true, silent = true})
map('n', '<leader>t', '<Cmd>Telescope buffers<CR>', {noremap = true, silent = true})
map('n', '<leader>h', '<Cmd>Telescope help_tags<CR>', {noremap = true, silent = true})
map('n', '<leader>c', '<Cmd>Telescope git_commits<CR>', {noremap = true, silent = true})
--map('n', '<leader>b', '<Cmd>Telescope git_branches<CR>', {noremap = true, silent = true})
map('n', '<leader>j', '<Cmd>Telescope grep_string<CR>', {noremap = true, silent = true})
map('n', '<leader>db', '<Cmd>Telescope dap commands<CR>', {noremap = true, silent = true})
map('n', '<leader>dv', '<Cmd>Telescope dap variables<CR>', {noremap = true, silent = true})
map('n', '<leader>wt', '<Cmd>Telescope git_worktree<CR>', {noremap = true, silent = true})
map('n', '<C-\\>', '<Cmd>Telescope lsp_references<CR>', {noremap = true, silent = true})
map('n', '<leader>r', '<Cmd>Telescope resume<CR>', {noremap = true, silent = true})

-- insert !important css option
function _G.insert_css_option_important()
  return (vim.bo.filetype == 'css' or vim.bo.filetype == 'scss' or vim.bo.filetype == 'less') and '$i !important' or ''
end
map('n', '!', ':lua.insert_css_option_important()', {noremap = true, silent = true})

-- terminal mappings
map('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})

-- lsp key mappings
map('n', '<F3>', '<Cmd>Trouble diagnostics toggle  filter.buf=0<CR>', {noremap = true, silent = true})
map('n', '<F4>', '<Cmd>Trouble diagnostics toggle<CR>', {noremap = true, silent = true})
map('n', '<leader><space>', '<Cmd>CodeActionMenu<CR>', {noremap = true, silent = true})
map('v', '<leader><space>', '<Cmd>CodeActionMenu<CR>', {noremap = true, silent = true})
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
map('n', '<leader>gr', '<Cmd>Trouble lsp_references toggle<cr>', {noremap = true, silent = true})

-- navigate between buffers
map('n', ']b', '<Cmd>bn<CR>', {noremap = true, silent = true})
map('n', '[b', '<Cmd>bp<CR>', {noremap = true, silent = true})

-- clear search highlighting
map('n', '<Leader><Esc>', ':nohl<CR>', {noremap = true, silent = true})

-- Run Flutter app
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'dart',
	group = vim.api.nvim_create_augroup('tex_only_keymap', { clear = true }),
	callback = function ()
    map('n', '<F5>', '<Cmd>FlutterRun<CR>', {noremap = true, silent = true})
    map('n', '<leader><CR>', '<Cmd>Telescope flutter commands<CR>', {noremap = true, silent = true})
	end,
})

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

-- Open terminal in a vertical split window
map('n', '<C-T>', '<Cmd>15split | :terminal<CR>', {noremap = true, silent = true})

-- Toggle zen mode (maximize current window)
map('n', '<leader>m', '<Cmd>ZenMode<CR>', {noremap = true, silent = true})

-- Go debugger (delve) mappings
map('n', '<leader>dt', '<Cmd>lua require("dap-go").debug_test()<CR>', {noremap = true, silent = true})
map('n', '<leader>dlt', '<Cmd>lua require("dap-go").debug_last_test()<CR>', {noremap = true, silent = true})
function _G.open_debugging_sidebar()
  local widgets = require('dap.ui.widgets')
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end

-- dap mappings
map('n', '<leader>ds', '<Cmd>lua open_debugging_sidebar()<CR>', {noremap = true, silent = true})
map('n', '<F5>', '<Cmd>DapContinue<CR>', {noremap = true, silent = true})
map('n', '<F6>', '<Cmd>DapStepOver<CR>', {noremap = true, silent = true})
map('n', '<F7>', '<Cmd>DapStepInto<CR>', {noremap = true, silent = true})
map('n', '<F8>', '<Cmd>DapStepOut<CR>', {noremap = true, silent = true})
map('n', '<leader>b', '<Cmd>DapToggleBreakpoint<CR>', {noremap = true, silent = true})
map('n', '<leader>dc', '<Cmd>DapContinue<CR>', {noremap = true, silent = true})
map('n', '<leader>dr', '<Cmd>DapRestart<CR>', {noremap = true, silent = true})
map('n', '<leader>dR', '<Cmd>DapTerminate<CR>', {noremap = true, silent = true})
map('n', '<leader>dl', '<Cmd>DapShowLog<CR>', {noremap = true, silent = true})

-- gopher mappings
map('n', '<leader>at', '<Cmd>GoTagAdd json<CR>', {noremap = true, silent = true})
map('n', '<leader>rt', '<Cmd>GoTagRm json<CR>', {noremap = true, silent = true})
map('n', '<leader>ae', '<Cmd>GoIfErr<CR>', {noremap = true, silent = true})
map('n', '<leader>dg', '<Cmd>GoTestAdd<CR>', {noremap = true, silent = true})

-- dapui
map('n', '<leader>du', '<Cmd>lua require("dapui").toggle()<CR>', {noremap=true})

-- Obsidian mappings
map("n", "<leader>nn", ":ObsidianNew ", {noremap=true})
map("n", "<leader>ns", ":ObsidianQuickSwitch<CR>", {noremap=true})
map("n", "<leader>nw", ":ObsidianWorkspace ", {noremap=true})

-- open an empty file in /temp folder
map("n", "<leader>ww", ":e /tmp/tempfile<CR>", {noremap = true, silent = true})

-- neotest mappings
map('n', '<leader>nr', '<Cmd>lua require("neotest").run.run()<CR>', {noremap=true})
map('n', '<leader>nf', '<Cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', {noremap=true})
map('n', '<leader>np', '<Cmd>lua require("neotest").run.run(vim.fn.getcwd())<CR>', {noremap=true})
map('n', '<leader>no', '<Cmd>Neotest output-panel<CR>', {noremap=true})
map('n', '<leader>nv', '<Cmd>Neotest summary<CR>', {noremap=true})

-- Control copilot
map('n', '<leader>+', '<Cmd>Copilot enable<CR>', {noremap=true})
map('n', '<leader>-', '<Cmd>Copilot disable<CR>', {noremap=true})

-- close all buffers except current one
map('n', '<leader>X', '<Cmd>%bd|e#|bd#<CR>', {noremap=true})

-- Noice mappings
map('n', '<leader>0', '<Cmd>Noice dismiss<CR>', {noremap=true})

-- Copilot chat mappings
  function _G.quick_chat()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
      require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
    end
  end
map('n', '<leader>o', '<Cmd>lua quick_chat()<CR>', {noremap=true})
map('v', '<leader>o', '<Cmd>lua quick_chat()<CR>', {noremap=true})
map('n', '<leader>v', '<Cmd>:CopilotChatToggle<CR>', {noremap=true})

-- show current buffer full path
map('n', '<C-g>', '<Cmd>:echo expand("%:p")<CR>', {noremap=true})

-- go to definition of symbol under cursor (lsp) in vertical split
map('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', {noremap=true})
map('n', '<leader>i', '<Cmd>lua vim.lsp.buf.implementation()<CR>', {noremap=true})

map('n', '<leader>W', '<Cmd>noau w<CR>', {noremap=true})
