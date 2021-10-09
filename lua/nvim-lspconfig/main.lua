-- Python
require'lspconfig'.pylsp.setup{}
--require('lspconfig').pyright.setup{}

-- CSS
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}
-- HTML
require'lspconfig'.html.setup {
  capabilities = capabilities,
}
-- Json
require'lspconfig'.jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}

-- Angular
require'lspconfig'.angularls.setup{}

-- Typescript
require'lspconfig'.tsserver.setup{}

-- Bash
require'lspconfig'.bashls.setup{}

-- Go
require'lspconfig'.gopls.setup{}

local saga = require 'lspsaga'
saga.init_lsp_saga()
