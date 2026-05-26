return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Oil" },
  keys = {
    { "<leader>ee", "<cmd>Oil<CR>", desc = "Open parent directory" },
    { "<leader>ef", "<cmd>Oil --float<CR>", desc = "Open floating file explorer" },
  },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      float = {
        padding = 10,
      },
      keymaps = {
        ["gk"] = "actions.preview",
        ["g."] = "actions.open_cwd",
      },
    })
  end,
}
