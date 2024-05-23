require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "rust_analyzer"},
  automatic_installation = false,
}

-- local lspconfig = require('lspconfig')
-- lspconfig.rust_analyzer.setup {
--   -- Server-specific settings. See `:help lspconfig-setup`
--   settings = {
--     ['rust-analyzer'] = {},
--   },
-- }

-- local lsp_installer = require "nvim-lsp-installer"


-- local DEFAULT_SETTINGS = {
--   -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer", "sumneko_lua" }
--   -- This setting has no relation with the `automatic_installation` setting.
--   ensure_installed = {"sumneko_lua"},

--   -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
--   -- This setting has no relation with the `ensure_installed` setting.
--   -- Can either be:
--   --   - false: Servers are not automatically installed.
--   --   - true: All servers set up via lspconfig are automatically installed.
--   --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
--   --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
--   automatic_installation = true,

--   ui = {
--       -- Whether to automatically check for outdated servers when opening the UI window.
--       check_outdated_servers_on_open = true,

--       -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
--       border = "none",

--       icons = {
--           -- The list icon to use for installed servers.
--           server_installed = "◍",
--           -- The list icon to use for servers that are pending installation.
--           server_pending = "◍",
--           -- The list icon to use for servers that are not installed.
--           server_uninstalled = "◍",
--       },
--       keymaps = {
--           -- Keymap to expand a server in the UI
--           toggle_server_expand = "<CR>",
--           -- Keymap to install the server under the current cursor position
--           install_server = "i",
--           -- Keymap to reinstall/update the server under the current cursor position
--           update_server = "u",
--           -- Keymap to check for new version for the server under the current cursor position
--           check_server_version = "c",
--           -- Keymap to update all installed servers
--           update_all_servers = "U",
--           -- Keymap to check which installed servers are outdated
--           check_outdated_servers = "C",
--           -- Keymap to uninstall a server
--           uninstall_server = "X",
--       },
--   },

--   -- The directory in which to install all servers.
-- --   install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
--   install_root_dir = vim.fn.stdpath("data") .. "/lsp_servers",

--   pip = {
--       -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
--       -- and is not recommended.
--       --
--       -- Example: { "--proxy", "https://proxyserver" }
--       install_args = {},
--   },

--   -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
--   -- debugging issues with server installations.
--   log_level = vim.log.levels.INFO,

--   -- Limit for the maximum amount of servers to be installed at the same time. Once this limit is reached, any further
--   -- servers that are requested to be installed will be put in a queue.
--   max_concurrent_installers = 4,

--   github = {
--       -- The template URL to use when downloading assets from GitHub.
--       -- The placeholders are the following (in order):
--       -- 1. The repository (e.g. "rust-lang/rust-analyzer")
--       -- 2. The release version (e.g. "v0.3.0")
--       -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
--       download_url_template = "https://github.com/%s/releases/download/%s/%s",
--   },
-- }


-- lsp_installer.setup(DEFAULT_SETTINGS)


-- -- lsp_installer.settings({
-- --   ui = {
-- --     icons = {
-- --       server_installed = "✓",
-- --       server_pending = "➜",
-- --       server_uninstalled = "✗"
-- --     }
-- --   }
-- -- })

-- local opts = { noremap=true, silent=true }
-- --vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- local on_attach = function(client, bufnr)
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gO', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'go', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<snace>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- end

-- --local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
-- --local config = {
-- --}
-- --
-- --for _, lsp in pairs(servers) do
-- --  require('lspconfig')[lsp].setup(config);
-- --end



-- -- lsp_installer.on_server_ready(function(server)
-- --   local config = {
-- --     on_attach = on_attach,
-- --     flags = {
-- --       debounce_text_changes = 150,
-- --     }
-- --   }
-- --   server:setup(config)
-- -- end)
