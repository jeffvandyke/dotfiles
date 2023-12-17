local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- See :help lspconfig-all

-- if you just want default config for the servers then put them in a table
local servers = { "html", "tailwindcss", "cssls", "tsserver", "clangd", "rubocop", "sorbet", "ruby_ls", "pylsp" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

--
-- lspconfig.pyright.setup { blabla}
