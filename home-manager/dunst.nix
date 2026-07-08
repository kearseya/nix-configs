{pkgs, ...}: {
  services.dunst = {
    enable = true;
    package = pkgs.dunst;

    settings = {
      global = {
        monitor = 0;
        follow = "mouse"; # shows on whichever monitor your mouse is on

        width = 300;
        height = 300;
        origin = "top-right";
        offset = "10x50";

        scale = 0;
        notification_limit = 5;

        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;

        indicate_hidden = "yes";
        transparency = 10;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 2;
        frame_color = "#8EC07C";
        separator_color = "frame";
        sort = "yes";

        font = "JetBrainsMono Nerd Font 10";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 30;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";

        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 64;

        sticky_history = "yes";
        history_length = 20;

        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst:";
        browser = "${pkgs.xdg-utils}/bin/xdg-open";

        always_run_script = true;
        title = "Dunst";
        class = "Dunst";

        corner_radius = 8;
        ignore_dbusclose = false;

        force_xwayland = false;
        force_xinerama = false;

        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      urgency_low = {
        background = "#282828";
        foreground = "#EBDBB2";
        timeout = 5;
      };

      urgency_normal = {
        background = "#282828";
        foreground = "#EBDBB2";
        timeout = 8;
      };

      urgency_critical = {
        background = "#282828";
        foreground = "#FB4934";
        frame_color = "#FB4934";
        timeout = 0; # stays until dismissed — good for your timer's finish alert
      };
    };
  };
}
