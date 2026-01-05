{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "r4";
  home.homeDirectory = "/home/r4";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    vscode-fhs
    google-chrome
    gemini-cli-bin
    wget
    curl
    fd
    vrcx
    telegram-desktop
    notion-app-enhanced
    todoist-electron
    discord
    spotify
    nh
    xournalpp
  ];

  programs = {
    starship.enable = true;
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      # 1. Let Nix handle the heavy lifting (installing plugins)
      plugins = with pkgs.vimPlugins; [
        # The Star of the Show: Mini.nvim
        mini-nvim

        # Treesitter with pre-compiled parsers (Fixes the "compiler not found" bugs)
        (nvim-treesitter.withPlugins (p: [
          p.lua
          p.vim
          p.vimdoc
          p.c
          p.markdown
          p.markdown_inline
        ]))
      ];

      # 2. Your Lua Config (exact same logic, just stripped of Lazy.nvim boilerplate)
      extraLuaConfig = ''
        -- DEFAULTS: "Mini" basics
        require("mini.basics").setup()

        -- MODELINE: Clean and fast
        require("mini.statusline").setup()

        -- COMPLETIONS: Native LSP completion
        require("mini.completion").setup()

        -- EXTRAS: The nice-to-haves
        require("mini.pairs").setup()
        require("mini.files").setup()
        require("mini.pick").setup()

        -- KEYMAPS
        local minipick = require("mini.pick")
        vim.keymap.set("n", "<Leader>f", require("mini.files").open, { desc = "File Manager" })
        vim.keymap.set("n", "<Leader><space>", minipick.builtin.files, { desc = "Find Files" })
        vim.keymap.set("n", "<Leader>/", minipick.builtin.grep_live, { desc = "Grep Live" })
      '';
    };
    eza.enable = true;
    bat.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
		      safe.directory = "/etc/nixos";
		      user.name = "Adam Y. Cole II";
		      user.email = "afewburritos@gmail.com";
	      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
