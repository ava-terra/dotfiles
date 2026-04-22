-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

-- Tmux navigation override (must come after LazyVim defaults)
local nvim_tmux_nav = require("nvim-tmux-navigation")

map("n", "<C-h>", function()
  nvim_tmux_nav.NvimTmuxNavigateLeft()
end, { silent = true, desc = "Navigate left (tmux/nvim)" })
map("n", "<C-j>", function()
  nvim_tmux_nav.NvimTmuxNavigateDown()
end, { silent = true, desc = "Navigate down (tmux/nvim)" })
map("n", "<C-k>", function()
  nvim_tmux_nav.NvimTmuxNavigateUp()
end, { silent = true, desc = "Navigate up (tmux/nvim)" })
map("n", "<C-l>", function()
  nvim_tmux_nav.NvimTmuxNavigateRight()
end, { silent = true, desc = "Navigate right (tmux/nvim)" })
map("n", "<C-\\>", function()
  nvim_tmux_nav.NvimTmuxNavigateLastActive()
end, { silent = true, desc = "Navigate to last active pane" })
