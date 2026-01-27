# Shared NixOS configuration for all machines
{ config, pkgs, ... }:

{
  imports = [
    ../r4db.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.networkmanager.enable = true;

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraProfile = ''
        # Fixes timezones on VRChat
        unset TZ
        # Allows Monado to be used
        export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
      '';
    };
  };

  # Set your time zone
  time.timeZone = "America/Chicago";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "is_IS.UTF-8/UTF-8"
  ];

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      mozc
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # Enable CUPS to print documents
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.epson-escpr
    pkgs.epson-escpr2
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account
  users.mutableUsers = false;
  users.users.r4 = {
    isNormalUser = true;
    description = "Adam Y. Cole II";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
    ];
    shell = pkgs.zsh;
    hashedPassword = "$6$oTS9nq.fT8HKHVnT$9vMNuc4H07jL4Rp0yx3zXcODudx5.HTSHpJ0dOPP.hvPvtNEV2bK3G1O4lz870vf5LCNNjVa6MO2bvwpOS5oV.";
  };

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Optimize storage: deduplicate files in /nix/store
  nix.settings.auto-optimise-store = true;

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Disable default command-not-found (replaced by nix-index in home.nix)
  programs.command-not-found.enable = false;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    killall
    vim
    wget
    git
    nixfmt
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-music
    epiphany
    geary
    totem
  ];

  system.stateVersion = "25.11";
}
