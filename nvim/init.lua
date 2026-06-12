-- TODO: status line (lualine.nvim)

local opt = vim.opt
vim.g.mapleader = " "

opt.mouse = "a"
opt.number = true
opt.cursorcolumn = true
opt.cursorline = true
opt.cursorlineopt = "both"
opt.scrolloff = 2
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.updatetime = 250

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.wrap = true
opt.linebreak = true
opt.showbreak = "▶▶━┫"
opt.inccommand = "nosplit"

opt.grepprg = "rg --vimgrep --smart-case"
vim.cmd("cnoreabbrev rg silent grep")
vim.cmd("cnoreabbrev lrg silent lgrep")
vim.api.nvim_create_autocmd("QuickFixCmdPost", { pattern = "grep",  command = "copen" })
vim.api.nvim_create_autocmd("QuickFixCmdPost", { pattern = "lgrep", command = "lopen" })

vim.keymap.set("n", "ZW", ":w<CR>")
vim.keymap.set("n", "<leader>x", ":bd<CR>")

opt.swapfile = false

vim.api.nvim_create_autocmd({ "VimResized" }, {
	pattern = { "*" },
	command = "wincmd =",
})

-- gx: use Neovim 0.10+ built-in vim.ui.open() which calls xdg-open on Linux

-- Instantly save and load
opt.autoread = true
opt.autowriteall = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = { "*" },
	command = ":silent! !",
})
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	pattern = { "*" },
	command = ":silent! update",
})

-- Lazy.nvim bootstrap - see https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Recommended by nvim-tree - https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt / Quickstart setup
-- Disabling - :GBrowse
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

if not vim.g.lazy_did_setup then
	require("lazy").setup("plugins", {
		change_detection = { notify = false },
	})
end

-- Join/split lines using ^A as reversible separator
vim.keymap.set("n", "<leader>[j", ":%s/\\n/\x01/g<CR>:noh<CR>")
vim.keymap.set("v", "<leader>[j", ":s/\\n/\x01/g<CR>:noh<CR>")
vim.keymap.set("n", "<leader>]j", ":%s/\x01/\\r/g<CR>")
vim.keymap.set("v", "<leader>]j", ":s/\x01/\\r/g<CR>")
--[[
./lua/plugins.lua ]]
