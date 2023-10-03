vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeFocus, { desc='Focus Filetree' })
vim.keymap.set('n', '<leader>E', vim.cmd.NvimTreeToggle, { desc='Toggle Filetree' })
vim.keymap.set('n', '<leader>fe', vim.cmd.NvimTreeFindFile, { desc='Locate in Filetree' })

vim.keymap.set('n', '<leader>sc', vim.cmd.Telescope, { desc='Open Telescope' })

-- love2d 
local loveWindowOpen = false
local loveWin,loveBuf = {},{}
local loveCmd = 'love . --console'
local loveLoglevel = 'info'
local loveRun = function()
    local opts = {
        relative = 'editor',
        border = 'rounded',
        width = math.floor(vim.o.columns * 0.6),
        height = math.floor(vim.o.lines  * 0.7),
        col = math.floor(vim.o.columns * 0.2),
        row = math.floor(vim.o.lines   * 0.1),
    }

    vim.cmd':w'
    loveBuf = vim.api.nvim_create_buf(true, true)
    loveWin = vim.api.nvim_open_win(loveBuf, true, opts)

    vim.fn.termopen(loveCmd..loveLoglevel, {
        cwd = vim.fn.getcwd(),
        on_exit = function()
        end,
    })
    loveWindowOpen = true
end
local chooseLoglevel = function()
    local chooseWin = vim.api.nvim_open_win(vim.api.nvim_create_buf(true, true), true,
        {relative='editor',border='double',width=30,height=10,
        col=math.floor(vim.o.columns * 0.2),
        row=math.floor(vim.o.lines   * 0.1)})

    local tmp = vim.fn.termopen('echo "Choose a Log Level:" && gum choose "trace" "debug" "info" "warn" "error" "fatal"', {
        cwd = vim.fn.getcwd(),
        on_exit = function(first, code)
            vim.api.nvim_close_win()
            print(first)
            print(code)
        end
    })
    print(tmp)
end
vim.keymap.set('n', '<leader>lr', loveRun, { desc='Run Love2D' })
vim.keymap.set('n', '<leader>ll', chooseLoglevel, { desc='[WIP] Choose Loglevel' })

vim.keymap.set('n', '<leader>bt', require('barbecue.ui').toggle, { desc='Toggle Path Bar' })

vim.keymap.set('n', '<leader>so', function() vim.cmd.w(); vim.cmd.so() end)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc='Move Selection Down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc='Move Selection Up' })

vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr=true, silent=true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr=true, silent=true })

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', '"_dP', { desc='FIND IN PRIMES VIDEO LOL' })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc='FIND IN PRIMES VIDEO LOL' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc='FIND IN PRIMES VIDEO LOL' })

vim.keymap.set({'n', 'v'}, '<leader>d', '"_d', { desc='Void Deletion' })

vim.keymap.set('n', 'Q', ':q<CR>')
vim.keymap.set('n', '<leader>l', vim.lsp.buf.format, { desc='Format Current Buffer' })

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc='Rename all Occurances' })


vim.keymap.set('n', '<leader>ta', ':$tabnew<CR>', { noremap = true, desc='New Tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, desc='Close Tab' })
vim.keymap.set('n', '<leader>to', ':tabonly<CR>', { noremap = true, desc='Only One Tab' })
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', { noremap = true, desc='Next Tab' })
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', { noremap = true, desc='Prev Tab' })
-- move current tab to previous position
vim.keymap.set('n', '<leader>tmp', ':-tabmove<CR>', { noremap = true, desc='Move Tab Left' })
-- move current tab to next position
vim.keymap.set('n', '<leader>tmn', ':+tabmove<CR>', { noremap = true, desc='Move Tab Right' })
