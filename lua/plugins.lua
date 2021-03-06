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
	use 'kyazdani42/nvim-web-devicons'
	use 'kyazdani42/nvim-tree.lua'

	-- indentLine
	use 'Yggdroot/indentLine'

	-- lualine (status line)
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	-- Autocomplete
	use 'hrsh7th/nvim-compe'

	-- snippets
	use 'hrsh7th/vim-vsnip'
	use 'cstrap/python-snippets'
	use 'ylcnfrht/vscode-python-snippet-pack'
	use "rafamadriz/friendly-snippets"

	-- lsp configs collection
	use 'neovim/nvim-lspconfig'

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
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
	use {
    'vimwiki/vimwiki',
    branch = 'dev'
	}

	-- auto close html tags
	use 'alvan/vim-closetag'

	-- show colors in css
	use 'norcalli/nvim-colorizer.lua'

	-- show git info of lines
	use 'airblade/vim-gitgutter'

	-- markdown syntax highlight
	use 'plasticboy/vim-markdown'

	-- surrund text with symbols easily
	use 'tpope/vim-surround'

	-- Task manager
	use {
		'tools-life/taskwiki',
		requires = {
			{'powerman/vim-plugin-AnsiEsc'},
			{'preservim/tagbar'},
			{'blindFS/vim-taskwarrior'}
		}
	}

	-- quick fix list and location list toggle
  use 'Valloric/ListToggle'

	-- show lsp diagnostics, references, telescope results, ...
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
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
  use 'mindriot101/vim-yapf'

  -- plugin for fish scripts
  use 'dag/vim-fish'

  -- csv files plugin
  use 'chrisbra/csv.vim'

  -- rainbow brackets
  use 'p00f/nvim-ts-rainbow'

  -- gruvbox color scheme
  use 'morhetz/gruvbox'

  -- lspsaga
  use 'glepnir/lspsaga.nvim'

  -- lsp typescript utils
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = 'jose-elias-alvarez/null-ls.nvim'
  }

  -- git worktree
  use 'ThePrimeagen/git-worktree.nvim'

  -- close buffer without closing window
  use 'qpkorr/vim-bufkill'

  -- Copilot
  use 'github/copilot.vim'

  -- edit remote files
  use 'zenbro/mirror.vim'

end)
