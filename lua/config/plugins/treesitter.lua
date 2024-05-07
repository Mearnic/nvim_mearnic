-- require'nvim-treesitter.configs'.setup {
--   -- One of "all", "maintained" (parsers with maintainers), or a list of languages
--   --  ensure_installed = "maintained",
--   ensure_installed = {"html", "vue", "java", "bash", "go", "yaml", "css", "vim", "lua", "javascript", "typescript"},
--   -- ensure_installed = {},


--   -- Install languages synchronously (only applied to `ensure_installed`)
--   -- sync_install = true,
--   -- 节点选择
--   incremental_selection = {
--     enable = true,
--     keymaps = {
-- --      init_selection = '<CR>',
-- --      node_incremental = '<CR>',
-- --      node_decremental = '<BS>',
-- --      scope_incremental = '<TAB>',
--     }
--   },
-- --  context_commentstring = {
-- --    enable = true
-- --  },

--   -- List of parsers to ignore installing
--   -- ignore_install = { "javascript" },
--   indent = {
--     enable = true
--   },

--   highlight = {
--     -- `false` will disable the whole extension
--     enable = true,

--     -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--     -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--     -- the name of the parser)
--     -- list of language that will be disabled
--     -- disable = {"lua", "c", "rust" },

--     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--     -- Using this option may slow down your editor, and you may see some duplicate highlights.
--     -- Instead of true it can also be a list of languages
--     additional_vim_regex_highlighting = false,
--   },
-- }

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  ensure_installed = {"html", "vue", "java", "bash", "go", "yaml", "css", "vim", "lua", "javascript"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },
  ignore_install = { "" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    disable = {},
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
