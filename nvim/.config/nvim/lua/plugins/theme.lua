return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1001,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        -- 🎨 Làm vạch chia sáng rõ hơn
        hl.VertSplit = { fg = c.border_highlight or c.blue, bg = "NONE" }
        hl.WinSeparator = { fg = c.blue, bg = "NONE" }

        -- 🪵 Làm border của Neo-tree rõ hơn
        hl.NeoTreeWinSeparator = { fg = c.blue, bg = "NONE" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
