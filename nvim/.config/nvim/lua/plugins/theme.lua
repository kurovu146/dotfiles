return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1001,
    opts = {
      style = "night",

      -- ❌ TẮT hoàn toàn transparent
      transparent = false,

      styles = {
        comments = { italic = true },
        keywords = { italic = true },

        -- Sidebar & float dùng nền chuẩn
        sidebars = "dark",
        floats = "dark",
      },

      -- 🎨 Tinh chỉnh highlight để giống ảnh
      on_highlights = function(hl, c)
        -- Editor
        hl.Normal = { fg = c.fg, bg = c.bg }
        hl.NormalNC = { fg = c.fg, bg = c.bg }
        hl.NormalFloat = { fg = c.fg, bg = c.bg_dark }

        -- Sidebar (Neo-tree, etc.)
        hl.NeoTreeNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar }
        hl.NeoTreeEndOfBuffer = { fg = c.bg_sidebar, bg = c.bg_sidebar }

        -- Separator giống VSCode / ảnh
        hl.WinSeparator = { fg = c.border, bg = c.bg }
        hl.VertSplit = { fg = c.border, bg = c.bg }

        -- Tab / Buffer
        hl.TabLine = { fg = c.comment, bg = c.bg_dark }
        hl.TabLineSel = { fg = c.fg, bg = c.bg }
        hl.TabLineFill = { bg = c.bg_dark }

        -- Terminal
        hl.Terminal = { fg = c.fg, bg = c.bg_dark }
      end,
    },

    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
