-- local autocmd = vim.api.nvim_create_autocmd

-- 'Auto' resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local opt = vim.opt

opt.cursorcolumn = true
opt.cursorline = true
opt.cursorlineopt = "both"
opt.scrolloff = 2

opt.tabstop = 4
opt.shiftwidth=4
opt.expandtab = true

opt.wrap = true
opt.linebreak = true
opt.showbreak = "▶▶━┫"
opt.ruler = true
opt.rulerformat="%15(%c%V %p%%%)"

opt.inccommand = "nosplit"

opt.swapfile = false

-- override NvChad to default
opt.cursorlineopt = "both"
opt.clipboard = ""
opt.laststatus = 2
opt.splitbelow = false
opt.splitright = false
opt.fillchars = { eob = "~" }
opt.ignorecase = false
opt.smartcase = false
opt.whichwrap = "b,s"
opt.softtabstop = 0

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

-- Undoes NvChad's effect of clearing CursorLine
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = { "*" },
  command = "highlight link CursorLine CursorColumn",
})
