-- local autocmd = vim.api.nvim_create_autocmd

-- 'Auto' resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local opt = vim.opt

opt.cursorcolumn = true
opt.cursorline = true
opt.scrolloff = 2

opt.wrap = true
opt.linebreak = true
opt.showbreak = "▶▶━┫"
opt.ruler = true

opt.inccommand = "nosplit"

opt.swapfile = false

-- override NvChad to default
opt.clipboard = ""
opt.laststatus = 2
opt.splitbelow = false
opt.splitright = false
opt.fillchars = { eob = "~" }
opt.ignorecase = false
opt.smartcase = false
opt.whichwrap = "b,s"

-- Instantly save and load
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = { "*" },
  command = ":silent! !",
})
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = { "*" },
  command = ":silent! update",
})
opt.autowriteall = true

vim.api.nvim_create_autocmd({ "VimResized" }, {
  pattern = { "*" },
  command = "wincmd =",
})
