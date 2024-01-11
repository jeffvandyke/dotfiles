return {
    ----------------------------------------------------------------------------
    -- Shared dependency
    ----------------------------------------------------------------------------
    "nvim-lua/plenary.nvim",

    ----------------------------------------------------------------------------
    -- Basics, file-local
    ----------------------------------------------------------------------------
    "tpope/vim-unimpaired",
    "tpope/vim-abolish",
    "tpope/vim-commentary",
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = true,
    },

    ----------------------------------------------------------------------------
    -- Miscellanous
    ----------------------------------------------------------------------------
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "alexghergh/nvim-tmux-navigation",
        opts = {
            disable_when_zoomed = true,
            keybindings = {
                left = "<A-h>",
                down = "<A-j>",
                up = "<A-k>",
                right = "<A-l>",
            },
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = {
            "*" -- Highlight all files
        }
    },
    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        config = true,
    },

    ----------------------------------------------------------------------------
    -- Multi-file navigation | Telescope
    ----------------------------------------------------------------------------
    {
        "mileszs/ack.vim",
        init = function()
            vim.g.ackprg = "rg --vimgrep"
            vim.keymap.set("n", "<leader>a", ":Ack! ")
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        cmd = 'Telescope',
        dependencies = {
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
            "xiyaowong/telescope-emoji.nvim",
        },
        keys = {
            { "<leader>fT", "<cmd>Telescope<cr>", desc = "Open Telescope" },
            { "<leader>fe", "<cmd>Telescope emoji<cr>", desc = "Find emoji! 😄" },
            { "<leader>fs", "<cmd>Telescope vim_options<cr>", desc = "Telescope vim_options" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find oldfiles" },
            { "<leader>fw", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Find buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "find help tags" },
            { "<leader>gf", "<cmd>Telescope git_files<cr>",  desc = "Telescope Git Files" },
            { "<leader>gh", "<cmd>Telescope git_stash<cr>",  desc = "Telescope Git Stash" },
            { "<leader>gs", "<cmd>Telescope git_status<cr>",  desc = "Telescope Git Status" },
            { "<leader>gc", "<cmd>Telescope git_commits<cr>",  desc = "Telescope Git Commits" },
            { "<leader>gl", "<cmd>Telescope git_bcommits<cr>",  desc = "Telescope Git Buffer Commits (log)" },
            { "<leader>gb", "<cmd>Telescope git_branches<cr>",  desc = "Telescope Git Branches" },
        },
    },

    ----------------------------------------------------------------------------
    -- Git integration
    ----------------------------------------------------------------------------
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true })

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true })

                -- Actions
                map('n', '<leader>hs', gs.stage_hunk, { desc = "GS Stage hunk" })
                map('n', '<leader>hr', gs.reset_hunk, { desc = "GS Reset hunk" })
                map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "GS Stage Hunk (v)" })
                map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "GS Reset Hunk (v)" })
                map('n', '<leader>hS', gs.stage_buffer, { desc = "GS Stage buffer" })
                map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "GS Undo stage hunk" })
                map('n', '<leader>hR', gs.reset_buffer, { desc = "GS Reset buffer" })
                map('n', '<leader>hp', gs.preview_hunk, { desc = "GS Preview hunk" })
                map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "GS blame line" })
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "GS Toggle current line blame" })
                map('n', '<leader>hd', gs.diffthis, { desc = "GS Diffthis" })
                map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "GS Diffthis ~" })
                map('n', '<leader>td', gs.toggle_deleted, { desc = "GS Toggle Deleted" })

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        },
    },

    ----------------------------------------------------------------------------
    -- Tree navigation
    ----------------------------------------------------------------------------
    {
        "nvim-tree/nvim-tree.lua",
        config = true,
        keys = {
            -- { "<Leader>e", "<cmd> NvimTreeFindFile <CR>" },
            -- { "<C-n>", "<cmd> NvimTreeToggle <CR>" },
            { "<Leader>e", "<cmd> NvimTreeFindFile! <CR>" },
        }
    },
    "nvim-tree/nvim-web-devicons",

    ----------------------------------------------------------------------------
    -- LSP - Language Server Protocol
    ----------------------------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/neodev.nvim",
                opts = {},
            },
            {
                "folke/neoconf.nvim",
                opts = {},
            },
            {
                "williamboman/mason.nvim",
            },
            {
                "williamboman/mason-lspconfig.nvim",
            },
        },
        config = function()
            require('mason').setup({
                ensure_installed = {
                    "prettier",
                },
            })
            require('mason-lspconfig').setup({
                    ensure_installed = {
                        "lua_ls",
                        "rust_analyzer",
                        "ruby_ls",
                        "rubocop",
                        "sorbet",
                        "tsserver",
                        "eslint",
                        "tailwindcss",
                        "cssls",
                        "pylsp",
                        "terraformls",
                    },
            })

            local lspconfig = require('lspconfig')
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, { desc = "LSP diagnostic open float" })
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "LSP Goto prev diagnostic" })
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "LSP Goto next diagnostic" })
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = "LSP diagnostic to location list" })

            -- TMP until Mason / other plugins
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        }
                    }
                }
            })
            lspconfig.rust_analyzer.setup({})
            lspconfig.ruby_ls.setup({})
            lspconfig.rubocop.setup({})
            lspconfig.sorbet.setup({})
            lspconfig.tsserver.setup({})
            lspconfig.eslint.setup({})
            lspconfig.tailwindcss.setup({})
            lspconfig.cssls.setup({})
            lspconfig.pylsp.setup({})
            lspconfig.terraformls.setup({})

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    -- CMP: vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
                        { buffer = ev.buf, desc = "LSP Definition" })
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover,
                        { buffer = ev.buf, desc = "LSP Hover" })
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references,
                        { buffer = ev.buf, desc = "LSP References" })
                    vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition,
                        { buffer = ev.buf, desc = "LSP Type Definition" })
                    vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration,
                        { buffer = ev.buf, desc = "LSP Declaration" })
                    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation,
                        { buffer = ev.buf, desc = "LSP Implementation" })
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
                        { buffer = ev.buf, desc = "LSP Signature Help" })
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                        { buffer = ev.buf, desc = "LSP Add Workspace Folder" })
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                        { buffer = ev.buf, desc = "LSP Remove Workspace Folder" })
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, { buffer = ev.buf, desc = "LSP List Workspace Folders" })
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP Rename" })
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
                        { buffer = ev.buf, desc = "LSP Code Action" })
                    vim.keymap.set('n', '<leader>lf', function()
                        vim.lsp.buf.format { async = true }
                    end, { buffer = ev.buf, desc = "LSP Format" })
                end,
            })
        end,
    },

    ----------------------------------------------------------------------------
    -- Copilot tooling
    ----------------------------------------------------------------------------
    {
        "zbirenbaum/copilot.lua",
        -- See https://github.com/zbirenbaum/copilot-cmp for necessary setup
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        }
    },
    {
        -- NOTE: see https://github.com/gptlang/CopilotChat.nvim for setup instruction
        'gptlang/CopilotChat.nvim',
        lazy = false,
        keys = {
            { "<Leader>cc", ":CopilotChat " },
        },
    },

    -- {
    --     "neovim/nvim-lspconfig",
    --     event = "VeryLazy",
    --     config = true
    -- },

    ----------------------------------------------------------------------------
    -- CMP - autocomplete
    ----------------------------------------------------------------------------
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            {
                'zbirenbaum/copilot-cmp',
                config = true
            },
            -- 'hrsh7th/cmp-cmdline',
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = {
                    { name = "copilot", group_index = 2 },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "path" },
                }
            })
        end
    },
}
