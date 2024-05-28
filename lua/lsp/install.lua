require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

local servers = { "lua_ls", "rust_analyzer", "gopls", "sqls"}

require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = false,
}



local nvim_lsp = require "lspconfig"
local config = {

  settings = {
    sqls = {
      connections = {
        -- {
        --   driver = 'mysql',
        --   dataSourceName = 'root:tiger@tcp(114.55.107.118:3308)/whale-system',
        -- },
        {
          driver = 'mysql',
          dataSourceName = 'root:Obdlianke@2020@tcp(172.16.50.18:3306)/lenkor-erp',
        }
      },
    }
  }
  
}

for _, lsp in pairs(servers) do
  nvim_lsp[lsp].setup(config);
end



require("lsp/java")

