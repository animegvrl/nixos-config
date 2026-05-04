{ nsenv, pkgs, pkgs-master-patched, ... }:
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

            # compositor
            hyprshot
            fuzzel

            # programs
            coppwr
            zed-editor
            kdePackages.kdenlive
            mpv
            vesktop
            lutris

            # games
            pkgs-master-patched.osu-lazer-bin

            # cli/tui
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
