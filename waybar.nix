{ config, lib, pkgs, ... }:

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
        border-radius: 4px;
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
        border-radius: 4px;
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
        border-radius: 4px;
        margin: 6px 3px;
        padding: 6px 12px;
        color: #181825;
        font-family: JetBrainsMono Nerd Font;
        background-color: #cba6f7;  /* Distinct purple for clock */
      }

      #bluetooth {
        border-radius: 4px;
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

      #network {
        border-radius: 4px;
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
          "clock"
          "sway/language"
          "network"
          "bluetooth"
        ];
        
        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%a, %d.%m.%Y}";
          tooltip = true;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt>{calendar}</tt>";
        };
        
        "sway/language" = {
          format = "{}";
          format-us = "US";
          format-ru = "RU";
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
          
          on-click = "${pkgs.blueman}/bin/blueman-manager";
          on-click-right = "${pkgs.blueman}/bin/blueman-manager";
        };
      };
    };
  };
}