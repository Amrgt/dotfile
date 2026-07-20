return {
  { "akinsho/bufferline.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
    },
    opts = {
      explorer = {
        enabled = false,
      },
      -- aerospace grabs <M-h> globally, so rebind toggle_hidden to <C-h>
      -- (Ghostty's kitty keyboard protocol keeps it distinct from <BS>)
      picker = {
        win = {
          input = {
            keys = {
              ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            },
          },
        },
      },
    },
  },
}
