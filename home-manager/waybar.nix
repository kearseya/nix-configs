{pkgs, ...}: let
  caffeine = pkgs.writeShellScriptBin "waybar-caffeine" ''
    #!/usr/bin/env bash
    # "on" = caffeinated = hypridle killed = screen won't sleep
    # "off" = normal = hypridle running

    status() {
      if systemctl --user is-active --quiet hypridle.service; then
        echo '{"text": "\uf0f4", "class": "off", "tooltip": "Idle: on (click to keep awake)"}'
      else
        echo '{"text": "\uf0f4", "class": "on", "tooltip": "Caffeinated (click to allow idle)"}'
      fi
    }

    toggle() {
      if systemctl --user is-active --quiet hypridle.service; then
        systemctl --user stop hypridle.service
      else
        systemctl --user start hypridle.service
      fi
    }

    case "$1" in
      status) status ;;
      toggle) toggle ;;
    esac
  '';
in {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar.css;
    settings = [
      {
        layer = "top";
        position = "top";
        mod = "dock";
        exclusive = true;
        passtrough = false;
        gtk-layer-shell = true;
        height = 0;
        modules-left = [
          "hyprland/workspaces"
          "custom/divider"
          "custom/weather"
          "custom/divider"
          "cpu"
          "custom/divider"
          "memory"
        ];
        modules-center = ["hyprland/window"];
        modules-right = [
          "tray"
          "network"
          "custom/divider"
          "backlight"
          "custom/caffeine"
          "custom/divider"
          "pulseaudio"
          "custom/divider"
          "battery"
          "custom/divider"
          "clock"
        ];
        "hyprland/window" = {format = "{}";};
        "wlr/workspaces" = {
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          all-outputs = true;
          on-click = "activate";
        };
        battery = {format = "󰁹 {}%";};
        cpu = {
          interval = 10;
          format = "󰻠 {}%";
          max-length = 10;
          on-click = "";
        };
        memory = {
          interval = 30;
          format = "  {}%";
          format-alt = " {used:0.1f}G";
          max-length = 10;
        };
        backlight = {
          format = "󰖨 {}";
          device = "acpi_video0";
        };
        #"custom/weather" = {
        #  tooltip = true;
        #  format = "{}";
        #  restart-interval = 300;
        #  exec = "/home/roastbeefer/.cargo/bin/weather";
        #};
        tray = {
          icon-size = 13;
          tooltip = false;
          spacing = 10;
        };
        network = {
          format = "󰖩 {essid}";
          format-disconnected = "󰖪 disconnected";
        };
        clock = {
          format = " {:%I:%M %p   %m/%d} ";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = " Muted";
          on-click = "pamixer -t";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
        };
        "pulseaudio#microphone" = {
          format = "{format_source}";
          tooltip = false;
          format-source = " {volume}%";
          format-source-muted = " Muted";
          on-click = "pamixer --default-source -t";
          on-scroll-up = "pamixer --default-source -i 5";
          on-scroll-down = "pamixer --default-source -d 5";
          scroll-step = 5;
        };
        "custom/divider" = {
          format = " | ";
          interval = "once";
          tooltip = false;
        };
        "custom/endright" = {
          format = "_";
          interval = "once";
          tooltip = false;
        };

        "custom/caffeine" = {
          format = "{}";
          return-type = "json";
          exec = "${caffeine}/bin/waybar-caffeine status";
          on-click = "${caffeine}/bin/waybar-caffeine toggle && pkill -RTMIN+8 waybar";
          interval = 5;
        };
      }
    ];
  };
}
