local nvim_lsp = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()

--Enable (broadcasting) snippet capability for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lsp_format = require("lsp-format")

lsp_format.setup {}

-- Python
nvim_lsp.pyright.setup{
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportIncompatibleMethodOverride = false
        }
      }
    }
  }
}
local on_attach = function(client, bufnr)
  -- Disable hover in favor of Pyright
  --client.server_capabilities.hoverProvider = false
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, mapping_opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, mapping_opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, mapping_opts)
  vim.keymap.set('n', '<C-Q>', vim.diagnostic.setloclist, mapping_opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end
nvim_lsp.ruff_lsp.setup {
  on_attach = on_attach,
  init_options = {
    settings = {
      fixAll = false,
      organizeImports = false,
      codeAction = {
        disableRuleComment = {
          enable = false,
        },
      },
    }
  }
}

-- CSS
nvim_lsp.cssls.setup {
  capabilities = capabilities,
  on_attach = lsp_format.on_attach,
}
-- HTML
nvim_lsp.html.setup {
  capabilities = capabilities,
  init_options = {
    provideFormatter = false,
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
  },
  on_attach = lsp_format.on_attach,
}
-- Json
nvim_lsp.jsonls.setup {
  on_attach = lsp_format.on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

-- Angular
--nvim_lsp.angularls.setup{
--  capabilities = capabilities,
--}

-- Typescript
nvim_lsp.tsserver.setup{
  on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

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
  on_attach = lsp_format.on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true
      }
    }
  },
}

require("flutter-tools").setup{
  --flutter_path = "/home/mehrdad/snap/flutter/common/flutter/bin/flutter",
  lsp = {
    on_attach = lsp_format.on_attach,
    capabilities = capabilities
  }
}

-- PHP
--nvim_lsp.phpactor.setup{
--  capabilities = capabilities,
--  --on_attach = lsp_format.on_attach,
--}
require'lspconfig'.intelephense.setup{
  capabilities = capabilities,
  --on_attach = lsp_format.on_attach,
  settings = {
    intelephense = {
      stubs = {
        "bcmath",
        "bz2",
        "calendar",
        "Core",
        "curl",
        "zip",
        "zlib",
        "wordpress",
        "woocommerce",
        "acf-pro",
        "wordpress-globals",
        "wp-cli",
        "genesis",
        "polylang"
      },
      environment = {
        includePaths = {
          "/home/mehrdad/.config/composer/vendor/php-stubs/",
        },
        phpVersion = "7.4"
      }
    }
  }
}

-- VueJS
nvim_lsp.vuels.setup{
  capabilities = capabilities,
  on_attach = lsp_format.on_attach,
}

-- null-ls
local null_ls = require("null-ls")
null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<leader>F", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<leader>F", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
  sources = {
    null_ls.builtins.formatting.yapf,
    null_ls.builtins.code_actions.refactoring,
    --null_ls.builtins.diagnostics.eslint_d,
    --null_ls.builtins.diagnostics.curlylint,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.prettierd,
    --null_ls.builtins.formatting.ktlint,
    --null_ls.builtins.diagnostics.ktlint,
    null_ls.builtins.formatting.google_java_format,
  }
})

-- kotlin
nvim_lsp.kotlin_language_server.setup{
  capabilities = capabilities,
  on_attach = lsp_format.on_attach,
}

