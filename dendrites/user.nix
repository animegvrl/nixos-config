{ nsenv, pkgs, pkgs-unstable-patched, editerm, ... }:
{
    users.users.${nsenv.username} =
    {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "audio"
            "networkmanager"
            "gamemode"
            "libvirtd"
            "docker"
        ];

        packages = with pkgs;
        [
            # browsers
            librewolf
            tor-browser
            servo

            # compositor
            swaylock
            hyprshot
            fuzzel

            # programs
            audacity
            bruno
            coppwr
            zed-editor
            kdePackages.kdenlive
            mpv
            vesktop
            lutris
            dbeaver-bin
            pkgs-unstable-patched.mumble
            syncplay

            # games
            pkgs-unstable-patched.osu-lazer-bin
            prismlauncher

            # cli/tui
            editerm
            pkgs-unstable-patched.yt-dlp
            rclone
            lazygit
            miniserve
            (btop.override
            {
                cudaSupport = true;
            })
        ];
    };

    programs.dconf.profiles.user.databases =
    [
        {
            lockAll = true;
            settings = {
                "org/gnome/desktop/interface" =
                {
                    enable-animations = false;
                    color-scheme = "prefer-dark";
                };
                "org/gnome/desktop/a11y/interface" =
                {
                    reduced-motion = true;
                };
                "org/gnome/desktop/wm/preferences" =
                {
                    button-layout = ":";
                };
            };
        }
    ];
}
