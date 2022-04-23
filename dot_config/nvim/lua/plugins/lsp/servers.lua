local lsp = require('lspconfig')
local U = require('plugins.lsp.utils')

local capabilities = U.capabilities()
local flags = {allow_incremental_sync = true, debounce_text_changes = 200}

-- Configuring native diagnostics
vim.diagnostic.config({
    virtual_text = {source = 'always'},
    float = {source = 'always'}
})

-- Lua
lsp.sumneko_lua.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = function(client, buf)
        U.disable_formatting(client)
        U.mappings(buf)
    end,
    settings = {
        Lua = {
            completion = {
                enable = true,
                showWord = 'Disable'
                -- keywordSnippet = 'Disable',
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                path = U.get_luajit_path()
            },
            diagnostics = {
                globals = {
                    'vim', 'dump', 'use', "awesome", "screen", "tag", "client"
                }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = U.get_nvim_rtp_path()
            }, -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
})

require"lspconfig".html.setup {
    capabilities = capabilities,
    init_options = {
        configurationSection = {"html", "css", "javascript"},
        embeddedLanguages = {css = true, javascript = true}
    }
}

require'lspconfig'.cmake.setup {}

require"lspconfig".clangd.setup {}

require'lspconfig'.vala_ls.setup {}

-- require'lspconfig'.vuels.setup {}

require'lspconfig'.eslint.setup {
    settings = {
        codeActionsOnSave = {
            mode = "all",
            rules = {"!debugger", "!no-only-tests/*"}
        },
        autoFixOnSave = true
    }
}
-- vim.cmd [[ autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll ]]
require('lspconfig').sqls.setup {
    on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
    end
}
-- NOTE: Volar setup
local util = require 'lspconfig.util'

local function get_typescript_server_path(root_dir)
  local project_root = util.find_node_modules_ancestor(root_dir)

  local local_tsserverlib = project_root ~= nil and util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
  local global_tsserverlib = '/home/epsku/.npm/lib/node_modules/typescript/lib/tsserverlibrary.js'

  if local_tsserverlib and util.path.exists(local_tsserverlib) then
    return local_tsserverlib
  else
    return global_tsserverlib
  end
end

require'lspconfig'.volar.setup{
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
  end,
}
