local M = {}

M.treesitter = {
  ensure_installed = {
    "c",
    "css",
    "html",
    "javascript",
    "ledger",
    "lua",
    "markdown",
    "markdown_inline",
    "ruby",
    "tsx",
    "typescript",
    "vim",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- git support in nvimtree
M.nvimtree = {
  -- Jeff V - vim-rhubarb to work
  disable_netrw = false,
  git = {
    enable = true,
  },

  view = {
    width = 40,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
