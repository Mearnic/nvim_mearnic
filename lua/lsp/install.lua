require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

local servers = { "lua_ls", "rust_analyzer"}

require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = false,
}



local nvim_lsp = require "lspconfig"
local config = {


  
}

for _, lsp in pairs(servers) do
  nvim_lsp[lsp].setup(config);
end



require("lsp/java")

