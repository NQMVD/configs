vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle)
vim.keymap.set('n', '<leader>fe', vim.cmd.NvimTreeFindFile)

vim.keymap.set('n', '<leader>bt', require('barbecue.ui').toggle)

vim.keymap.set('n', '<leader>so', function() vim.cmd.w(); vim.cmd.so() end)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set({'n', 'v'}, '<leader>d', [["_d]])

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<leader>l', vim.lsp.buf.format)

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


vim.keymap.set('n', '<leader>ta', ':$tabnew<CR>', { noremap = true })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true })
vim.keymap.set('n', '<leader>to', ':tabonly<CR>', { noremap = true })
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', { noremap = true })
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', { noremap = true })
-- move current tab to previous position
vim.keymap.set('n', '<leader>tmp', ':-tabmove<CR>', { noremap = true })
-- move current tab to next position
vim.keymap.set('n', '<leader>tmn', ':+tabmove<CR>', { noremap = true })
