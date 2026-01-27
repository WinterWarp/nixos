# Host-specific configuration for lpc (desktop)
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
  ];

  networking.hostName = "lpc";

  services.r4dronebot = {
    enable = true;
    environmentFile = "/etc/nixos/R4DroneBot/env";
  };
}
