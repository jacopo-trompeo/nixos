vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.lsp.config("lua_ls", {
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

-- nix LSP comes from nixpkgs (shared with Zed); Mason handles everything else
vim.lsp.enable("nil_ls")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local function map(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Definition")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>e", vim.diagnostic.open_float, "Line diagnostics")
  end,
})
