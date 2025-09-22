return {
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "markdown",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
  },
  {
    "folke/which-key.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Ensure you also have plenary.nvim installed
    lazy = false, -- OR lazy = true (for lazy loading)
  },
  {
    "ojroques/nvim-osc52",
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "alanfortlink/animatedbg.nvim",
    config = function()
      require("animatedbg-nvim").setup {
        fps = 60, -- default
      }
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    ft = "python", -- Load when opening Python files
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
    },
    opts = { -- this can be an empty lua table - just showing below for clarity.
    },
  },
}
