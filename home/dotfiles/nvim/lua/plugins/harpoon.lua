return {
  "ThePrimeagen/harpoon",
  keys = function()
    local keys = {
      {
        "<leader>a",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<C-e>",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
      {
        "<C-n>",
        function()
          local harpoon = require("harpoon")
          harpoon:list():next({
            ui_nav_wrap = true,
          })
        end,
        desc = "Harpoon Next File",
      },
      {
        "<C-p>",
        function()
          local harpoon = require("harpoon")
          harpoon:list():prev({
            ui_nav_wrap = true,
          })
        end,
        desc = "Harpoon Previous File",
      },
    }

    return keys
  end,
}
