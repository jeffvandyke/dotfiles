---@type MappingsTable
local M = {}

M.disabled = {
  i = {
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
  },
  n = {
    ["j"] = "",
    ["k"] = "",
    ["<Up>"] = "",
    ["<Down>"] = "",
    ["<C-c>"] = "",
    ["<A-h>"] = "",
    ["<A-j>"] = "",
    ["<A-k>"] = "",
    ["<A-l>"] = "",
  },
  v = {
    ["j"] = "",
    ["k"] = "",
    ["<Up>"] = "",
    ["<Down>"] = "",
  },
  x = {
    ["j"] = "",
    ["k"] = "",
  },
}

M.general = {
  n = {
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["ZW"] = { ":w<cr>" },
    -- ["<leader>f"]
    ["gx"] = { [[:silent! execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]] },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

M.gitsigns = {
  n = {
    ["<leader>hs"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage Hunk",
    },
  },
}

-- more keybinds!

return M
