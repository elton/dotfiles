local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "lewis6991/impatient.nvim" -- Speed up loading Lua modules    TODO: figure out how to use this
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "rcarriga/nvim-notify" -- notify
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua" -- file explore
  use "akinsho/bufferline.nvim" -- tab
  -- use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim" -- status line
  use "ahmedkhalf/project.nvim" -- project manager
  use "lukas-reineke/indent-blankline.nvim" -- indent blankline
  -- use "goolord/alpha-nvim" -- welcome page
  -- use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"
  use "kevinhwang91/nvim-bqf" -- better quick fix
  use "folke/todo-comments.nvim" -- todo comments
  -- use "simrat39/symbols-outline.nvim" -- outline
  -- use "stevearc/aerial.nvim"
  use "norcalli/nvim-colorizer.lua" -- show color
  use {
    "phaazon/hop.nvim", -- like easymotion, but more powerful
    branch = "v1", -- optional but strongly recommended
  }
  use "j-hui/fidget.nvim" -- show lsp progress
  use "simeji/winresizer"

  -- wakatime
  use 'wakatime/vim-wakatime'

  -- litee family
  use "ldelossa/litee.nvim" -- a library for building "IDE-lite" experiences in Neovim. }
  use "ldelossa/litee-calltree.nvim"

  -- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists.
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Editor enhance
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "terrortylor/nvim-comment"
  use "Shatur/neovim-session-manager"

  -- Colorschemes
  -- use "marko-cerovac/material.nvim"
  use "shaunsingh/nord.nvim"
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-emoji"
  -- use "jsfaint/gen_tags.vim"
  use "ray-x/cmp-treesitter"
  use "github/copilot.vim" -- Github copilot for nvim. invoke :Copilot setup

  use "ethanholz/nvim-lastplace" -- auto return back to the last modified positon when open a file
  use "nvim-pack/nvim-spectre" -- search and replace pane

  use "tpope/vim-repeat" --  . command enhance
  use "tpope/vim-surround" -- vim surround
  -- use "akinsho/toggleterm.nvim" -- toggle terminal

  -- Snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "kosayoda/nvim-lightbulb" -- code action
  use "ray-x/lsp_signature.nvim" -- show function signature when typing
  use {
    "folke/lsp-colors.nvim",
    config = function()
      require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
      })
    end
  } -- LSP diagnostics highlight groups for color schemes

  use "RRethy/vim-illuminate" -- highlight undercursor word

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-rg.nvim"
  use "MattesGroeger/vim-bookmarks"
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use "nvim-telescope/telescope-dap.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "nvim-treesitter/nvim-treesitter-context"
  -- use "andymass/vim-matchup"
  -- use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Debugger
  use "ravenxrz/DAPInstall.nvim" -- help us install several debuggers
  use "ravenxrz/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  -- use "mfussenegger/nvim-dap-python"    -- debug python
  -- use { "leoluz/nvim-dap-go", module = "dap-go" } -- debug golang
  use { "jbyuki/one-small-step-for-vimkind", module = "osv" } -- debug any Lua code running in a Neovim instance
  -- use {
  --   "sakhnik/nvim-gdb",
  --   run = "./install.sh"
  -- }

  -- Git
  -- Show git information in neovim
  use "lewis6991/gitsigns.nvim"
  use 'sindrets/diffview.nvim'

  -- tools
  use "Pocco81/AutoSave.nvim"
  use "djoshea/vim-autoread"
  use "lewis6991/spellsitter.nvim" -- spell checker
  use "voldikss/vim-translator"
  use "mtdl9/vim-log-highlighting"
  use "vim-test/vim-test"
  use {
    "rcarriga/vim-ultest",
    run = ":UpdateRemotePlugins"
  }
  use { 'michaelb/sniprun', run = 'bash ./install.sh' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
