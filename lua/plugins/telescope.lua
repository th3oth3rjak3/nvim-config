return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  lazy = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    require("telescope").setup({
      defaults = {
        path_display = { "smart" },
      },
    })

    vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", {
      desc = "Find files",
    })
  end,
}
