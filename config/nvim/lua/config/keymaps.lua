-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Increment/decrement
keymap.set("n", "+", "<C-a>", { desc = "Increment" })
keymap.set("n", "-", "<C-x>", { desc = "Decrement" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select All" })
