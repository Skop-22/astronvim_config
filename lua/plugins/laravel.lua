return {
  "adalessa/laravel.nvim",
  dependencies = {
    "tpope/vim-dotenv",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "kevinhwang91/promise-async",
  },
  cmd = { "Laravel" },
  keys = {
    { "<leader>LA", ":Laravel artisan<cr>" },
    { "<leader>LR", ":Laravel routes<cr>" },
  },
  event = { "VeryLazy" },
  opts = {
    features = {
      route_info = {
        enable = true,
        view = "right",
      },
      model_info = {
        enable = true,
      },
      override = {
        enable = true,
      },
      pickers = {
        enable = true,
        provider = 'telescope',
      },
    },
  },
  config = true,
}
