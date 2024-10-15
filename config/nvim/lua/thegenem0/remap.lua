local utils = require("thegenem0.utils")

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

---------------------
-- General Keymaps
---------------------

utils.keymap("i", "<C-j>", "<Down>", { desc = "Insert Mode Down" })
utils.keymap("i", "<C-k>", "<Up>", { desc = "Insert Mode Up" })
utils.keymap("i", "<C-h>", "<Left>", { desc = "Insert Mode Left" })
utils.keymap("i", "<C-l>", "<Right>", { desc = "Insert Mode Right" })

-- remap write and quit to capitals
vim.cmd([[
command! W write
command! Q quit
command! Wq write | quit
command! WQ write | quit
]])

utils.keymap("n", "q", "<Nop>")

utils.keymap("n", "<leader>ch", ":nohl<CR>", { desc = "Clear Search Highlights" })

utils.keymap("n", "x", '"_x', { desc = "Delete Char without Copy" })

-- window management
utils.keymap("n", "<leader>sv", "<C-w>v", { desc = "Split Vertical" })
utils.keymap("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontal" })
utils.keymap("n", "<leader>se", "<C-w>=", { desc = "Make Equal" })
utils.keymap("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close Current" })

-- buffer navigation
utils.keymap("n", "<leader>p", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
utils.keymap("n", "<leader>n", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })

-- disable arrow navigation in normal mode
utils.keymap("n", "<Up>", "<Nop>")
utils.keymap("n", "<Down>", "<Nop>")
utils.keymap("n", "<Left>", "<Nop>")
utils.keymap("n", "<Right>", "<Nop>")
