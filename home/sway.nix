{
  lib,
  pkgs,
  isLaptop,
  ...
}:
let
  mkWorkspaceOutputs =
    outputs:
    lib.flatten (
      lib.mapAttrsToList (
        output: workspaces:
        map (ws: {
          workspace = toString ws;
          inherit output;
        }) workspaces
      ) outputs
    );
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = {
      modifier = "Mod4";
      terminal = "foot";

      menu = "rofi -show combi -combi-modes drun,run -modes combi";

      output =
        (
          if isLaptop then
            {
              "eDP-1" = {
                mode = "1920x1080@60.056Hz";
                position = "760,1440";
              };
              "DP-1" = {
                mode = "3440x1440@99.982Hz";
                position = "0,0";
              };
            }
          else
            {
              "HDMI-A-1" = {
                mode = "3440x1440@99.982Hz";
                position = "0,0";
              };
            }
        )
        // {
          "*" = {
            bg = "#000000 solid_color";
          };
        };

      bars = [ ];

      startup = map (cmd: { command = cmd; }) [
        "foot"
        "foot"
        "code"
        "flatpak run org.telegram.desktop"
        "flatpak run com.rtosta.zapzap"
        "keepassxc"
        "flatpak run org.mozilla.thunderbird_esr"
        "ksnip"
        "exec flatpak run --socket=wayland com.microsoft.Edge --ozone-platform-hint=wayland --enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,WaylandWindowDecorations --ignore-gpu-blocklist --enable-gpu-rasterization --enable-zero-copy"
        "helium"
        "copyq --start-server"
      ];

      input = {
        "type:keyboard" = {
          xkb_layout = "us,ru";
          xkb_options = "grp:win_space_toggle,caps:hyper";
        };
        "type:pointer" = {
          left_handed = "enabled";
          accel_profile = "flat";
          pointer_accel = "0";
          natural_scroll = "disabled";
          scroll_method = "none";
          middle_emulation = "disabled";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          accel_profile = "adaptive";
          left_handed = "enabled";
        };
      };

      workspaceOutputAssign =
        if isLaptop then
          mkWorkspaceOutputs {
            "eDP-1" = lib.range 1 4;
            "DP-1" = lib.range 5 8;
          }
        else
          mkWorkspaceOutputs {
            "HDMI-A-1" = lib.range 1 8;
          };

      assigns = {
        "1" = [ { app_id = "foot"; } ];
        "2" = [
          { app_id = "org.telegram.desktop"; }
          { app_id = "com.rtosta.zapzap"; }
        ];
        "3" = [
          { app_id = "org.keepassxc.KeePassXC"; }
          { app_id = "org.mozilla.thunderbird_esr"; }
        ];
        "4" = [ { app_id = "org.ksnip.ksnip"; } ];
        "5" = [ { app_id = "code"; } ];
        "6" = [ { app_id = "Helium"; } ];
        "7" = [ { app_id = "microsoft-edge"; } ];
        "8" = [ { app_id = "org.gnome.Boxes"; } ];
      };

      floating = {
        criteria = [
          { app_id = "com.github.hluk.copyq"; }
        ];
      };

      bindkeysToCode = true;
      keybindings =
        let
          mod = "Mod4";
          caps = "Mod3";
          menuCommand = "rofi -show combi -combi-modes drun,run -modes combi";
        in
        {
          "${mod}+Shift+F12" = "exec systemctl poweroff";
          "${mod}+Shift+F11" = "exec systemctl reboot";
          "${mod}+Shift+F10" = "exec systemctl suspend";
          "Alt+F4" = "kill";
          "${mod}+Shift+c" = "reload";
          "${mod}+Tab" = "workspace next";
          "${mod}+v" = "exec copyq show";
          "${mod}+d" = "exec ${menuCommand}";
          "${mod}+l" = "exec swaylock -C ~/.config/lock/config";
          "${mod}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
          "${caps}+Shift+s" = "exec grim -g \"$(slurp)\" ~/downloads/ss-$(date +%s).png";
          "${mod}+p" = "exec curl -s ipinfo.io/ip | wl-copy";
          "${mod}+Return" = "exec foot";
          "${mod}+q" = "exec thunar";
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${caps}+q" = "workspace number 5";
          "${caps}+w" = "workspace number 6";
          "${caps}+e" = "workspace number 7";
          "${caps}+r" = "workspace number 8";
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${caps}+Shift+q" = "move container to workspace number 5";
          "${caps}+Shift+w" = "move container to workspace number 6";
          "${caps}+Shift+e" = "move container to workspace number 7";
          "${caps}+Shift+r" = "move container to workspace number 8";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${mod}+f" = "fullscreen";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";
          "${mod}+Shift+minus" = "move scratchpad";
          "${mod}+minus" = "scratchpad show";
          "${mod}+r" = "mode resize";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioPlay" = "exec playerctl play-pause";
        }
        // (lib.optionalAttrs isLaptop {
          "XF86MonBrightnessUp" = "exec brightnessctl s +10%";
          "XF86MonBrightnessDown" = "exec brightnessctl s 10%-";
        });

      modes = {
        resize = {
          Left = "resize shrink width 10px";
          Down = "resize grow height 10px";
          Up = "resize shrink height 10px";
          Right = "resize grow width 10px";
          Return = "mode default";
          Escape = "mode default";
        };
      };
    };
    extraConfig = ''
      bindgesture {
        swipe:4:left exec grim -g "$(slurp)" - | wl-copy
        swipe:4:right exec grim -g "$(slurp)" ~/downloads/ss-$(date +%s).png
        swipe:4:up exec systemctl reboot
        swipe:4:down exec systemctl poweroff
      }
      # Catch Edge's empty tooltip windows: float them, remove borders, snap to mouse, and prevent focus
      for_window [app_id="^$" title="^$"] floating enable, border none
      no_focus [app_id="^$" title="^$"]
    '';
  };
}
