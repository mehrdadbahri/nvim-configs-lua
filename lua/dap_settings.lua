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
  },
  {
    type = 'python',
    name = 'Django test',
    request = 'launch',
    program = vim.fn.fnamemodify(vim.fn.getcwd() .. '/manage.py', ':p'),
    args = {'test','--noinput','--keepdb','api.tests.TrackerOpenedMailViewTests'},
  },
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

-- Node.js/TypeScript debugging for NestJS
-- Use a working Node.js debugger configuration
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = 4711,
  executable = {
    command = "node",
    args = { "/home/mehrdad/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "--server=4711" },
  }
}

dap.adapters.node = {
  type = "executable",
  command = "node",
  args = { "/home/mehrdad/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js" }
}

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "node",
      request = "launch",
      name = "Launch NestJS App (npm)",
      program = "${workspaceFolder}/src/main.ts",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "npm",
      runtimeArgs = { "run", "start:dev" },
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**" }
    },
    {
      type = "node",
      request = "launch",
      name = "Launch NestJS App (yarn)",
      program = "${workspaceFolder}/src/main.ts",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "yarn",
      runtimeArgs = { "start:dev" },
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**" }
    },
    {
      type = "node",
      request = "launch",
      name = "Debug Current File",
      program = "${file}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**" }
    },
    {
      type = "node",
      request = "launch",
      name = "Launch NestJS App (Production)",
      program = "${workspaceFolder}/dist/main.js",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**" }
    },
    {
      type = "node",
      request = "launch",
      name = "Debug NestJS Tests",
      program = "${workspaceFolder}/node_modules/.bin/jest",
      args = { "--runInBand", "--no-cache" },
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**" }
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to NestJS Process (Port 9229)",
      port = 9229,
      restart = true,
      localRoot = "${workspaceFolder}",
      remoteRoot = "${workspaceFolder}",
      skipFiles = { "<node_internals>/**" }
    },
    {
      type = "node",
      request = "attach",
      name = "Attach to NestJS Process (Port 9230)",
      port = 9230,
      restart = true,
      localRoot = "${workspaceFolder}",
      remoteRoot = "${workspaceFolder}",
      skipFiles = { "<node_internals>/**" }
    },
    {
      type = "node",
      request = "attach",
      name = "Attach to NestJS Process (Port 9231)",
      port = 9231,
      restart = true,
      localRoot = "${workspaceFolder}",
      remoteRoot = "${workspaceFolder}",
      skipFiles = { "<node_internals>/**" }
    }
  }
end

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
