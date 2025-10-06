local mason_plugins = {
  "basedpyright",
  "bash-language-server",
  "css-lsp",
  "delve",
  "eslint-lsp",
  "go-debug-adapter",
  "goimports",
  "goimports-reviser",
  "gomodifytags",
  "gopls",
  "gotests",
  "html-lsp",
  "intelephense",
  "isort",
  "js-debug-adapter",
  "json-lsp",
  "marksman",
  "prettierd",
  "pyright",
  "ruff",
  "ruff-lsp",
  "typescript-language-server",
  "vls",
  "vtsls",
  "yapf",
}

local mason_registry = require("mason-registry")

local function install_mason_package(name)
  local package = mason_registry.get_package(name)
  if not package:is_installed() then
    package:install()
  end
end

for _, name in ipairs(mason_plugins) do
  install_mason_package(name)
end
