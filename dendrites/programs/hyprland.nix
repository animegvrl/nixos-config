{ pkgs, lib, ... }:
{
    # TODO: move hyprland here after getting rid of homemanager
    home.file.".config/hypr/hyprland.conf".text = ''
        source = ~/.config/hypr/keybinds.conf
        source = ~/.config/hypr/hyprtesting.conf

        ################
        ### MONITORS ###
        ################

        monitor=,preferred,auto,auto
        monitor=DP-1,1920x1080@239.96Hz,auto,auto

        #############################
        ### ENVIRONMENT VARIABLES ###
        #############################

        env = XCURSOR_SIZE,24
        env = HYPRCURSOR_SIZE,24

        # NVIDIA wayland
        env = ELECTRON_OZONE_PLATFORM_HINT,auto
        env = LIBVA_DRIVER_NAME,nvidia
        env = __GLX_VENDOR_LIBRARY_NAME,nvidia
        env = NVD_BACKEND,direct

        #################
        ### AUTOSTART ###
        #################

        exec-once = waybar &
        exec-once = [workspace 10 silent] sleep 7 && obs --startreplaybuffer --minimize-to-tray &

        #####################
        ### LOOK AND FEEL ###
        #####################

        general {
            gaps_in = 1
            gaps_out = 0

            border_size = 2

            # https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
            col.active_border = rgba(00ff00ff)
            col.inactive_border = rgba(595959ff)

            # Set to true enable resizing windows by clicking and dragging on borders and gaps
            resize_on_border = false

            # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
            allow_tearing = true

            layout = scrolling
        }

        decoration {
            rounding = 0
            rounding_power = 0

            shadow:enabled = false
            blur:enabled = false
        }

        animations:enabled = no #yes, please :)

        dwindle {
            pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true # You probably want this
        }

        master {
            new_status = master
        }

        misc {
            force_default_wallpaper = 1 # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = true # If true disables the random hyprland logo / anime girl background. :(
            vrr = 0
            background_color = 0x000000
        }

        #############
        ### INPUT ###
        #############

        input {
            kb_layout = us

            repeat_rate = 80
            repeat_delay = 200

            follow_mouse = 0
            float_switch_override_focus = 0
            mouse_refocus = false

            sensitivity = 0
            accel_profile = flat

            touchpad:natural_scroll = false
        }

        cursor {
            hide_on_key_press = true
            no_warps = true
        }

        gesture = 3, horizontal, workspace

        ##############################
        ### WINDOWS AND WORKSPACES ###
        ##############################

        # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
        # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

        # Example windowrule
        # windowrule = float,class:^(kitty)$,title:^(kitty)$

        # Ignore maximize requests from apps. You'll probably like this.
        windowrule = suppress_event maximize, match:class .*

        # Fix some dragging issues with XWayland
        windowrule = no_focus on,match:class ^$,match:title ^$,match:xwayland 1,match:float 1,match:fullscreen 0,match:pin 0
    '';

    home.file.".config/hypr/keybinds.conf".text = ''
        bind = SUPER, Grave, exec, foot
        bind = SUPER, Q, killactive,
        bind = SUPER CTRL SHIFT ALT, Q, exit,
        bind = SUPER, E, exec, foot yazi
        bind = SUPER, V, togglefloating,
        bind = SUPER, R, exec, fuzzel
        # bind = SUPER, P, pseudo, # dwindle

        # bind = SUPER, J, togglesplit, # dwindle
        bind = , Print, exec, ${lib.getExe pkgs.hyprshot} --freeze --mode region --output-folder ~/Pictures/Screenshots

        # Move focus with mainMod + arrow keys
        bind = SUPER, left, movefocus, l
        bind = SUPER, right, movefocus, r
        bind = SUPER, up, movefocus, u
        bind = SUPER, down, movefocus, d

        # Switch workspaces with mainMod + [0-9]
        bind = SUPER, 1, workspace, 1
        bind = SUPER, 2, workspace, 2
        bind = SUPER, 3, workspace, 3
        bind = SUPER, 4, workspace, 4
        bind = SUPER, 5, workspace, 5
        bind = SUPER, 6, workspace, 6
        bind = SUPER, 7, workspace, 7
        bind = SUPER, 8, workspace, 8
        bind = SUPER, 9, workspace, 9
        bind = SUPER, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = SUPER SHIFT, 1, movetoworkspace, 1
        bind = SUPER SHIFT, 2, movetoworkspace, 2
        bind = SUPER SHIFT, 3, movetoworkspace, 3
        bind = SUPER SHIFT, 4, movetoworkspace, 4
        bind = SUPER SHIFT, 5, movetoworkspace, 5
        bind = SUPER SHIFT, 6, movetoworkspace, 6
        bind = SUPER SHIFT, 7, movetoworkspace, 7
        bind = SUPER SHIFT, 8, movetoworkspace, 8
        bind = SUPER SHIFT, 9, movetoworkspace, 9
        bind = SUPER SHIFT, 0, movetoworkspace, 10

        # Example special workspace (scratchpad)
        # bind = SUPER, S, togglespecialworkspace, magic
        # bind = SUPER SHIFT, S, movetoworkspace, special:magic

        # Scroll through existing workspaces with mainMod + scroll
        # bind = SUPER, mouse_down, workspace, e+1
        # bind = SUPER, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = SUPER, mouse:272, movewindow
        bindm = SUPER, mouse:273, resizewindow

        # Laptop multimedia keys for volume and LCD brightness
        bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
        bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
        bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

        # Requires playerctl
        bindl = , XF86AudioNext, exec, playerctl next
        bindl = , XF86AudioPause, exec, playerctl play-pause
        bindl = , XF86AudioPlay, exec, playerctl play-pause
        bindl = , XF86AudioPrev, exec, playerctl previous
    '';
}
