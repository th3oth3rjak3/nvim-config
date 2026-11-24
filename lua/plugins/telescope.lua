vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
})

require("telescope").setup({
  defaults = {
    path_display = { "smart" },
  },
})

vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", {
  desc = "Find files",
})
