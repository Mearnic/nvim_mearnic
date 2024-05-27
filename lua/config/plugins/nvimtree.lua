-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local nvim_tree = require("nvim-tree")


function telescope_find_files(_)
  start_telescope "find_files"
end

function telescope_live_grep(_)
  start_telescope "live_grep"
end

function start_telescope(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  require("telescope.builtin")[telescope_mode] {
    cwd = basedir,
  }
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<C-g>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'E', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 'V', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 'T', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', '<C-k>', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', '<C-j>', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'n', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-x>', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', '<C-c>', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', '<C-v>', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'yy', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'Y', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '<c-p>', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', '<c-n>', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))

  -- vim.keymap.set('n', '<C-f>', api.live_filter.start, opts('Live Filter: Start'))
  vim.keymap.set('n', '<C-f>', telescope_find_files, opts('Telescope Find File'))
  vim.keymap.set('n', '<C-/>', telescope_live_grep, opts('Telescope Live Grep'))
end

-- OR setup with some options
nvim_tree.setup({
  experimental = {},
  auto_reload_on_write = false,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  sort = {
    sorter = "name",
    folders_first = true,
    files_first = false,
  },
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = true,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  on_attach = my_on_attach,
  select_prompts = false,
  view = {
    adaptive_size = false,
    centralize_selection = true,
    width = 30,
    cursorline = true,
    debounce_delay = 15,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = "name",
    highlight_opened_files = "none",
    root_folder_label = ":t",
    full_name = false,
    indent_width = 2,
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    symlink_destination = true,
    highlight_diagnostics = "none",
    highlight_modified = "none",
    highlight_bookmarks = "none",
    highlight_clipboard = "name",
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,

      web_devicons = {
        file = {
          enable = true,
          color = true,
        },
        folder = {
          enable = false,
          color = true,
        },
      },
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      modified_placement = "after",
      diagnostics_placement = "signcolumn",
      bookmarks_placement = "signcolumn",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
        diagnostics = true,
        bookmarks = true,
      },
      glyphs = {
        -- default = lvim.icons.ui.Text,
        -- symlink = lvim.icons.ui.FileSymlink,
        -- bookmark = lvim.icons.ui.BookMark,
        -- modified = lvim.icons.ui.Circle,
        -- folder = {
        --   arrow_closed = lvim.icons.ui.TriangleShortArrowRight,
        --   arrow_open = lvim.icons.ui.TriangleShortArrowDown,
        --   default = lvim.icons.ui.Folder,
        --   open = lvim.icons.ui.FolderOpen,
        --   empty = lvim.icons.ui.EmptyFolder,
        --   empty_open = lvim.icons.ui.EmptyFolderOpen,
        --   symlink = lvim.icons.ui.FolderSymlink,
        --   symlink_open = lvim.icons.ui.FolderOpen,
        -- },
        git = {
          -- unstaged = lvim.icons.git.FileUnstaged,
          -- staged = lvim.icons.git.FileStaged,
          -- unmerged = lvim.icons.git.FileUnmerged,
          -- renamed = lvim.icons.git.FileRenamed,
          -- untracked = lvim.icons.git.FileUntracked,
          -- deleted = lvim.icons.git.FileDeleted,
          -- ignored = lvim.icons.git.FileIgnored,
          unstaged = '',
          staged = '',
          unmerged = '',
          renamed = '',
          untracked = '',
          deleted = '',
          ignored = '',
        },
      },
    },
  },
  hijack_directories = {
    enable = false,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_root = {
      enable = true,
      ignore_list = {},
    },
    exclude = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    -- severity = {
    --   min = vim.diagnostic.severity.HINT,
    --   max = vim.diagnostic.severity.ERROR,
    -- },
    icons = {
      error = " ",
      warning = " ",
      info = " ",
      hint = " "
    },
  },
  filters = {
    enable = true,
    dotfiles = false,
    git_clean = false,
    git_ignored = false,
    no_bookmark = false,
    no_buffer = false,
    custom = { "node_modules", "\\.cache", "\\.git" },
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    disable_for_dirs = {},
    timeout = 400,
    cygwin_support = false,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },
    open_file = {
      quit_on_open = false,
      eject = true,
      resize_window = false,
      window_picker = {
        enable = true,
        picker = "default",
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "gio trash",
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  tab = {
    sync = {
      open = false,
      close = false,
      ignore = {},
    },
  },
  -- notify = {
  --   threshold = vim.log.levels.INFO,
  --   absolute_path = true,
  -- },
  ui = {
    confirm = {
      remove = true,
      trash = true,
      default_yes = false,
    },
  },
  modified = {
    enable = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  help = {
    sort_by = "key",
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
  system_open = {
    cmd = nil,
    args = {},
  },
})

