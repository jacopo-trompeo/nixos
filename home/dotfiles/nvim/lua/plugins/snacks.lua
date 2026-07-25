local excluded = {
  "node_modules/",
  ".git/",
  ".next/",
  "dist/",
  "build/",
  "dadbod_ui/tmp/",
  "dadbod_ui/dev/",
  ".vite/",
  "package-lock.json",
  "bun.lock",
  "pnpm-lock.yaml",
  "yarn.lock",
}

return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      hidden = true,
      ignored = true,
      exclude = excluded,
      sources = {
        files = {
          hidden = true,
          ignored = true,
        },
        explorer = {
          hidden = true,
          ignored = true,
          include = excluded,
          layout = {
            layout = {
              position = "right",
            },
          },
        },
      },
    },
  },
}
