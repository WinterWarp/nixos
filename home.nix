{ config, pkgs, ... }:

{
  home.username = "r4";
  home.homeDirectory = "/home/r4";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    vscode-fhs
    google-chrome
    gemini-cli-bin
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
  ];

  programs = {
    starship.enable = true;
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

      # 2. Your Lua Config (exact same logic, just stripped of Lazy.nvim boilerplate)
      extraLuaConfig = ''
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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
