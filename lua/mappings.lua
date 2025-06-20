require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

vim.g.clipboard = "osc52"
map("n", "<leader>y", '"+y')
vim.g.clipboard = require("vim.ui.clipboard.osc52").tool

-- Show references
map("n", "grr", ':lua require("telescope.builtin").lsp_references()<CR>', { noremap = true, silent = true })
map("n", "ga", ":lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

-- In your init.lua
-- vim.keymap.set("n", "<leader>h", "<C-W>h", { noremap = true, silent = true, desc = "Move to left window" })
-- vim.keymap.set("n", "<leader>j", "<C-W>j", { noremap = true, silent = true, desc = "Move to lower window" })
-- vim.keymap.set("n", "<leader>k", "<C-W>k", { noremap = true, silent = true, desc = "Move to upper window" })
-- vim.keymap.set("n", "<leader>l", "<C-W>l", { noremap = true, silent = true, desc = "Move to right window" })
-- vim.keymap.set("n", "<leader>c", "<C-W>c", { noremap = true, silent = true, desc = "Close window" })

local function nvim_tree_opts(desc)
  return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
end
vim.keymap.set("n", "<C-v>", require("nvim-tree.api").node.open.vertical, nvim_tree_opts "Open: Vertical Split")
vim.keymap.set("n", "<C-x>", require("nvim-tree.api").node.open.horizontal, nvim_tree_opts "Open: Horizontal Split")

-- Remap terminal
map("t", "<Esc>", "<C-\\><C-N>", { desc = "Enter Terminal Normal Mode" })

local term_toggle = require("nvchad.term").toggle
map({ "n", "t" }, "<leader>tv", function()
  term_toggle { pos = "vsp", id = "custom_vertical_term", size = 0.4 }
end, { noremap = true, silent = true, desc = "Toggle vertical terminal" })
map({ "n", "t" }, "<leader>th", function()
  term_toggle { pos = "sp", id = "custom_horizontal_term", size = 0.3 }
end, { noremap = true, silent = true, desc = "Toggle horizontal terminal" })

-- Remap floating terminal toggle to <leader>tf
-- map({ "n", "t" }, "<leader>tf", function()
--   term_toggle { pos = "float", id = "custom_floating_term", size = { width = 0.8, height = 0.8 } } -- Adjust size as needed
-- end, { noremap = true, silent = true, desc = "Toggle floating terminal" })

require('gitsigns').setup{
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hR', gitsigns.reset_buffer)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk)
  end
}
