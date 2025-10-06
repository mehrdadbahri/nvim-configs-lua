--Bootstraping packer
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	execute 'packadd packer.nvim'
end

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- nvim tree
	use 'nvim-tree/nvim-web-devicons'
	use 'nvim-tree/nvim-tree.lua'

	-- indentLine
	use 'Yggdroot/indentLine'

	-- lualine (status line)
	use {
		'hoob3rt/lualine.nvim',
		requires = {'nvim-tree/nvim-web-devicons', opt = true}
	}

	-- Autocomplete
	use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'

	-- snippets
	use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
	use 'cstrap/python-snippets'
	use 'ylcnfrht/vscode-python-snippet-pack'
	use "rafamadriz/friendly-snippets"

	-- lsp configs collection
	use 'neovim/nvim-lspconfig'

	-- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }
	use 'nvim-telescope/telescope-fzy-native.nvim'

	-- autopairs
	use'windwp/nvim-autopairs'

	-- emmet (quick html code)
	use 'mattn/emmet-vim'

	-- fugitive (Git wrapper)
	use 'tpope/vim-fugitive'

	-- commenting plugin
	use 'preservim/nerdcommenter'

	-- Vimwiki
	--use {
  --  'vimwiki/vimwiki',
  --  branch = 'dev'
	--}

	-- auto close html tags
	use 'alvan/vim-closetag'

	-- show colors in css
	use 'norcalli/nvim-colorizer.lua'

	-- show git info of lines
	use 'airblade/vim-gitgutter'

	-- markdown syntax highlight
	--use 'plasticboy/vim-markdown'

	-- surrund text with symbols easily
	use 'tpope/vim-surround'

	-- Task manager
	--use {
	--  'tools-life/taskwiki',
	--  requires = {
	--    {'powerman/vim-plugin-AnsiEsc'},
	--    {'preservim/tagbar'},
	--    {'blindFS/vim-taskwarrior'}
	--  }
	--}

	-- quick fix list and location list toggle
  use 'Valloric/ListToggle'

	-- show lsp diagnostics, references, telescope results, ...
	use {
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function() require("trouble").setup {} end
	}

	-- repeat plugin maps
	use 'tpope/vim-repeat'

  -- nvim-treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'

  -- CtrlP fuzzy finder
  use 'kien/ctrlp.vim'

  -- plugin for yapf
  use 'amirali/yapf.nvim'

  -- plugin for fish scripts
  use 'dag/vim-fish'

  -- csv files plugin
  use 'chrisbra/csv.vim'

  -- rainbow brackets
  -- use 'p00f/nvim-ts-rainbow'

  -- gruvbox color scheme
  use 'ellisonleao/gruvbox.nvim'

  -- lspsaga
  use ({
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
        require('lspsaga').setup({})
    end,
  })

  -- lsp typescript utils
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = 'nvimtools/none-ls.nvim'
  }

  -- git worktree
  use 'ThePrimeagen/git-worktree.nvim'

  -- close buffer without closing window
  use 'qpkorr/vim-bufkill'

  -- Copilot
  use 'github/copilot.vim'

  -- edit remote files
  use 'zenbro/mirror.vim'

  -- Flutter tools
  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}

  -- lsp format
  use 'lukas-reineke/lsp-format.nvim'

  -- lsp code actions in popup menu
  use 'weilbith/nvim-code-action-menu'

  -- Icons
  use 'ryanoasis/vim-devicons'

  -- markdown preview
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  }

  use 'yuchanns/phpfmt.nvim'

  -- better quickfix  window
  use {'kevinhwang91/nvim-bqf'}

  -- Distraction-free coding for Neovim
  use 'folke/zen-mode.nvim'

  -- Prettier plugin for Neovim's built-in LSP client
  use 'MunifTanjim/prettier.nvim'

  -- vscode-like pictograms for neovim lsp completion items
  use 'onsails/lspkind.nvim'

  -- auto close html tags
  use 'windwp/nvim-ts-autotag'

  -- formatter plugin
  use 'stevearc/conform.nvim'

  -- syntax highlighting for Blade templates (Laravel)
  use 'jwalton512/vim-blade'

  -- Debug Adapter Protocol client
  use 'mfussenegger/nvim-dap'
  use 'nvim-telescope/telescope-dap.nvim'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use 'theHamsta/nvim-dap-virtual-text'

  -- Go debugger (delve)
  use 'leoluz/nvim-dap-go'

  -- Go tools
  use {
    "olexsmir/gopher.nvim",
    requires = { -- dependencies
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  }

  -- Python debugger
  use 'mfussenegger/nvim-dap-python'

  -- Java lsp
  use 'mfussenegger/nvim-jdtls'


  -- search and add Java/Kotlin dependencies
  use {
    'Iamnotagenius/mvnsearch.nvim',
    --rocks = {
    --  -- It is important to specify this version since the latest version of xml2lua on luarocks
    --  -- has some bugs, see https://github.com/manoelcampos/xml2lua/issues/87
    --  'xml2lua 1.5-1'
    --}
  }

  -- database tool
  use {
    'tpope/vim-dadbod',
    requires = {
      'kristijanhusak/vim-dadbod-ui',
      'kristijanhusak/vim-dadbod-completion',
    }
  }

  -- UI for messages, cmdline and the popupmenu
  use {
    'folke/noice.nvim',
    requires = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    }
  }

  -- Obsidian notes
  use {
    "epwalsh/obsidian.nvim",
    tag = "*",  -- recommended, use latest release instead of latest commit
    requires = {
      -- Required.
      "nvim-lua/plenary.nvim",
      {
        "epwalsh/pomo.nvim",
        tag = "*",  -- Recommended, use latest release instead of latest commit
      }
    }
  }

  -- Text objects for treesitter
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = "nvim-treesitter/nvim-treesitter",
  }

  -- Neotest
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      --"antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-python",
      "kenunq/django-neotest",
    }
  }

  -- Taskwarrior
  --use("ribelo/taskwarrior.nvim")

  -- Task time tracker
  use {
    "3rd/time-tracker.nvim",
    requires = {
      "3rd/sqlite.nvim",
    }
  }

  -- oil.nvim
  use "stevearc/oil.nvim"

  -- file operations using built-in LSP
  use {
    "antosha417/nvim-lsp-file-operations",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
  }

  -- Highlight, list and search todo comments in your projects
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  -- Copilot chat
  use {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
  }

  -- IDE-like breadcrumbs, out of the box
  use({
    'Bekaboo/dropbar.nvim',
    requires = {
      'nvim-telescope/telescope-fzf-native.nvim'
    }
  })

  -- Incremental LSP renaming
  use "smjonas/inc-rename.nvim"

  -- highlighter for log files
  use 'fei6409/log-highlight.nvim'

  -- Easily follow markdown links
  use 'jghauser/follow-md-links.nvim'

  -- DAP for js/ts
  use 'mxsdev/nvim-dap-vscode-js'

  -- A playwright adapter for neotest
  use 'thenbe/neotest-playwright'

end)

