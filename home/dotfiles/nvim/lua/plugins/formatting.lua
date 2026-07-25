local function get_web_formatters(bufnr)
  local biome_available = require("conform").get_formatter_info("biome", bufnr).available

  if biome_available then
    return { "biome" }
  else
    return { "prettierd" }
  end
end

return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettierd", "biome" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["javascript"] = get_web_formatters,
        ["javascriptreact"] = get_web_formatters,
        ["typescript"] = get_web_formatters,
        ["typescriptreact"] = get_web_formatters,
        ["vue"] = get_web_formatters,
        ["css"] = get_web_formatters,
        ["scss"] = get_web_formatters,
        ["less"] = get_web_formatters,
        ["html"] = get_web_formatters,
        ["json"] = get_web_formatters,
        ["jsonc"] = get_web_formatters,
        ["yaml"] = get_web_formatters,
        ["markdown"] = get_web_formatters,
        ["graphql"] = get_web_formatters,
        ["lua"] = { "stylua" },
        ["python"] = { "isort", "black" },
      },
      formatters = {
        biome = {
          require_cwd = true,
          command = "biome",
          args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
        },
      },
    },
  },
}
