local nvim_lsp = require('lspconfig')
local jdtls = require('jdtls')

local function on_attach(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.setup').add_commands()
    require('jdtls').setup_dap_main_class_configs()
    require('jdtls.ui').pick_one_async()
    require('jdtls.setup').add_lombok_jars()

    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>vws', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>vd', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>vca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>vrr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>vrn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-h>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

local home = os.getenv("HOME")
local workspace_dir = home .. "/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local config = {
    cmd = {
        '/opt/java/jdk-17.0.11/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        "-javaagent:/opt/java/lombok.jar",
        "-Xbootclasspath/a:/opt/java/lombok.jar",
        '-jar', '/opt/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.800.v20240330-1250.jar',
        '-configuration', '/opt/java/jdtls/config_linux',
        '-data', workspace_dir,
    },
    root_dir = nvim_lsp.util.root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
    on_attach = on_attach,


    settings = {
        java = {
            eclipse = {
              downloadSources = true
            },
            configuration = {
                updateBuildConfiguration = 'interactive',
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = "/opt/java/jdk1.8.0_202",
                    },
                    {
                        name = "JavaSE-17",
                        path = "/opt/java/jdk-17.0.11",
                    },
                },
            },
            maven = {
              downloadSources = true
            },
            implementationsCodeLens = {
              enabled = true
            },
            referencesCodeLens = {
              enabled = true
            },
            references = {
              includeDecompiledSources = true
            },
            format = {
              enabled = true
            }
        },
        signatureHelp = {
    
          enabled = true,
        },
        completion = {
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
    },
    init_options = {
        bundles = {}
    },
}

-- jdtls.start_or_attach(config)
nvim_lsp.jdtls.setup(config)