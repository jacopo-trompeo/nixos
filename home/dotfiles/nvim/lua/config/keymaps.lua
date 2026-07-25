-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--- select all ---
keymap.set("n", "<C-a>", "gg<S-v>G", opts)

--- split windows ---
keymap.set("n", "<leader>sv", "<C-w>v", opts)
keymap.set("n", "<leader>sh", "<C-w>s", opts)
keymap.set("n", "<leader>se", "<C-w>=", opts)

--- do not yank with x ---
keymap.set("n", "x", '"_x', opts)

--- clear highlight search ---
keymap.set("n", "<leader>ch", ":nohl<CR>", opts)

--- paste without yanking ---
keymap.set("v", "p", '"_dP', opts)
