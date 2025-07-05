local dap = require("dap")

-- python
require('dap-python').setup('python')
require('dap').configurations.python = {
  {
    type = 'python',
    name = 'Django',
    request = 'launch',
    program = vim.fn.fnamemodify(vim.fn.getcwd() .. '/manage.py', ':p'),
    args = {'runserver'},
  }
}

-- Go debugger (delve)
require('dap-go').setup {
  dap_configurations = {
    {
      type = 'go';
      name = 'Debug main.go';
      request = 'launch';
      program = '${workspaceFolder}/cmd/executor/main.go';
      cwd = '${workspaceFolder}';
    }
  }
}

-- Kotlin
dap.adapters.kotlin = {
  type = "executable",
  command = "kotlin-debug-adapter",
  options = { auto_continue_if_many_stopped = false },
}
dap.configurations.kotlin = {
  {
    type = "kotlin",
    request = "launch",
    name = "This file",
    -- may differ, when in doubt, whatever your project structure may be,
    -- it has to correspond to the class file located at `build/classes/`
    -- and of course you have to build before you debug
    mainClass = function()
      local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
      local fname = vim.api.nvim_buf_get_name(0)
      -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
      return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
    end,
    projectRoot = "${workspaceFolder}",
    jsonLogFile = "",
    enableJsonLogging = false,
  },
  {
    -- Use this for unit tests
    -- First, run
    -- ./gradlew --info cleanTest test --debug-jvm
    -- then attach the debugger to it
    type = "kotlin",
    request = "attach",
    name = "Attach to debugging session",
    port = 5005,
    args = {},
    projectRoot = vim.fn.getcwd,
    hostName = "localhost",
    timeout = 2000,
  },
}

-- dap-ui
local dapui = require("dapui")
dapui.setup()

-- adds virtual text to show variables values
require('nvim-dap-virtual-text').setup()

vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })

-- dap general setup
dap.listeners.before.attach.dapui_config = function()
 dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
 dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
 dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
 dapui.close()
end

-- fix color issues in output window
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dap-repl",
    command = "setl ft=log"
})