-- Java
local function get_java_lsp()
end
local java_on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end
local mason_registry = require "mason-registry"
local jlsp = mason_registry.get_package "java-language-server"
local jlsp_path = jlsp:get_install_path()
nvim_lsp.java_language_server.setup{
  cmd = { jlsp_path .. "/dist/lang_server_linux.sh" },
  capabilities = capabilities,
  on_attach = java_on_attach,
}
--local function get_jdtls()
--  local mason_registry = require "mason-registry"
--  local jdtls = mason_registry.get_package "jdtls"
--  local jdtls_path = jdtls:get_install_path()
--  local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
--  local SYSTEM = "linux"
--  if vim.fn.has "mac" == 1 then
--    SYSTEM = "mac"
--  end
--  local config = jdtls_path .. "/config_" .. SYSTEM
--  local lombok = jdtls_path .. "/lombok.jar"
--  return launcher, config, lombok
--end
--local function get_bundles()
--  local mason_registry = require "mason-registry"
--  local java_debug = mason_registry.get_package "java-debug-adapter"
--  local java_test = mason_registry.get_package "java-test"
--  local java_debug_path = java_debug:get_install_path()
--  local java_test_path = java_test:get_install_path()
--  local bundles = {}
--  vim.list_extend(bundles, vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n"))
--  vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))
--  return bundles
--end
--local function get_workspace()
--  local home = os.getenv "HOME"
--  local workspace_path = home .. "/.local/share/nde/jdtls-workspace/"
--  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
--  local workspace_dir = workspace_path .. project_name
--  return workspace_dir
--end
--vim.api.nvim_create_autocmd("FileType", {
--  pattern = { "java" },
--  callback = function()
--    -- LSP capabilities
--    local jdtls = require "jdtls"
--    local extendedClientCapabilities = jdtls.extendedClientCapabilities
--    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

--    local launcher, os_config, lombok = get_jdtls()
--    local workspace_dir = get_workspace()
--    local bundles = get_bundles()

--    local jdtls_on_attach = function(_, bufnr)
--      vim.lsp.codelens.refresh()
--      jdtls.setup_dap { hotcodereplace = "auto" }
--      require("jdtls.dap").setup_dap_main_class_configs()
--      require("jdtls.setup").add_commands()

--      local map = function(mode, lhs, rhs, desc)
--        if desc then
--          desc = desc
--        end
--        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
--      end

--      -- Register keymappings
--      local wk = require "which-key"
--      local keys = { mode = { "n", "v" }, ["<leader>lj"] = { name = "+Java" } }
--      wk.register(keys)

--      map("n", "<leader>ljo", jdtls.organize_imports, "Organize Imports")
--      map("n", "<leader>ljv", jdtls.extract_variable, "Extract Variable")
--      map("n", "<leader>ljc", jdtls.extract_constant, "Extract Constant")
--      map("n", "<leader>ljt", jdtls.test_nearest_method, "Test Nearest Method")
--      map("n", "<leader>ljT", jdtls.test_class, "Test Class")
--      map("n", "<leader>lju", "<cmd>JdtUpdateConfig<cr>", "Update Config")
--      map("v", "<leader>ljv", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable")
--      map("v", "<leader>ljc", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant")
--      map("v", "<leader>ljm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method")

--      vim.api.nvim_create_autocmd("BufWritePost", {
--        pattern = { "*.java" },
--        callback = function()
--          local _, _ = pcall(vim.lsp.codelens.refresh)
--        end,
--      })
--    end

--    local config = {
--      cmd = {
--        "java",
--        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--        "-Dosgi.bundles.defaultStartLevel=4",
--        "-Declipse.product=org.eclipse.jdt.ls.core.product",
--        "-Dlog.protocol=true",
--        "-Dlog.level=ALL",
--        "-Xms1g",
--        "--add-modules=ALL-SYSTEM",
--        "--add-opens",
--        "java.base/java.util=ALL-UNNAMED",
--        "--add-opens",
--        "java.base/java.lang=ALL-UNNAMED",
--        "-javaagent:" .. lombok,
--        "-jar",
--        launcher,
--        "-configuration",
--        os_config,
--        "-data",
--        workspace_dir,
--      },
--      root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
--      capabilities = capabilities,
--      on_attach = jdtls_on_attach,

--      settings = {
--        java = {
--          autobuild = { enabled = false },
--          signatureHelp = { enabled = true },
--          contentProvider = { preferred = "fernflower" },
--          saveActions = {
--            organizeImports = true,
--          },
--          sources = {
--            organizeImports = {
--              starThreshold = 9999,
--              staticStarThreshold = 9999,
--            },
--          },
--          codeGeneration = {
--            toString = {
--              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
--            },
--            hashCodeEquals = {
--              useJava7Objects = true,
--            },
--            useBlocks = true,
--          },
--          eclipse = {
--            downloadSources = true,
--          },
--          configuration = {
--            updateBuildConfiguration = "interactive",
--          },
--          maven = {
--            downloadSources = true,
--          },
--          implementationsCodeLens = {
--            enabled = true,
--          },
--          referencesCodeLens = {
--            enabled = true,
--          },
--          references = {
--            includeDecompiledSources = true,
--          },
--          inlayHints = {
--            parameterNames = {
--              enabled = "all", -- literals, all, none
--            },
--          },
--          format = {
--            enabled = false,
--          },
--        },
--      },
--      init_options = {
--        bundles = bundles,
--        extendedClientCapabilities = extendedClientCapabilities,
--      },
--    }
--    require("jdtls").start_or_attach(config)
--  end,
--})
