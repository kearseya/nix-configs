{
  config,
  pkgs,
  lib,
  inputs,
  environment,
  ...
}: {
  # configuration
  wayland.windowManager.hyprland.settings = {
    # can be made with if but
    cursor.no_hardware_cursors = true;
    monitor = [
      "DP-1, 2560x1440@144, 0x0, 1"
      "HDMI-A-1, 1920x1080@120, 2560x0, 1"
      "HDMI-A-2, 1920x1080@60, 4480x0, 1"
    ];
    workspace = [
      "1,monitor:DP-1"
      "2,monitor:HDMI-A-1"
      "3,monitor:HDMI-A-2"
    ];

    "$mod" = "SUPER";
    "$terminal" = "alacritty";
    "$fileManafer" = "dolphin";
    "$menu" = "rofi -show drun -show-icons";

    general = {
      gaps_in = "5";
      gaps_out = "20";

      border_size = "1";

      "col.active_border" = "rgba(d79921ee) rgba(458588ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      resize_on_border = "false";
      allow_tearing = "false";

      layout = "dwindle";
    };

    decoration = {
      rounding = "10";
      rounding_power = "2";

      active_opacity = "1.0";
      inactive_opacity = "0.95";

      shadow = {
        enabled = "true";
        range = "4";
        render_power = "3";
        color = "rgba(1a1a1aee)";
      };

      blur = {
        enabled = "true";
        size = "3";
        passes = "1";
        vibrancy = "0.1696";
      };
    };

    animations = {
      enabled = "yes, please :)";
      bezier = [
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];
      animation = [
        "global, 1, 10, default"
        "border, 1, 5.4, easeOutQuint"
        "windows, 1, 4.8, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 90%"
        "windowsOut, 1, 1.8, linear, popin 90%"
        "fade, 1, 2, quick"
        "fadeIn, 1, 2, almostLinear"
        "fadeOut, 1, 3, quick"
        "layers, 1, 4, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, quick"
        "layersOut, 1, 2, linear, quick"
        "fadeLayersIn, 1, 2, almostLinear"
        "fadeLayersOut, 1, 2, almostLinear"
        "workspaces, 1, 2, almostLinear, fade"
        "workspacesIn, 1, 1.2, almostLinear, fade"
        "workspacesOut, 1, 2, almostLinear, fade"
      ];
    };

    dwindle = {
      pseudotile = "true";
      preserve_split = "true";
    };

    master = {new_status = "master";};

    misc = {
      force_default_wallpaper = "-1";
      disable_hyprland_logo = "true";
    };

    input = {
      kb_layout = "us";

      follow_mouse = "1";
      sensitivity = "0";

      touchpad = {
        natural_scroll = "false";
      };
    };

    gestures = {
      workspace_swipe = "true";
    };

    bind = [
      "$mod, T, exec, $terminal"
      "$mod, C, killactive"
      "$mod, L, exec, hyprlock"
      "$mod, Q, exit"
      "$mod, B, exec, zen"
      "$mod, V, togglefloating"
      "$mod, F, fullscreen"
      "$mod, R, exec, $menu"
      "$mod, P, pseudo, # dwindlw"
      "$mod, O, togglesplit"

      # focus switching with vim doubles
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"

      #]
      #++ [
      # workspaces
      "$mod, 1, workspace, 1"
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod, 2, workspace, 2"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod, 3, workspace, 3"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod, 4, workspace, 4"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod, 5, workspace, 5"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod, 6, workspace, 6"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod, 7, workspace, 7"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod, 8, workspace, 8"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod, 9, workspace, 9"
      "$mod SHIFT, 9, movetoworkspace, 9"
      #]
      #(
      #  # workspaces
      #  # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      #  builtins.concatLists (builtins.genList (i:
      #      let ws = i + 1;
      #      in [
      #        "$mod, code:1${toString i}, workspace, ${toString ws}"
      #        "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
      #      ]
      #    9)
      #    )
      #)
      #++ [
      # scratchpad
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"

      # scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      "ALT, TAB, cyclenext"
      "ALT, TAB, bringactivetotop"

      "$mod, PRINT, exec, hyprshot -m window"
      ", PRINT, exec, hyprshot -m output"
      "$mod SHIFT, PRINT, exec, hyprshot -m region"
    ];
    bindm = [
      # move and resize with mouse
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    windowrule = [
      "suppressevent, maximize, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
    exec-once = [
      "waybar"
      # "xremap --device /dev/input/event24 ./xremap-config.yml"
      # "hyprpaper"
      #"$terminal"
    ];
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        # Add your Hyprlock configuration here, e.g.,
        disable_loading_bar = true;
        no_fade_in = false;
        hide_cursor = true;
      };
      background = [
        {
          # path = "~/Pictures/Wallpaper/castle-gruv.png";
          # background_color = "#${config.colorScheme.palette.base05}";
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];
      input-field = {
        # Add your Hyprlock input field configuration here, e.g.,
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_centered = true;
        fade_on_empty = false;
        font_color = "#${config.colorScheme.palette.base05}";
        inner_color = "#${config.colorScheme.palette.base01}";
        outer_color = "#${config.colorScheme.palette.base02}";
        fail_color = "#${config.colorScheme.palette.base03}";
        outline_thickness = 5;
        # placeholder_text = '\'<span forground="##${config.colorScheme.palette.base04}">Password...</span>'\';
        shadow_passes = 2;
      };
    };
  };
}
