# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/curvy-l.jxl";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/curvy-d.jxl";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = false;
    };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [
        (mkTuple [
          "xkb"
          "us"
        ])
        (mkTuple [
          "ibus"
          "mozc-jp"
        ])
        (mkTuple [
          "xkb"
          "is"
        ])
      ];
      sources = [
        (mkTuple [
          "xkb"
          "us"
        ])
        (mkTuple [
          "xkb"
          "is"
        ])
        (mkTuple [
          "ibus"
          "mozc-jp"
        ])
      ];
      xkb-options = [ ];
    };

    "org/gnome/desktop/interface" = {
      accent-color = "red";
      clock-format = "12h";
      clock-show-seconds = false;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      speed = -0.1673819742489271;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 0.24786324786324787;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/curvy-l.jxl";
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 19.0;
      night-light-temperature = mkUint32 2151;
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "google-chrome.desktop"
        "todoist.desktop"
        "org.gnome.Nautilus.desktop"
        "spotify.desktop"
        "code.desktop"
        "org.gnome.Console.desktop"
        "org.telegram.desktop.desktop"
        "discord.desktop"
        "com.github.xournalpp.xournalpp.desktop"
      ];
      welcome-dialog-last-shown-version = "49.2";
    };

    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [
        "_memory_usage_"
        "__temperature_avg__"
        "__fan_avg__"
        "_processor_frequency_"
        "_processor_usage_"
      ];
      show-gpu = false;
      show-network = false;
      show-storage = false;
      show-system = true;
      show-voltage = false;
    };
  };
}
