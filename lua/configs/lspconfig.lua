require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "pyright",
  "marksman",
  "terraformls",
}
vim.lsp.enable(servers)
