require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "pyright",
  "marksman",
}
vim.lsp.enable(servers)
