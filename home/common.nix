# Shared home-manager configuration for all machines
{ config, pkgs, ... }:

{
  imports = [ ../dconf.nix ];

  home.username = "r4";
  home.homeDirectory = "/home/r4";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    vscode-fhs
    google-chrome
    wget
    curl
    fd
    vrcx
    telegram-desktop
    todoist-electron
    discord
    spotify
    nh
    xournalpp
    godot
    gimp
    antigravity
    devenv
    comma
    android-studio
    stella
    blender
    audacity
    vlc
  ];

  programs = {
    gemini-cli = {
      enable = true;
    };
    gnome-shell = {
      enable = true;
      extensions = [
        { package = pkgs.gnomeExtensions.blur-my-shell; }
        { package = pkgs.gnomeExtensions.gsconnect; }
        { package = pkgs.gnomeExtensions.vitals; }
      ];
    };
    claude-code = {
      enable = true;
      enableMcpIntegration = true;
    };
    starship.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        bindkey '^[[1;5D' backward-word
        bindkey '^[[1;5C' forward-word
      '';
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        mini-nvim
      ];

      initLua = ''
        require("mini.basics").setup()
        require("mini.statusline").setup()
        require("mini.completion").setup()
        require("mini.comment").setup()
        require("mini.surround").setup()
        require("mini.git").setup()
        require("mini.tabline").setup()
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
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
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

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
