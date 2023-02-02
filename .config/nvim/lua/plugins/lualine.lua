-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'ayu',
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {
      'filesize',
      {
        'filename',
          newfile_status = true,
          path = 1,
          symbols = {
            modified = '',      -- Text to show when the file is modified.
            readonly = '',      -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = '',     -- Text to show for newly created file before first write
          }
      },
      'location',
      'progress'
    },
    -- lualine_c = {'encoding', 'fileformat'},
    lualine_x = {'diagnostics', 'filetype'},
    lualine_y = {},
    lualine_z = {'diff', 'branch'},
  },
}

