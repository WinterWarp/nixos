{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.r4dronebot;

  defaultPackage = pkgs.python312.pkgs.buildPythonApplication {
    pname = "r4-drone-bot";
    version = "0.1.0";
    src = ./R4DroneBot;
    format = "other";

    propagatedBuildInputs = with pkgs.python312.pkgs; [
      python-telegram-bot
      google-genai
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp main.py $out/bin/r4-drone-bot
      chmod +x $out/bin/r4-drone-bot
    '';
  };
in
{
  options.services.r4dronebot = {
    enable = lib.mkEnableOption "R4DroneBot Telegram bot service";

    package = lib.mkOption {
      type = lib.types.package;
      default = defaultPackage;
      defaultText = lib.literalExpression "pkgs.r4dronebot";
      description = "The r4dronebot package to use";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "r4dronebot";
      description = "User account under which the bot runs";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "r4dronebot";
      description = "Group under which the bot runs";
    };

    environmentFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        Path to an environment file containing secrets (e.g., API tokens).
        Should contain lines like:
          TELEGRAM_BOT_TOKEN=your_token_here
          GOOGLE_API_KEY=your_key_here
      '';
    };

    workingDirectory = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Working directory for the bot (if it needs to access local files)";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.user} = lib.mkIf (cfg.user == "r4dronebot") {
      isSystemUser = true;
      group = cfg.group;
      description = "R4DroneBot service user";
    };

    users.groups.${cfg.group} = lib.mkIf (cfg.group == "r4dronebot") { };

    systemd.services.r4dronebot = {
      description = "R4DroneBot Telegram Bot";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${cfg.package}/bin/r4-drone-bot";
        Restart = "always";
        RestartSec = 5;

        # Security hardening
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        MemoryDenyWriteExecute = true;
        LockPersonality = true;
      }
      // lib.optionalAttrs (cfg.environmentFile != null) {
        EnvironmentFile = cfg.environmentFile;
      }
      // lib.optionalAttrs (cfg.workingDirectory != null) {
        WorkingDirectory = cfg.workingDirectory;
      };
    };
  };
}
