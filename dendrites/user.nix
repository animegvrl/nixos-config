{ nsenv, pkgs, pkgs-master-patched, ... }:
{
    users.users.${nsenv.username} =
    {
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" "networkmanager" ];

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
}
