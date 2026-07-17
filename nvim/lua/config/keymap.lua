-- LazyVim's own defaults (including <leader>gg for lazygit):
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- vim.keymap.set("n", "<leader>rr", "<cmd>!bin/rails routes<cr>", { desc = "Rails routes" })
vim.keymap.set("n", "<leader><delete>", function()
  Snacks.bufdelete()
end, { desc = "Close Buffer" })
vim.keymap.set("n", "<leader><CR>", "<cmd>%bd<cr>", { desc = "Close All Buffers" })

-- smart-splits.nvim: override LazyVim's default <C-hjkl> window nav so it also
-- crosses into tmux panes. Plugin loads eagerly (see plugins/smart-splits.lua),
-- so require() here is safe by the time this file runs on VeryLazy.
local ok, smart_splits = pcall(require, "smart-splits")
if ok then
  vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move to left split/pane" })
  vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move to below split/pane" })
  vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move to above split/pane" })
  vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move to right split/pane" })
end
