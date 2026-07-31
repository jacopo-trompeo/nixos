local map = vim.keymap.set

map("n", "<C-a>", "ggVG", { desc = "Select all" })

map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })

map("n", "<leader>ch", "<cmd>nohlsearch<cr>", { desc = "Clear highlight" })
map("n", "<leader>q", "<cmd>bd<cr>", { desc = "Close buffer" })

map("n", "x", '"_x')
map("x", "p", '"_dP')
