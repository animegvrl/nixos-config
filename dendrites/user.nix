{ nsenv, pkgs, pkgs-unstable-patched, editerm, ... }:
{
    users.users.${nsenv.username} =
    {
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" "networkmanager" "gamemode" ];

        packages = with pkgs;
        [
            # browsers
            librewolf
            tor-browser
            servo

            # compositor
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

            # games
            pkgs-unstable-patched.osu-lazer-bin
            prismlauncher

            # cli/tui
            editerm
            yt-dlp
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
