vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.cmdheight = 2 -- more space in the neovim command line for displaying messages

local function jdtls_on_attach()
  require("jdtls.setup").add_commands()
  require('jdtls').setup_dap()
  require("jdtls.dap").setup_dap_main_class_configs()
  vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
  )
  vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
  )
  vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
  -- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
  vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
  -- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
end

if not packer_plugins['nvim-jdtls'].loaded then
  vim.cmd([[packadd nvim-jdtls]])
end
local config = {}
local root_dir = require("jdtls.setup").find_root({
  ".git", "mvnw", "gradlew", "pom.xml"
})
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/.cache/nvim/workspace/' .. project_name
local bundles = {
  vim.fn.glob(home ..
    "/.local/bin/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
}
local settings = {
  java = {
    contentProvider =
    {
      preferred = "fernflower"
    },
    format = {
      enabled = true,
      onType = true,
      settings = {
        url = "/Users/cunderw/.config/nvim/ftplugin/eclipse-java-google-style.xml",
      },
    },
    inlayHints = {
      parameterNames = {
        enabled = "all", -- literals, all, none
      },
    },
    references = {
      includeDecompiledSources = true,
    },
  },
  signatureHelp = { enabled = true },
}

config.init_options = { bundles = bundles }
config.settings = settings
config.cmd = {
  'java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xms1g',
  '-javaagent:' .. home .. '/.local/bin/lombok.jar',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  "-jar",
  vim.fn.glob(home .. "/.local/bin/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
  "-configuration", vim.fn.glob(home .. "/.local/bin/jdtls/config_linux"),
  "-data", workspace_dir,
}
config.on_attach = jdtls_on_attach
config.root_dir = root_dir
require("jdtls").start_or_attach(config)
