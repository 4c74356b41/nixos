{ config, pkgs, ... }:
{
  imports = [
    ./waybar.nix
  ];

  home = {
    username = "sway";
    homeDirectory = "/home/sway";
    stateVersion = "26.05";
    packages = with pkgs; [
      foot
      rofi
      grim
      slurp
      wl-clipboard
      thunar
      copyq
      networkmanagerapplet
      networkmanager_dmenu
      blueman
      p7zip
    ];
  };
  programs.bash.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = {
      modifier = "Mod4";
      terminal = "foot";

      menu = "rofi -show combi -combi-modes drun,run -modes combi";

      output = {
        "*" = {
          bg = "#000000 solid_color";
        };
      };

      bars = [];

      startup = [
        { command = "sleep 2 && swaymsg output HDMI-A-1 enable"; }
        { command = "foot"; }
        { command = "foot"; }
        { command = "flatpak run com.visualstudio.code"; }
        { command = "flatpak run org.telegram.desktop"; }
        { command = "flatpak run com.rtosta.zapzap"; }
        { command = "flatpak run org.keepassxc.KeePassXC"; }
        { command = "flatpak run org.mozilla.thunderbird_esr"; }
        { command = "flatpak run flathub org.ksnip.ksnip"; }
        { command = "flatpak run com.microsoft.Edge"; }
        { command = "flatpak run com.brave.Browser";}

        { command = "copyq --start-server"; }
        { command = "blueman-applet"; }
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
      };

      workspaceOutputAssign = [
        { workspace = "1"; output = "HDMI-A-1"; }
        { workspace = "2"; output = "HDMI-A-1"; }
        { workspace = "3"; output = "HDMI-A-1"; }
        { workspace = "4"; output = "HDMI-A-1"; }
        { workspace = "5"; output = "HDMI-A-1"; }
        { workspace = "6"; output = "HDMI-A-1"; }
        { workspace = "7"; output = "HDMI-A-1"; }
        { workspace = "8"; output = "HDMI-A-1"; }
      ];

      assigns = {
        "1" = [ { app_id = "foot"; } ];
        "2" = [ { app_id = "org.telegram.desktop"; } { app_id = "com.rtosta.zapzap"; } ];
        "3" = [ { app_id = "org.keepassxc.KeePassXC"; } { app_id = "org.mozilla.thunderbird_esr"; } { app_id = "org.ksnip.ksnip"; } ];
        "5" = [ { app_id = "code"; } ];
        "6" = [ { app_id = "brave-browser"; } ];
        "7" = [ { app_id = "microsoft-edge"; } ];
        "8" = [ { app_id = "org.gnome.Boxes"; } ];
      };

      floating = {
        criteria = [
          { app_id = "com.github.hluk.copyq"; }
        ];
      };

      # FLOATING MODIFIER
      # floatingModifier = "Mod4";

      bindkeysToCode = true;
      keybindings =
        let
          mod = "Mod4";
          caps = "Mod3";
          menuCommand = "${pkgs.rofi}/bin/rofi -show combi -combi-modes drun,run -modes combi";
        in {
          "${mod}+Shift+F12" = "exec systemctl poweroff";
          "${mod}+Shift+F11" = "exec systemctl reboot";
          "${mod}+Shift+F10" = "exec systemctl suspend";
          "Alt+F4" = "kill";
          "${mod}+Shift+c" = "reload";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "${mod}+Tab" = "workspace next";
          "${mod}+v" = "exec copyq show";
          "${mod}+d" = "exec ${menuCommand}";
          "${mod}+l" = "exec swaylock -C ~/.config/lock/config";
          "${mod}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
          "${caps}+Shift+s" = "exec grim -g \"$(slurp)\" ~/downloads/ss-$(date +%s).png";
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
        };

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
  };
}