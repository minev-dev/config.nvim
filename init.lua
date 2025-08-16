vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Disable nvim_lsp.CompletionItemKind.Text
require("cmp").setup {
  sources = {
    {
      name = "nvim_lsp",
      entry_filter = function(entry)
        return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
      end,
    },
  },
}

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*", -- Match all events
  callback = function()
    -- Check if NvimTree is available before trying to open it
    local nvimtree_status, _ = pcall(require, "nvim-tree.api")
    if nvimtree_status then
      -- Use a small delay to ensure the UI is ready
      vim.defer_fn(function()
        vim.cmd "NvimTreeOpen"
      end, 10) -- 10ms delay, adjust if needed
    end
  end,
  desc = "Auto open NvimTree on startup",
})

-- lualine
require("lualine").setup {
  sections = {
    lualine_c = { { "filename", path = 1 } },
  },
}
