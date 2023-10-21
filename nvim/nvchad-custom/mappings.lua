---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["j"] = "",
    ["k"] = "",
    ["<Up>"] = "",
    ["<Down>"] = "",
    ["<C-c>"] = "",
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
      "Stage Hunk"
    }
  }
}

-- more keybinds!

return M
