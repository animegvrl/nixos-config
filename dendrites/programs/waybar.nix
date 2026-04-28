{ ... }:
{
    home.file.".config/waybar/config.jsonc".text = ''
        // -*- mode: jsonc -*-
        {
            // "layer": "top", // Waybar at top layer
            "position": "bottom", // Waybar position (top|bottom|left|right)
            "height": 12, // Waybar height (to be removed for auto height)
            "width": 960, // Waybar width
            "spacing": 0, // Gaps between modules (4px)
            // Choose the order of the modules
            "modules-left": [
                "hyprland/workspaces"
            ],
            "modules-center": [
                "clock"
            ],
            "modules-right": [
                "network",
                "cpu",
                "temperature",
                "memory",
                "tray",
            ],
            "hyprland/workspaces": {
            },
            "tray": {
                // "icon-size": 21,
                "spacing": 1,
                // "icons": {
                //   "blueman": "bluetooth",
                //   "TelegramDesktop": "$HOME/.local/share/icons/hicolor/16x16/apps/telegram.png"
                // }
            },
            "clock": {
                // "timezone": "America/New_York",
                "format-alt": "{:%Y-%m-%d}",
                "tooltip": false,
            },
            "cpu": {
                "format": "",
                "format-critical": "{usage}% CPU EXPLODING. ",
                "states": {
                    "critical": 80,
                },
                "tooltip": false,
            },
            "temperature": {
                // "thermal-zone": 2,
                // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
                "critical-threshold": 80,
                "format": "",
                "format-critical": "{temperatureC}° CPU BURNING. ",
                "tooltip": false,
            },
            "memory": {
                "format": "",
                "tooltip": false,
                "format-critical": "{}% RAM EXPLODING. ",
                "states": {
                    "critical": 80,
                },
            },
            "network": {
                // "interface": "wlp2*", // (Optional) To force the use of this interface
                "format-wifi": "WIRELESS. ",
                "format-ethernet": "WIRED. ",
                "format-linked": "NO IP!!!! ",
                "format-disconnected": "DISCONNECTED!!!! ",
                "tooltip": false,
            },
        }
    '';
    home.file.".config/waybar/style.css".text = ''
        * {
            border: none;
            border-radius: 0;
            font-family: Unifont;
            font-size: 12px;
            min-height: 0;
        }

        window#waybar {
            background: rgba(0, 0, 0, 1);
            color: white;
        }

        tooltip {
          background: rgba(43, 48, 59, 1);
          border: 1px solid rgba(100, 114, 125, 0.5);
        }
        tooltip label {
          color: white;
        }

        #workspaces button {
            padding: 0;
        }
        #workspaces button.active {
            color: #000000;
            background: #00ff00;
        }
    '';
}
