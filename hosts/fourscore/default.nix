# Host-specific configuration for fourscore (Framework laptop)
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
  ];

  networking.hostName = "fourscore";

  # Bluetooth (Framework laptop)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Firmware updates for Framework laptop
  services.fwupd.enable = true;

  # Power management for better battery life
  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;
}
