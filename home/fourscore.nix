# Host-specific home-manager configuration for fourscore
{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  systemd.user.services.feblist = {
    Unit = {
      Description = "FebList Web App";
      After = [ "network.target" ];
    };
    Service = {
      Type = "simple";
      WorkingDirectory = "${config.home.homeDirectory}/Documents/FebList";
      ExecStart = "${pkgs.nodePackages.serve}/bin/serve dist -l 3000";
      Restart = "always";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
