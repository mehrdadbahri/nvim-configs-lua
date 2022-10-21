local nvim_lsp = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()

--Enable (broadcasting) snippet capability for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require("lsp-format").setup {}

-- Python
nvim_lsp.pylsp.setup{
  on_attach = require("lsp-format").on_attach,
  capabilities = capabilities,
  settings = {
    configurationSources = {"pylint"},
    plugins = {
      pylint = { enabled = true },
      flake8 = { enabled = false },
      pycodestyle = { enabled = false },
      pyflakes = { enabled = false },
    }
  }
}
--require('lspconfig').pyright.setup{}

-- CSS
nvim_lsp.cssls.setup {
  capabilities = capabilities,
  on_attach = require("lsp-format").on_attach,
}
-- HTML
nvim_lsp.html.setup {
  capabilities = capabilities,
  init_options = {
    provideFormatter = true,
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
  },
  on_attach = require("lsp-format").on_attach,
}
-- Json
nvim_lsp.jsonls.setup {
  on_attach = require("lsp-format").on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

-- Angular
nvim_lsp.angularls.setup{
  on_attach = require("lsp-format").on_attach,
  capabilities = capabilities,
}

-- Typescript
require("null-ls").setup {}
nvim_lsp.tsserver.setup{
  on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,

      -- import all
      import_all_timeout = 5000, -- ms
      import_all_priorities = {
        buffers = 4, -- loaded buffer names
        buffer_content = 3, -- loaded buffer content
        local_files = 2, -- git files or files with relative path markers
        same_file = 1, -- add to existing import statement
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,

      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = false,
      eslint_opts = {},

      -- formatting
      enable_formatting = false,
      formatter = "prettier",
      formatter_opts = {},

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,

      -- filter diagnostics
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},
    }

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    local opts = { silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
  end
}

-- Bash
nvim_lsp.bashls.setup{}

-- Go
nvim_lsp.gopls.setup{
  on_attach = require("lsp-format").on_attach,
  capabilities = capabilities,
}

local saga = require 'lspsaga'
saga.init_lsp_saga()

require("flutter-tools").setup{
  --flutter_path = "/home/mehrdad/snap/flutter/common/flutter/bin/flutter",
  lsp = {
    on_attach = require("lsp-format").on_attach,
    capabilities = capabilities
  }
}
