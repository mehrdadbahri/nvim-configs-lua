require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "bashls",
    "cssls",
    "eslint",
    "gopls",
    "html",
    "intelephense",
    "jsonls",
    "marksman",
    "pyright",
    "vls",
    "vtsls",
  },
}

require("mason-tool-installer").setup {
  ensure_installed = {
    "delve",
    "go-debug-adapter",
    "goimports",
    "goimports-reviser",
    "gomodifytags",
    "gotests",
    "isort",
    "js-debug-adapter",
    "prettierd",
    "ruff",
    "yapf",
  },
}
