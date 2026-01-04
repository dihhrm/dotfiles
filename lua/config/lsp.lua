-- LUA Lsp
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      diagnostics = { globals = { "vim" } },
      completion = { workspaceWord = true, callSnippet = "Both" },
    },
  },
})

-- Vue LSP
--
local vue_language_server_path = vim.fn.stdpath("data")
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = tsserver_filetypes,
}

local vue_ls_config = {}

local caps = vim.lsp.protocol.make_client_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true
local emmet_config = {
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "pug",
    "typescriptreact",
  },
  capabilities = caps,
  cmd = { "emmet-language-server", "--stdio" },
}

vim.lsp.config("vtsls", vtsls_config)
vim.lsp.config("vue_ls", vue_ls_config)
vim.lsp.config("emmet_ls", emmet_config)

-- Enable LSPs
vim.lsp.enable({ "lua_ls", "emmet_ls", "vtsls", "vue_ls", "cssls", "tailwindcss", "eslint", "biome", "html", "pylsp" })
