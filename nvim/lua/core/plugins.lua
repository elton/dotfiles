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
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"
  use "tpope/vim-surround"
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

  -- Colorschemes
  -- use 'folke/tokyonight.nvim'
  -- use "shaunsingh/nord.nvim"
  use "marko-cerovac/material.nvim"
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use {
    'David-Kunz/cmp-npm',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
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
  use "RRethy/vim-illuminate" -- automatically highlighting other uses of the current word under the cursor

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
  use "andymass/vim-matchup"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  -- Show git information in neovim
  use "lewis6991/gitsigns.nvim"
  use {
    "kdheepak/lazygit.nvim",
    setup = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 1
      vim.g.lazygit_floating_window_corner_chars = {
        "╭",
        "╮",
        "╰",
        "╯",
      }
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_use_neovim_remote = 1
      if vim.g.lazygit_use_neovim_remote == 1 and vim.fn.executable("nvr") then
        vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
      end
    end,
    cmd = "LazyGit",
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
