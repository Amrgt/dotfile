-- Options are loaded automatically before lazy.nvim starts up.
-- LazyVim's own defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Anything set here overrides those defaults.

local opt = vim.opt

opt.relativenumber = true
opt.scrolloff = 8
opt.wrap = false

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- No format-on-save: projects keep their own style; format manually with
-- <leader>cf, or re-enable per session with <leader>uf.
vim.g.autoformat = false

-- vim.g.lazyvim_ruby_lsp = "solargraph"
