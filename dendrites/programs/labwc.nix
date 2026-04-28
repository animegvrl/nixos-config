{ pkgs, lib, ... }:
{
    # gtk.css theme for librewolf and other apps
    home.file =
    let
        css = ''
            * {
                border-radius: 0;
            }

            decoration {
                border: 2px solid #00ff00;
            }

            decoration:backdrop {
                border: 2px solid #111111;
            }
        '';
    in
    {
        # TODO: maybe open an issue on this not working with extraCss
        ".config/gtk-3.0/gtk.css".text = css;
        ".config/gtk-4.0/gtk.css".text = css;

        # openbox (+labwc exclusive options) theme for labwc
        ".config/labwc/themerc-override".text = ''
            border.width: 2
            menu.border.width: 0

            # disable title bar
            # needs font.size for ActiveWindow and InactiveWindow to be 0 in labwc
            window.button.height: 0

            window.active.border.color: #00ff00
            window.inactive.border.color: #111111

            window.active.title.bg.color: #000000
            window.inactive.title.bg.color: #000000

            window.active.label.text.color: #ffffff
            window.inactive.label.text.color: #ffffff

            menu.items.bg.color: #000000
            menu.items.text.color: #ffffff
        '';
    };

    wayland.windowManager.labwc =
    {
        enable = true;
        # xwayland.enable = true;

        autostart =
        [
            "${lib.getExe pkgs.wlr-randr} --output DP-1 --mode 1920x1080@239.964005"
        ];

        environment = [
            # should make electron less laggy
            "GBM_BACKEND=nvidia-drm"
            "__GLX_VENDOR_LIBRARY_NAME=nvidia"
            # fixes librewolf dialogs crashing librewolf
            # "MOZ_ENABLE_WAYLAND=0"

            # "XDG_CURRENT_DESKTOP=labwc:wlroots"
            # "XKB_DEFAULT_LAYOUT=us"
            # WLR_XWAYLAND=

            # QT_QPA_PLATFORM=wayland
            # XDG_CURRENT_DESKTOP=sway
            # XDG_SESSION_DESKTOP=sway

            # QT_WAYLAND_FORCE_DPI=physical
            # QT_WAYLAND_DISABLE_WINDOWDECORATION=1
            "SDL_VIDEODRIVER=wayland"
            # _JAVA_AWT_WM_NONREPARENTING=1
        ];

        rc =
        {
            core =
            {
                gap = 1;
                adaptiveSync = "no";
                allowTearing = "yes";
                # TODO: reuseOutputMode, try to figure out flicker free tty
            };
            theme =
            {
                # name = "Aura Midnight";
                cornerRadius = 0;
                font =
                [
                    {
                        place = "ActiveWindow";
                        name = "Unifont";
                        size = 0;
                    }
                    {
                        place = "InactiveWindow";
                        name = "Unifont";
                        size = 0;
                    }
                ];
            };
            windowRules =
            {
                windowRule =
                [
                    {
                        identifier = "com.obsproject.Studio";
                        action =
                        {
                            name = "Iconify";
                        };
                    }
            #         {
            #             identifier = "*";
            #             action =
            #             {
            #                 name = "SetDecorations";
            #                 decorations = "full";
            #             };
            #         }
                ];
            };
            resize = { popupShow = "Always"; };
            keyboard =
            {
                numlock = "on";
                repeatRate = 80;
                repeatDelay = 200;
                keybind =
                [
                    {
                        key = "W-Tab";
                        action = { name = "NextWindow"; };
                    }
                    {
                        key = "W-S-Tab";

                        action = { name = "PreviousWindow"; };
                    }
                    {
                        key = "W-Grave";
                        action =
                        {
                            name = "Execute";
                            command = "foot";
                        };
                    }
                    {
                        key = "W-r";
                        action =
                        {
                            name = "Execute";
                            command = "fuzzel";
                        };
                    }
                    {
                        key = "W-e";
                        action =
                        {
                            name = "Execute";
                            command = "foot yazi";
                        };
                    }
                    {
                        key = "W-Backspace";
                        action = { name = "Iconify"; };
                    }
                    {
                        key = "W-q";
                        action = { name = "Close"; };
                    }
                    {
                        key = "W-S-q";
                        action = { name = "Kill"; };
                    }
                    {
                        key = "W-C-S-A-q";
                        action = { name = "Exit"; };
                    }
                    {
                        key = "W-C-S-A-r";
                        action =
                        {
                            name = "Execute";
                            command = "${lib.getExe pkgs.wlr-randr} --output DP-1 --mode 1920x1080@239.964005";
                        };
                    }
                    {
                        key = "W-f";
                        action = { name = "ToggleMaximize"; };
                    }
                    {
                        key = "W-S-f";
                        action = { name = "ToggleFullscreen"; };
                    }
                    {
                        key = "Print";
                        action =
                        {
                            name = "Execute";
                            command = "${lib.getExe pkgs.hyprshot} --freeze --mode region --output-folder ~/Pictures/Screenshots";
                        };
                    }
                ];
            };
            mouse =
            {
                # default = true;
                context =
                [
                    {
                        name = "Root";
                        mousebind =
                        [
                            {
                                button = "Right";
                                "@action" = "Press";
                                action =
                                {
                                    name = "ShowMenu";
                                    menu = "root-menu";
                                };
                            }
                            # {
                            #     "@button" = "Left";
                            #     "@action" = "Press";
                            #     action = { name = "None"; };
                            # }
                            # {
                            #     "@button" = "Middle";
                            #     "@action" = "Press";
                            #     action = { name = "None"; };
                            # }
                        ];
                    }
                    {
                        name = "Frame";
                        mousebind =
                        [
                            {
                                "@button" = "W-Left";
                                "@action" = "Press";
                                action =
                                [
                                    { name = "Focus"; }
                                    { name = "Raise"; }
                                ];
                            }
                            {
                                "@button" = "W-Left";
                                "@action" = "Drag";
                                action = { name = "Move"; };
                            }
                            {
                                "@button" = "W-Right";
                                "@action" = "Press";
                                action =
                                [
                                    { name = "Focus"; }
                                    { name = "Raise"; }
                                ];
                            }
                            {
                                "@button" = "W-Right";
                                "@action" = "Drag";
                                action = { name = "Resize"; };
                            }
                        ];
                    }
                    {
                        name = "Client";
                        mousebind =
                        [
                            {
                                "@button" = "Left";
                                "@action" = "Press";
                                action =
                                [
                                    { name = "Focus"; }
                                    { name = "Raise"; }
                                ];
                            }
                            {
                                "@button" = "Middle";
                                "@action" = "Press";
                                action =
                                [
                                    { name = "Focus"; }
                                    { name = "Raise"; }
                                ];
                            }
                            {
                                "@button" = "Right";
                                "@action" = "Press";
                                action =
                                [
                                    { name = "Focus"; }
                                    { name = "Raise"; }
                                ];
                            }
                        ];
                    }
                ];
            };
            # TODO: tablet + libinput tablet maybe
            libinput.device = [
                {
                    category = "default";
                    accelProfile = "flat";
                    pointerSpeed = 0.0;
                }
            ];
        };

        menu =
        [
            {
                menuId = "root-menu";
                label = "Root Menu";
                items =
                [
                    {
                        label = "Reconfigure";
                        action = { name = "Reconfigure"; };
                    }
                    {
                        label = "Foot";
                        action =
                        {
                            name = "Execute";
                            command = "foot";
                        };
                    }
                ];
            }
        ];
    };
}
