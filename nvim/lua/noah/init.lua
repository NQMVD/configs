vim.loader.enable()
require 'noah.packer'
require 'noah.remap'
require 'noah.set'
local colors = {
    bg       = "#191927",
    fg       = "#cdd6f4",
    cyan     = "#89dceb",
    black    = "#181825",
    gray     = "#313244",
    magenta  = "#cba6f7",
    pink     = "#f5c2e7",
    red      = "#f38ba8",
    green    = "#a6e3a1",
    yellow   = "#f9e2af",
    blue     = "#89b4fa",
    orange   = "#fab387",
}
local catp = {
    normal = {
        a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg }
    },
    insert = {
        a = { bg = colors.green, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg }
    },
    visual = {
        a = { bg = colors.magenta, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.black }
    },
    replace = {
        a = { bg = colors.red, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg }
    },
    command = { -- minecraft command blocks hehe
        a = { bg = colors.orange, fg = colors.black, gui = 'bold' },
        b = { bg = colors.gray, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.black }
    },
    inactive = {
        a = { bg = colors.black, fg = colors.fg, gui = 'bold' },
        b = { bg = colors.black, fg = colors.fg },
        c = { bg = colors.black, fg = colors.fg }
    }
}

require('nvim-tree').setup()
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = catp,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filename' },
        lualine_c = { 'branch', 'diff', 'diagnostics' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'filetype', 'progress' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

require('tabby.tabline').set(function(line)
    local theme = {
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        fill = { bg='#1e1e2e' },--'TabLineFill',
        head = 'TabLine',
        current_tab = { fg=colors.fg, bg=colors.gray }, --'TabLineSel',
        tab = 'TabLine',
        win = 'TabLine',
        tail = 'TabLine',
    }
    return {
        {
            { '  ', hl = theme.head },
            line.sep('', theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
                line.sep('', hl, theme.fill),
                -- tab.is_current() and '' or '󰆣',
                tab.number(),
                ' ', tab.name(), ' ',
                tab.close_btn(''),
                line.sep('', hl, theme.fill),
                hl = hl,
                margin = ' ',
            }
        end),
        line.spacer(),
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
                line.sep('', theme.win, theme.fill),
                win.is_current() and '' or '',
                win.buf_name(),
                line.sep('', theme.win, theme.fill),
                hl = theme.win,
                margin = ' ',
            }
        end),
        {
            line.sep('', theme.tail, theme.fill),
            { '  ', hl = theme.tail },
        },
        hl = theme.fill,
    }
end)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd.colorscheme 'catppuccin'
