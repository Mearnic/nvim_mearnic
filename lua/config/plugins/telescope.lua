require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-q>"] = require('telescope.actions').close,
        ["<C-h>"] = "which_key",

      },
      n = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-q>"] = require('telescope.actions').close,
        ["<C-h>"] = "which_key",

      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    picker_name = {
    }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
--    fzf = {
--      fuzzy = true,                    -- false will only do exact matching
--      override_generic_sorter = true,  -- override the generic sorter
--      override_file_sorter = true,     -- override the file sorter
--      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
--                                       -- the default case_mode is "smart_case"
--    }
    -- please take a look at the readme of the extension you want to configure
  }
}

--require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')

vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>lua require('telescope.builtin').find_files()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-/>", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-e>", "<cmd>lua require('telescope.builtin').buffers()<CR><ESC>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-'>", "<cmd>lua require('telescope.builtin').marks()<CR><ESC>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope projects<CR><ESC>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<F12>", "<cmd>lua require('telescope.builtin').help_tags()<CR>", {noremap = true, silent = true})


