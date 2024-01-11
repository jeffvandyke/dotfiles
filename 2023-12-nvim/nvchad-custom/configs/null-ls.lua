local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

    -- webdev stuff
    -- DISABLING - we use prettier here -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
    b.formatting.prettier.with {
        filetypes = {
            "lua",
            "html",
            "markdown",
            "css",
            "json",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "php",
        },
    }, -- so prettier works only on these filetypes

    -- Lua
    b.formatting.stylua,

    -- Python
    b.formatting.black,

    -- cpp
    b.formatting.clang_format,
}

null_ls.setup {
    debug = true,
    sources = sources,
}
