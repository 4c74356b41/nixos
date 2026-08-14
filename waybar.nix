{ config, lib, pkgs, isLaptop, ... }: 

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
      }

      window#waybar {
        background-color: #181825;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      window#waybar.hidden {
        opacity: 0.5;
      }

      #language {
        border-radius: 0;
        margin: 6px 3px;
        padding: 6px 12px;
        color: #181825;
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
      }

      #language.us {
        background-color: #f9e2af;
      }

      #language.ru {
        background-color: #fab387;
      }

      #workspaces button {
        all: initial;
        min-width: 0;
        box-shadow: inset 0 -3px transparent;
        padding: 6px 18px;
        margin: 6px 3px;
        border-radius: 0;
        background-color: #1e1e2e;
        color: #cdd6f4;
      }

      #workspaces button.active {
        color: #1e1e2e;
        background-color: #cdd6f4;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: #1e1e2e;
        background-color: #cdd6f4;
      }

      #workspaces button.urgent {
        background-color: #f38ba8;
      }

      #clock {
        border-radius: 0;
        margin: 6px 3px;
        padding: 6px 12px;
        color: #181825;
        font-family: JetBrainsMono Nerd Font;
        background-color: #cba6f7;
      }

      #bluetooth {
        border-radius: 0;
        margin: 6px 3px;
        padding: 6px 12px;
        color: #181825;
        background-color: #89b4fa;
      }

      #bluetooth.disabled {
        background-color: #6c7086;
      }

      #bluetooth.off {
        background-color: #6c7086;
      }

      #bluetooth.on {
        background-color: #89b4fa;
      }

      #bluetooth.connected {
        background-color: #74c7ec;
      }

      #bluetooth.discoverable {
        background-color: #f9e2af;
      }

      #battery {
        border-radius: 0;
        margin: 6px 3px;
        padding: 6px 12px;
        color: #181825;
        background-color: #b9f27c;
      }
      #battery.warning {
        background-color: #f9e2af;
      }
      #battery.critical {
        background-color: #f38ba8;
      }

      /* Tooltip styling */
      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: #131822;
      }

      tooltip label {
        padding: 5px;
        background-color: #131822;
      }

      #network {
        border-radius: 0;
        margin: 6px 3px;
        padding: 6px 12px;
        color: #181825;
        background-color: #94e2d5;
      }

      #network.disconnected {
        background-color: #6c7086;
      }

      #network.disabled {
        background-color: #6c7086;
      }

      #network.wifi {
        background-color: #94e2d5;
      }

      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: #131822;
      }

      tooltip label {
        padding: 5px;
        background-color: #131822;
      }
    '';

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-center = [
          "sway/language"
          "clock"
          "network"
          "bluetooth"
        ] ++ (lib.optional isLaptop "battery");


        "sway/language" = {
          format = "{}";
          format-us = "US";
          format-ru = "RU";
          tooltip = false;
        };

        clock = {
          format = "[{:%a] %H:%M [%d %b}]";
          tooltip = false;
        };

        network = {
          interval = 5;
          family = "ipv4";

          format-wifi = "wifi";
          format-disconnected = "off";
          format-disabled = "off";
          tooltip = false;

          on-click = "${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
          on-click-right = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };

        bluetooth = {
          format-off = "bt";
          format-on = "bt";
          format = "bt";
          tooltip = false;

          on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
          on-click-right = "bluetoothctl power $(bluetoothctl show | grep -q 'Powered: yes' && echo off || echo on)";
        };
      } // (lib.optionalAttrs isLaptop {
          battery = {
            interval = 30;
            format-charging = "▲▲ {capacity}%";
            format-discharging = "{capacity}% ▼▼";
            states = {
              warning = 30;
              critical = 13;
            };
          };
      });
    };
  };
}
